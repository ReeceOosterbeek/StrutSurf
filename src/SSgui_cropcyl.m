%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_cropcyl.m      script file
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

%% Getting cylinder values 

h = waitbar(0,'Fitting and unwrapping surface');

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

%% %% Cropping struts to cylinder

% Generating oversampled points within cylinder 

pxsampl = 2;

% Generate XYZ vectors
Xin = -cylrad:(1/pxsampl):cylrad;
Yin = -cylrad:(1/pxsampl):cylrad;
Zin = 0:(1/pxsampl):cylheight;

% Generate list of XY points
reps = length(Xin);
repsZ = length(Zin);

Xin2 = repelem(Xin,reps)';
Yin2 = repmat(Yin',[reps,1]);

% Remove XY points outside cylinder radius
logcl = sqrt((Xin2.^2)+(Yin2.^2)) <= cylrad; 
Xin3 = Xin2(logcl);
Yin3 = Yin2(logcl);

% Generate list of XYZ points within cylinder
repsC = length(Xin3);

Xin4 = repmat(Xin3,[repsZ,1]);
Yin4 = repmat(Yin3,[repsZ,1]);
Zin4 = repelem(Zin,repsC)';


%Transformation of point list according to cylinder transformation

%y rotation
Xin6 = Xin4*cos(ytheta) + Zin4*sin(ytheta);
Yin6 = Yin4;
Zin6 = Zin4*cos(ytheta) - Xin4*sin(ytheta);

%z rotation
Xin7 = Xin6*cos(aztheta) - Yin6*sin(aztheta);
Yin7 = Xin6*sin(aztheta) + Yin6*cos(aztheta);
Zin7 = Zin6;

%XYZ translation
Xin8 = (Xin7+xtrans);
Yin8 = (Yin7+ytrans);
Zin8 = (Zin7+ztrans);

%Rounding to nearest integer to align with pixel values
Xin9 = round(Xin8);
Yin9 = round(Yin8);
Zin9 = round(Zin8);

%Culling duplicate points
%Creates list of all pixels that are within cylinder
pointsincyl = unique([Xin9,Yin9,Zin9],'rows');

%Selecting only points from mesh that are within cylinder
[strutpoints,IA,IB] = intersect(node,pointsincyl,'rows','stable');

% Generating mask of elements to keep
elemndind = ismember(elem,IA);
elemstokeep = and(and(elemndind(:,1),elemndind(:,2)),elemndind(:,3));
newelemsCROP = elem(elemstokeep==1,:);

% Generating mask of nodes to keep
nodeind = ismember([1:length(node)],IA);

% Setting unwanted nodes to NaN
cropnode = node;
cropnode(not(nodeind)) = NaN;

% Removing unused nodes
[nodeRIN,elemRIN]=removeisolatednode(cropnode,newelemsCROP);

nodeCROP = nodeRIN;
newelems = elemRIN;




