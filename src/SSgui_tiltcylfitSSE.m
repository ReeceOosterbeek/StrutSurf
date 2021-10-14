%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_tiltcylfitSSE.m      function file
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


function diff = SSgui_tiltcylfitSSE(params, strutcentred)
% Fits cylinder to data, centred at 0,0,0, with radius, and axis varied
% Axis defined by azimuthal and elevation angles

rad = params(1);
az = params(2);
el = params(3);
fitcent = [params(4) params(5) params(6)];

strutcentred = strutcentred-fitcent;

% Rotate data around z axis to be along x axis 
z_rot = -az;
strutrotx2 = strutcentred(:,1)*cos(z_rot) - strutcentred(:,2)*sin(z_rot);
strutroty2 = strutcentred(:,1)*sin(z_rot) + strutcentred(:,2)*cos(z_rot);
strutrotz2 = strutcentred(:,3);

% Rotate data around y axis to be along x axis
y_rot = -el;
strutrotx3 = strutrotx2*cos(y_rot) + strutrotz2*sin(y_rot);
strutroty3 = strutroty2;
strutrotz3 = strutrotz2*cos(y_rot) - strutrotx2*sin(y_rot);

% Calculate distance from x axis
radialdist = sqrt((strutroty3.^2)+(strutrotz3.^2));

% Calculate deviation from cylinder along x axis
diff = radialdist - rad;
end