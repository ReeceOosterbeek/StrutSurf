%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_mansamp.m      script file
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

%Defining size of sampling volume, ensuring it is even
szsample = 2*ceil(szsample/2);

%Measuring size of cropped stack
szcrop = size(croppedstack);

szsample = min(szsample, min(szcrop));
szsample = 2*floor(szsample/2);

%Ensuring sample volume does not extend beyond data region
manpointx = max(manpointx,(szsample/2));
manpointx = min(manpointx,(szcrop(1)-(szsample/2)));

manpointy = max(manpointy,(szsample/2));
manpointy = min(manpointy,(szcrop(2)-(szsample/2)));

manpointz = max(manpointz,(szsample/2));
manpointz = min(manpointz,(szcrop(3)-(szsample/2)));
