%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_Aplotstrut.m      script file
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

%% SSgui_Aplotlvlstrut
% Plot strut in analysis tab

%%
% Plot to new window if requested
if newwind == 1
    figure
    plotax = axes;
else
    % Otherwise plot to tab axes
    plotax = app.Strutaxes;
    cla(plotax)
    colorbar(plotax, 'off')
end

if app.PlotUmButton.Value
    pxsz = app.PxEditField.Value;
    nodePlot = nodecentred*pxsz;
    deviationsPlot = deviations*pxsz;
    unwrpstrutPlot = unwrpstrut*pxsz;
    linexPl = lineBFx*pxsz;
    lineyPl = lineBFy*pxsz;
    linezPl = lineBFz*pxsz;
else
    nodePlot = nodecentred;
    deviationsPlot = deviations;
    unwrpstrutPlot = unwrpstrut;
    linexPl = lineBFx;
    lineyPl = lineBFy;
    linezPl = lineBFz;
end


hold(plotax, 'on')

% Plot with deviation surface colouring
if app.StrutsurfcolourCheckBox.Value == true;
    trisurf(newelems,nodePlot(:,1),nodePlot(:,2),nodePlot(:,3),deviationsPlot, 'Parent', plotax, 'FaceAlpha',app.SVopacEditField.Value,'EdgeColor','none')
    c = [min(unwrpstrutPlot(:,3)) max(unwrpstrutPlot(:,3))];
    zcolor = colorbar(plotax, 'position',[.83 .7 .05 .24]);
    caxis(plotax, [c]);
else
    % Otherwise plot with standard colours
    colours = [(app.StrutcolREditField.Value/255) (app.StrutcolGEditField.Value/255) (app.StrutcolBEditField.Value/255)];
    trisurf(newelems,nodePlot(:,1),nodePlot(:,2),nodePlot(:,3), 'Parent', plotax, 'FaceColor',colours,'FaceAlpha',app.SVopacEditField.Value,'EdgeColor','none')
end

if app.FitaxisCheckBox.Value == true;
    % Plot strut axis
    plot3(linexPl,lineyPl,linezPl, 'Parent', plotax, 'LineWidth', 1, 'Color', [0.6350 0.0780 0.1840])
end

% Reset plot view
if resetme == 1
    view(plotax, [-37.5,30])
elseif strcmp(app.StrutviewButtonGroup.SelectedObject.Text(1),'X')
    view(plotax, [-90,0])
elseif strcmp(app.StrutviewButtonGroup.SelectedObject.Text(1),'Y')
    view(plotax, [0,0])
elseif strcmp(app.StrutviewButtonGroup.SelectedObject.Text(1),'Z')
    view(plotax, [-90,90])
elseif strcmp(app.StrutviewButtonGroup.SelectedObject.Text(1),'3')
    view(plotax, [-37.5,30])
end

axis(plotax, 'equal')

if app.PlotUmButton.Value
    xlabel(plotax, 'X (µm)')
    ylabel(plotax, 'Y (µm)')
    zlabel(plotax, 'Z (µm)')
    zcolor.Title.String = 'Z (µm)';
else
    xlabel(plotax, 'X')
    ylabel(plotax, 'Y')
    zlabel(plotax, 'Z')
    zcolor.Title.String = 'Z';
end

grid(plotax, 'on')
