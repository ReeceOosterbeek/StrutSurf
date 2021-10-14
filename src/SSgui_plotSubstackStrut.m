%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_plotSubstackStrut.m      script file
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

% SSgui_plotSubstackStrut

%Display on axes, remove previous iterations of struts
hold(app.Subdispaxesmask, 'on')
delete(substackstrutsurf)

% Fetch colours
colours = [(app.StrutcolREditField.Value/255) (app.StrutcolGEditField.Value/255) (app.StrutcolBEditField.Value/255)];

% Plot with handle
substackstrutsurf = trisurf(elem,node(:,1),node(:,2),node(:,3), 'Parent', app.Subdispaxesmask, 'FaceColor',colours,'FaceAlpha',app.StrutcolAEditField.Value,'EdgeColor','none');
xlim(app.Subdispaxesmask, [0 szsample]);
ylim(app.Subdispaxesmask, [0 szsample]);
zlim(app.Subdispaxesmask, [0 szsample]);