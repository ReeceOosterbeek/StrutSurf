%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_ellipticcylfitSSE.m      function file
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

function diff = SSgui_ellipticcylfitSSE(params, radialdist, angrad)
% Fits elliptic cylinder to data, centred at 0,0,0, along x axis
% Semi-major and semi-minor axes varied, as well as ellipse orientation

radfit = params(1);
radfit2 = params(2);
ellipang = params(3);

% Calculate distance from elliptic cylinder axis at given angle
ellipDist = radfit*radfit2 ./ sqrt((radfit2*cos(angrad-ellipang)).^2 + (radfit*sin(angrad-ellipang)).^2);

% Calculate deviation from elliptic cylinder distance
diff = radialdist - ellipDist;
end