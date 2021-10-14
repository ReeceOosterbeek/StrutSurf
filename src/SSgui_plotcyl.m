%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_plotcyl.m      script file
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

%Creating cylinder graphic and positioning

%% Set values 
%rotation angles
aztheta = deg2rad(app.AZSpin.Value);
eltheta = deg2rad(app.ELSpin.Value);
% rotation is defined from vertical cylinder, but elevation is defined from
% horizontal
ytheta = pi/2 - eltheta;

%translation
xtrans = app.TransXSpin.Value;
ytrans = app.TransYSpin.Value;
ztrans = app.TransZSpin.Value;

%cylinder size
cylrad = app.CylradSpin.Value;
cylheight = app.CylhgtSpin.Value;


%% Create geometry
%Create cylinder
[x0,y0,z0] = cylinder(cylrad,20);
z0 = z0*cylheight;

%Create endcaps of cylinder
r = cylrad;
ang = linspace(0, 2*pi,20);
xcirc = r*cos(ang);
ycirc = r*sin(ang);
zcircA = ones(size(ang))*max(z0(:));
zcircB = ones(size(ang))*min(z0(:));


%% Transform geometry

%Transformation of cylinder

%y rotation
x2 = x0*cos(ytheta) + z0*sin(ytheta);
y2 = y0;
z2 = z0*cos(ytheta) - x0*sin(ytheta);

%z rotation
x3 = x2*cos(aztheta) - y2*sin(aztheta);
y3 = x2*sin(aztheta) + y2*cos(aztheta);
z3 = z2;

%XYZ translation
X = (x3+xtrans);
Y = (y3+ytrans);
Z = (z3+ztrans);


%Transformation of cylinder endcaps

%y rotation
xcircA2 = xcirc*cos(ytheta) + zcircA*sin(ytheta);
ycircA2 = ycirc;
zcircA2 = zcircA*cos(ytheta) - xcirc*sin(ytheta);

xcircB2 = xcirc*cos(ytheta) + zcircB*sin(ytheta);
ycircB2 = ycirc;
zcircB2 = zcircB*cos(ytheta) - xcirc*sin(ytheta);

%z rotation
xcircA3 = xcircA2*cos(aztheta) - ycircA2*sin(aztheta);
ycircA3 = xcircA2*sin(aztheta) + ycircA2*cos(aztheta);
zcircA3 = zcircA2;

xcircB3 = xcircB2*cos(aztheta) - ycircB2*sin(aztheta);
ycircB3 = xcircB2*sin(aztheta) + ycircB2*cos(aztheta);
zcircB3 = zcircB2;


%XYZ translation
XcircA = (xcircA3+xtrans);
YcircA = (ycircA3+ytrans);
ZcircA = (zcircA3+ztrans);
XcircB = (xcircB3+xtrans);
YcircB = (ycircB3+ytrans);
ZcircB = (zcircB3+ztrans);


%% Plotting

%Displaying cylinder and endcaps

%Display on strut, remove previous iterations of cylinder
hold(app.Subdispaxesmask, 'on')
delete(cylsurf)
delete(cap1)
delete(cap2)

%Create cylinder surface and display
colours = [(app.CylcolREditField.Value/255) (app.CylcolGEditField.Value/255) (app.CylcolBEditField.Value/255)];
cylsurf = surf('Parent', app.Subdispaxesmask, X,Y,Z,'FaceColor',colours,'FaceAlpha',app.CylcolAEditField.Value);

%Create endcaps and display
cap1 = patch(XcircA,YcircA,ZcircA,colours,'FaceAlpha',app.CylcolAEditField.Value, 'Parent', app.Subdispaxesmask);
cap2 = patch(XcircB,YcircB,ZcircB,colours,'FaceAlpha',app.CylcolAEditField.Value, 'Parent', app.Subdispaxesmask);
