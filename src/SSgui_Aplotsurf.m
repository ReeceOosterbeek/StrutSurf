%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_Aplotsurf.m      script file
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

%% SSgui_Aplotsurf
% Plot surface in analysis tab

%%
% Plot to new window if requested
if newwind == 1
    figure
    plotax = axes;
else
    % Otherwise plot to tab axes
    plotax = app.Strutaxes3;
    cla(plotax)
    colorbar(plotax, 'off')
end


if app.PlotUmButton.Value
    pxsz = app.PxEditField.Value;
    [resampX,resampY] = meshgrid(resampx,resampy);
    xPlot = resampX*pxsz;
    yPlot = resampY*pxsz;
    zPlot = resampZ*pxsz;
else
    [resampX,resampY] = meshgrid(resampx,resampy);
    xPlot = resampX;
    yPlot = resampY;
    zPlot = resampZ;
end

% Plot with deviation surface colouring
colormap(plotax, parula(256));
surf(xPlot,yPlot,zPlot, 'Parent', plotax,'Edgecolor','none')
zcolor = colorbar(plotax, 'position',[.83 .7 .05 .24]);
c = [min(zPlot,[],'all') max(zPlot,[],'all')];
caxis(plotax, [c]);

% Reset plot view
if resetme == 1
    view(plotax, [0,90])
elseif strcmp(app.SurfviewButtonGroup.SelectedObject.Text(1),'X')
    view(plotax, [-90,0])
elseif strcmp(app.SurfviewButtonGroup.SelectedObject.Text(1),'Y')
    view(plotax, [0,0])
elseif strcmp(app.SurfviewButtonGroup.SelectedObject.Text(1),'Z')
    view(plotax, [0,90])
elseif strcmp(app.SurfviewButtonGroup.SelectedObject.Text(1),'3')
    view(plotax, [-37.5,30])
end

axis(plotax, 'equal')
axis(plotax, 'tight')

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


