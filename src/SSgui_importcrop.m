%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_importcrop.m      script file
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

%Finding row and column indices where material is found in scan
[r, c] = find(picsall == 1);

cropmaxr = min(max(r)+buffer , size(picsall,1));
cropminr = max(min(r)-buffer , 1);
cropmaxc = min(max(c)+buffer , size(picsall,2));
cropminc = max(min(c)-buffer , 1);

%Defining size of crop rectangle using material and buffers
heightmsk = cropmaxr-cropminr + 1;
widmsk = cropmaxc-cropminc + 1;

%Cropping all image slices in stack to defined rectangle
h = waitbar(0,'Cropping stack in xy plane...');
j = 1;

%Initialising cropped image stack in 8-bit
croppedstack = zeros(heightmsk,widmsk,numslice,'uint8');

%Cropping each image
for i = 1:numslice
    %Crop single image slice to rectangle
    croppedstack(:,:,j) = imcrop(pics(:,:,j),[cropminc, cropminr, widmsk-1, heightmsk-1]);
    %Progress bar
    waitbar(j/numslice,h)
    j = j+1;
end
close(h)

%Cropping collapsed stack to same rectangle
picsallcrop = imcrop(picsall,[cropminc, cropminr, widmsk-1, heightmsk-1]);

%Calculating corners of crop rectangle
xpoints = [cropminc,cropminc,cropmaxc,cropmaxc,cropminc];
ypoints = [cropminr,cropmaxr,cropmaxr,cropminr,cropminr];

%Finding row and column indices of material in cropped region
[r2, c2] = find(picsallcrop == 1);
%Locating centroid in xy plane
xycentre = [mean(r2), mean(c2)];