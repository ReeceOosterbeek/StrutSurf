%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_analysis.m      script file
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


% Calculations and analysis of strut


% Finding centroid
centroid = mean(strutpoints,1);

% Move to origin
strutcentred = strutpoints - centroid;
nodecentred = nodeCROP - centroid;

%Calculate position of strut and distance to centre
sampleorigin = [(subx-szsample/2),(suby-szsample/2),(subz-szsample/2)];
globalcentroid = sampleorigin+centroid;

centredist = sqrt((globalcentroid(1)-xycentre(1))^2 + (globalcentroid(2)-xycentre(2))^2);

%% Find strut axis

% Need to fit cylinder in order to accurately extract axis

% Initial guess for fit cylinder radius 70% of mask radius
radfit0 = 0.7*cylrad;

% Setting up solver
% Varies cylinder radius and direction, also shifts strut in XYZ to fit
% cylinder

% Allow centroid to vary by 0.7*cylinder mask radius
fcbound = radfit0;

% Set initial guess as 0.7* cylinder mask radius, and cylinder mask
% direction, using calculated points centroid
guess = [radfit0, aztheta, -eltheta, 0, 0, 0];
lb = [0, aztheta-(pi/4), -eltheta-(pi/4), -fcbound, -fcbound, -fcbound];
ub = [cylrad, aztheta+(pi/4), -eltheta+(pi/4), fcbound, fcbound, fcbound];

options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', 'StepTolerance', (10^-12), 'FunctionTolerance', (10^-12));

% Solving for fit cylinder
func2solve = @(params) SSgui_tiltcylfitSSE(params, strutcentred);
fit_out = lsqnonlin(func2solve, guess, lb, ub, options);

% Assign solutions, change azimuthal angle origin back

% radius
radfit_out = fit_out(1);
z_rot = -fit_out(2);
y_rot = -fit_out(3);
% strut axis (best fit line)
[lineBFx, lineBFy, lineBFz] = sph2cart((fit_out(2)),-fit_out(3),1);
lineBF = [lineBFx, lineBFy, lineBFz];
% centroid. Shift centred strut to align with fitted centroid
fitcent = [fit_out(4) fit_out(5) fit_out(6)];
strutrot1 = strutcentred-fitcent;
noderot1 = nodecentred-fitcent;

%Length of best fit line slightly longer than crop cylinder height for plot
BFlength = 1.2*cylheight/2;

lineBFx = BFlength*[lineBF(1);-lineBF(1)];
lineBFy = BFlength*[lineBF(2);-lineBF(2)];
lineBFz = BFlength*[lineBF(3);-lineBF(3)];


%% Find build angle, level strut

% Rotate strut (points and nodes) around z and y axes so best fit line is along x-axis

% z axis
strutrotx2 = strutrot1(:,1)*cos(z_rot) - strutrot1(:,2)*sin(z_rot);
strutroty2 = strutrot1(:,1)*sin(z_rot) + strutrot1(:,2)*cos(z_rot);
strutrotz2 = strutrot1(:,3);

noderotx2 = noderot1(:,1)*cos(z_rot) - noderot1(:,2)*sin(z_rot);
noderoty2 = noderot1(:,1)*sin(z_rot) + noderot1(:,2)*cos(z_rot);
noderotz2 = noderot1(:,3);

% y axis
% also gives build angle/elevation
buildang = abs(rad2deg(y_rot));

strutrotx3 = strutrotx2*cos(y_rot) + strutrotz2*sin(y_rot);
strutroty3 = strutroty2;
strutrotz3 = strutrotz2*cos(y_rot) - strutrotx2*sin(y_rot);

noderotx3 = noderotx2*cos(y_rot) + noderotz2*sin(y_rot);
noderoty3 = noderoty2;
noderotz3 = noderotz2*cos(y_rot) - noderotx2*sin(y_rot);

strutLvl = [strutrotx3,strutroty3,strutrotz3];
nodeLvl = [noderotx3,noderoty3,noderotz3];


%% Radius calculations

% Calculate distance of each point from centre line
radialdist = sqrt((strutLvl(:,2).^2)+(strutLvl(:,3).^2));
radialdistNode = sqrt((nodeLvl(:,2).^2)+(nodeLvl(:,3).^2));

waitbar(0.1,h)

if strcmp(app.Strutfit.Value, 'Cylinder') == 1
    % Fitting and unwrapping cylinder
    SSgui_analysisCYL
    
elseif strcmp(app.Strutfit.Value, 'Elliptic cylinder') == 1
    % Fitting and unwrapping elliptic cylinder
    SSgui_analysisECYL
end



