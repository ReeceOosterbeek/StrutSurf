%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_analysisECYL.m      script file
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


% SSgui analysis elliptic cylinder


%% Fitting elliptic cylinder

% Calculating angle from x-axis
ellangMask = strutLvl(:,3) > 0;
angradA = (pi/2) - atan(strutLvl(:,2)./strutLvl(:,3));
angradB = (3*pi/2) - atan(strutLvl(:,2)./strutLvl(:,3));
angrad = ellangMask.*angradA + not(ellangMask).*angradB;

ellangMaskNode = nodeLvl(:,3) > 0;
angradANode = (pi/2) - atan(nodeLvl(:,2)./nodeLvl(:,3));
angradBNode = (3*pi/2) - atan(nodeLvl(:,2)./nodeLvl(:,3));
angradNode = ellangMaskNode.*angradANode + not(ellangMaskNode).*angradBNode;

% Setting up solver
% vary semi-major and semi-minor radii, and ellipse orientation
guess = [radfit0, radfit0, 0];
lb = [0, 0, -pi/2];
ub = [cylrad, cylrad, pi/2];
options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', 'StepTolerance', (10^-12), 'FunctionTolerance', (10^-12));

% Solving for fit elliptic cylinder
func2solve = @(params) SSgui_ellipticcylfitSSE(params, radialdist, angrad);
fit_out = lsqnonlin(func2solve, guess, lb, ub, options);

% Calculating fit elliptic cylinder
ellipDist = fit_out(1)*fit_out(2) ./ sqrt((fit_out(2)*cos(angrad-fit_out(3))).^2 + (fit_out(1)*sin(angrad-fit_out(3))).^2);

%Calcuating deviations matrix
ellipDistNode = fit_out(1)*fit_out(2) ./ sqrt((fit_out(2)*cos(angradNode-fit_out(3))).^2 + (fit_out(1)*sin(angradNode-fit_out(3))).^2);
deviations = radialdistNode - ellipDistNode;

% Assigning output parameters
radfit_out = max(fit_out(1), fit_out(2));
radfit_out2 = min(fit_out(1), fit_out(2));
ellipRotAng = rad2deg(fit_out(3));



%% Unwrapping surface

% Masking points above xy plane
Amask = strutLvl(:,3)>0;

% x values unchanged
unwrpstrutX = strutLvl(:,1);
% z values are deviation from ellipse
unwrpstrutZ = radialdist - ellipDist;

% Calculate ellipse m parameter
m = (fit_out(1)^2 - fit_out(2)^2)/(fit_out(1)^2);

% Define elliptic integral function
fun = @(int_theta,m) sqrt(1 - m*(sin(int_theta).^2));

waitbar(0.2,h)

% Calculate distance along ellipse circumference at angle using elliptic
% integral. Numerically integrate, as ellipticE function cannot be used in
% compiled app

int_phi = (angrad-fit_out(3))-pi;
for i = 1:length(int_phi)
    unwrpstrutAY(i) = -fit_out(1)*integral(@(int_theta) fun(int_theta,m),0,int_phi(i));
end
waitbar(0.375,h)

int_phi = (pi)-(angrad-fit_out(3));
for i = 1:length(int_phi)
    unwrpstrutBY(i) = fit_out(1)*integral(@(int_theta) fun(int_theta,m),0,int_phi(i));
end
waitbar(0.55,h)

unwrpstrutY = (Amask.*unwrpstrutAY')+(not(Amask).*unwrpstrutBY');
unwrpstrut = [unwrpstrutX unwrpstrutY unwrpstrutZ];

% Masking nodes above xy plane
nodeAmask = nodeLvl(:,3)>0;

% x values unchanged
unwrpnodeX = nodeLvl(:,1);
% z values are deviation from ellipse
unwrpnodeZ = deviations;

% Calculate distance along ellipse circumference at angle using elliptic
% integral. Numerically integrate, as ellipticE function cannot be used in
% compiled app

int_phi = (angradNode-fit_out(3)-pi);
for i = 1:length(int_phi)
    unwrpnodeAY(i) = -fit_out(1)*integral(@(int_theta) fun(int_theta,m),0,int_phi(i));
end
waitbar(0.7,h)

int_phi = ((pi)-(angradNode-fit_out(3)));
for i = 1:length(int_phi)
    unwrpnodeBY(i) = fit_out(1)*integral(@(int_theta) fun(int_theta,m),0,int_phi(i));
end
waitbar(0.85,h)

unwrpnodeY = (nodeAmask.*unwrpnodeAY')+(not(nodeAmask).*unwrpnodeBY');
unwrpnode = [unwrpnodeX unwrpnodeY unwrpnodeZ];

% Detecting nodes near max and min y values
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
waitbar(0.925,h)

%% Resample surface to even XY mesh

SSgui_resampsurf

% Calculate mean and RMS roughness
roughSA = mean(abs(resampZ),'all','omitnan');
roughSQ = sqrt(mean((resampZ).^2,'all','omitnan'));
roughSZ = max(resampZ,[],'all') - min(resampZ,[],'all');


%% Plot fitted cross-section
xsecTH = [0:0.1:(2*pi),0];
xsecR = fit_out(1)*fit_out(2) ./ sqrt((fit_out(2)*cos(xsecTH-fit_out(3))).^2 + (fit_out(1)*sin(xsecTH-fit_out(3))).^2);

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
