%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_randsamp.m      script file
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

%% SSgui_random sample

%Defining size of sampling volume, ensuring it is even
szsample = 2*ceil(szsample/2);

%Measuring size of cropped stack
szcrop = size(croppedstack);
szcropxy = min(szcrop(1), szcrop(2));
szcropz = szcrop(3);

szsample = min(szsample, min(szcrop));
szsample = 2*floor(szsample/2);

%Reinitialize the random number generator
rng('shuffle');

if strcmp(app.Randmethod.Value, 'Cylinder: Cartesian uniform') == 1
    %Generating random number in sample cylinder
    %Generate random angle around centre
    rndtheta = 2*pi*rand();
    %Generate random length along radius, sqrt to ensure random distribution
    %in xy plane
    rndrad = ((szcropxy/2)-(szsample/2))*sqrt(rand());
    %Converting to cartesian coordinates, round
    rndx = round((szcropxy/2)+(rndrad.*cos(rndtheta)));
    rndy = round((szcropxy/2)+(rndrad.*sin(rndtheta)));
    
elseif strcmp(app.Randmethod.Value, 'Cylinder: Radially uniform') == 1
    %Generating random number in sample cylinder
    %Generate random angle around centre
    rndtheta = 2*pi*rand();
    %Generate random length along radius, random distribution along radius
    rndrad = ((szcropxy/2)-(szsample/2))*rand();
    %Converting to cartesian coordinates, round
    rndx = round((szcropxy/2)+(rndrad.*cos(rndtheta)));
    rndy = round((szcropxy/2)+(rndrad.*sin(rndtheta)));
    
elseif strcmp(app.Randmethod.Value, 'Cartesian uniform') == 1
    %Generating random point in image area
    rndx = round(((szcropxy-szsample)*rand()) + (szsample/2));
    rndy = round(((szcropxy-szsample)*rand()) + (szsample/2));
end


%Generating random height along z axis
rndz = ceil(szcropz*rand());
rndz = max(rndz,(szsample/2));
rndz = min(rndz,(szcropz-(szsample/2)));
