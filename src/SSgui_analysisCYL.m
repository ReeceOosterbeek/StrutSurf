%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_analysisCYL.m      script file
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

% SSgui analysis cylinder

%% Fitting cylinder

% Cylinder fitted during strut axis calculation
%Setting ellipse parameters to NaNs
radfit_out2 = NaN;
ellipRotAng = NaN;

%Calcuating deviations matrix
deviations = radialdistNode - radfit_out;

waitbar(0.4,h)

%% Unwrapping surface

% Masking points above xy plane
Amask = strutLvl(:,3)>0;

% x values unchanged
unwrpstrutX = strutLvl(:,1);
% z values are deviation from cylinder
unwrpstrutZ = radialdist - radfit_out;

% y values from unwrapping cylinder from axis
unwrpstrutAY = ((atan(strutLvl(:,2)./strutLvl(:,3)))+(pi/2)) * (radfit_out/pi);
unwrpstrutBY = ((pi/2)-(atan(strutLvl(:,2)./strutLvl(:,3)))) * (-radfit_out/pi);

unwrpstrutA = [unwrpstrutX unwrpstrutAY unwrpstrutZ];
unwrpstrutB = [unwrpstrutX unwrpstrutBY unwrpstrutZ];
unwrpstrut = (Amask.*unwrpstrutA)+(not(Amask).*unwrpstrutB);

waitbar(0.6,h)

% Do the same for nodes

% Masking points above xy plane
nodeAmask = nodeLvl(:,3)>0;

% x values unchanged
unwrpnodeX = nodeLvl(:,1);
% z values are deviation from cylinder
unwrpnodeZ = deviations;

% y values from unwrapping cylinder from axis
unwrpnodeAY = ((atan(nodeLvl(:,2)./nodeLvl(:,3)))+(pi/2)) * (radfit_out);
unwrpnodeBY = ((pi/2)-(atan(nodeLvl(:,2)./nodeLvl(:,3)))) * (-radfit_out);

unwrpnodeA = [unwrpnodeX unwrpnodeAY unwrpnodeZ];
unwrpnodeB = [unwrpnodeX unwrpnodeBY unwrpnodeZ];
unwrpnode = (nodeAmask.*unwrpnodeA)+(not(nodeAmask).*unwrpnodeB);

waitbar(0.8,h)

% Detecting nodes near max and min y values
unwrpnodeY = unwrpnode(:,2);
lowY = unwrpnode(:,2) < 0.9*min(unwrpnode(:,2));
highY = unwrpnode(:,2) > 0.9*max(unwrpnode(:,2));
lowYind = find(lowY == 1);
highYind = find(highY == 1);

% Find mesh elements that use these nodes
newelemsLow = ismember(newelems,lowYind);
newelemsHigh = ismember(newelems,highYind);

newelemsLow = or(or(newelemsLow(:,1),newelemsLow(:,2)),newelemsLow(:,3));
newelemsHigh = or(or(newelemsHigh(:,1),newelemsHigh(:,2)),newelemsHigh(:,3));

% Find mesh elements that use nodes on both sides simultaneously (they
% straddle the line where the strut is "unwrapped"
crosselems = and(newelemsLow,newelemsHigh);

% Remove these elements
unwrpelems = newelems(crosselems==0,:);


%% Resample surface to even XY mesh

SSgui_resampsurf

% Calculate mean and RMS roughness
roughSA = mean(abs(resampZ),'all','omitnan');
roughSQ = sqrt(mean((resampZ).^2,'all','omitnan'));
roughSZ = max(resampZ,[],'all') - min(resampZ,[],'all');

%% Plot fitted cross-section

xsecTH = [0:0.1:(2*pi),0];
xsecR = radfit_out;

xsecY = xsecR.*cos(xsecTH);
xsecZ = xsecR.*sin(xsecTH);
xsecX = repmat(min(unwrpstrutX),1,length(xsecY));


%% Calculate Feret diameters

% Find indices of convex hull points
k = convhull(nodeLvl(:,2),nodeLvl(:,3));
Yconvh = nodeLvl(k,2);
Zconvh = nodeLvl(k,3);

% Determine distances between convex hull points
Ydist = Yconvh - Yconvh';
Zdist = Zconvh - Zconvh';
convhDistances = hypot(Ydist,Zdist);

% Shift points to zero
Yconvh = Yconvh - min(Yconvh);
Zconvh = Zconvh - min(Zconvh);

% Find largest dimension of point set
YZwid = max(max(Yconvh),max(Zconvh));

% Set resolution to 1000 pixels across largest side
res = 1000;
resmultiplier = res / YZwid;

% Transform by scaling up
YconvhTrns = resmultiplier*Yconvh;
ZconvhTrns = resmultiplier*Zconvh;

% Convert convex hull points to binary image
bw = poly2mask(YconvhTrns,ZconvhTrns,ceil(max(ZconvhTrns)),ceil(max(YconvhTrns)));

% Determine Feret properties of binary image
out = bwferet(bw,'all');

% Output Max and Min Feret diameters, rescaling down to correct scale
FerMxMn = [(out.MaxDiameter / resmultiplier) (out.MinDiameter / resmultiplier)];




waitbar(1,h)
close(h)












