%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_resampsurf.m      script file
%
% copyright (c) 2021 Reece Oosterbeek
%
% Reece Oosterbeek <r.oosterbeek at imperial.ac.uk>
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Resampling surface to even mesh

% Sample points generated at every rsPxl (0.5) pixels (upsampled by x2)
rsPxl = 0.5;

% Centre sampling points within span of data
xspan = floor(max(unwrpnode(:,1)) - min(unwrpnode(:,1)));
xspanremainder = max(unwrpnode(:,1)) - min(unwrpnode(:,1)) - xspan;
yspan = floor(max(unwrpnode(:,2)) - min(unwrpnode(:,2)));
yspanremainder = max(unwrpnode(:,2)) - min(unwrpnode(:,2)) - yspan;

% Create sample points in x and y
resampx = min(unwrpnode(:,1))+(xspanremainder/2):rsPxl:max(unwrpnode(:,1))+(xspanremainder/2);
resampy = min(unwrpnode(:,2))+(yspanremainder/2):rsPxl:max(unwrpnode(:,2))+(yspanremainder/2);

% Mesh sampling points and generate empty array for z values
[resampX,resampY] = meshgrid(resampx,resampy);
zvalueResamp = zeros(size(resampX));

% Step through x planes
for ii = 1:length(resampx)
    xplane = resampx(ii);
    
    % Mask mesh nodes on one side of plane
    maskSide = unwrpnode(:,1)>xplane;
    % Calculate no. vertices each mesh element has on one side of plane
    verticesSidePlane = sum(maskSide(unwrpelems),2);
    
    % Elements with 1 or 2 vertices on one side are intersected by plane
    intersectElemsMask = or((verticesSidePlane==1),(verticesSidePlane==2));
    % Select only these elements and nodes
    intersectElems = unwrpelems(intersectElemsMask,:);
    intersectNodes = maskSide(intersectElems);
    
    % Convert elements with 110 to 001 so all are the same
    mirrorMask = sum(intersectNodes,2) == 2;
    intersectNodes(mirrorMask,:) = 1-intersectNodes(mirrorMask,:);
    
    % Set up arrays to store intersection points (where xplane crosses
    % element edges)
    numXelems = size(intersectNodes,1);
    interpoints1 = zeros(numXelems,3);
    interpoints2 = zeros(numXelems,3);
    interpoints1(:,1) = xplane;
    interpoints2(:,1) = xplane;
    
    % Find where xplane crosses each element
    j = 1;
    for i=1:numXelems
        
        % Find vertex and other node point positions in array
        xelemvertex_pos = find(intersectNodes(i,:));
        xelemp1_pos = mod(xelemvertex_pos,3) +1;
        xelemp2_pos = mod(xelemvertex_pos+1,3) +1;
        
        % Find XYZ values of these points
        xelemvertex = unwrpnode(intersectElems(i,xelemvertex_pos),:);
        xelemp1 = unwrpnode(intersectElems(i,xelemp1_pos),:);
        xelemp2 = unwrpnode(intersectElems(i,xelemp2_pos),:);
        
        % Find proportion along edge 1 in x, use to interpolate y and z
        % values
        interpDist = (xplane-xelemvertex(1)) / (xelemp1(1)-xelemvertex(1));
        interpoints1(i,[2:3]) = xelemvertex(2:3) + interpDist*(xelemp1(2:3)-xelemvertex(2:3));
        % Do the same for edge 2
        interpDist = (xplane-xelemvertex(1)) / (xelemp2(1)-xelemvertex(1));
        interpoints2(i,[2:3]) = xelemvertex(2:3) + interpDist*(xelemp2(2:3)-xelemvertex(2:3));
        %j = j+1;
    end
    
    % interpoints1 array contains nx3 list of XYZ values of points where
    % xplane crosses mesh
    % interpoints2 contains the corresponding points on the other side of
    % the same element
    
    % Reshape into 2xN arrays of y and z points, where each column contains
    % points for the line across a single mesh element
    meshSliceY = NaN(2,numXelems);
    meshSliceY(1,:) = interpoints1(:,2)';
    meshSliceY(2,:) = interpoints2(:,2)';
    meshSliceZ = NaN(2,numXelems);
    meshSliceZ(1,:) = interpoints1(:,3)';
    meshSliceZ(2,:) = interpoints2(:,3)';
    
    % Resample mesh cross-section to even sampling over y
    for i = 1:length(resampy)
        ysamppoint = resampy(i);
        
        % Generate mask of lines that cross the y sampling point
        ycross = mod(sum((meshSliceY-ysamppoint)>0,1),2);
        
        % Extract zpoints of these lines
        zpoints = meshSliceZ(:,ycross==1);
        
        % Check for values
        if isempty(zpoints)==1
            zvalueResamp(i,ii) = NaN;
        else
            % Extract y points of lines that cross y sampling point
            ycrosspoints = meshSliceY(:,ycross==1);
            
            % Find proportion along line in x, use to interpolate z
            linInterp = (ysamppoint-ycrosspoints(1,:)) ./ (ycrosspoints(2,:)-ycrosspoints(1,:));
            % If multiple mesh elements cross y sampling point, there will
            % be multiple interpolated z values. Choose the largest of
            % these to view upper surface rather than overhangs
            zvalueResamp(i,ii) = max(zpoints(1,:) + linInterp.*(zpoints(2,:)-zpoints(1,:)));
        end
    end
    
end


% Subtract mean plane so roughness can be calculated
resampZ = zvalueResamp - mean(zvalueResamp,'all','omitnan');
