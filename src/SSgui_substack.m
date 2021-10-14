%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_substack.m      script file
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

%% SSgui_substack

% Generating smaller substack around sampled point

h = waitbar(0,'Creating sub-region...');

%Initialising stack of volume samples
sampstack = zeros(szsample,szsample,szsample);

j = 1;
%Generating top and bottom slice numbers for sample volume
stackstart = subz-(szsample/2)+1;
stackend = subz+(szsample/2);
%Cropping selected substack in xy plane
for i = stackstart:stackend
    %Cropping
    % Use y value for imcrop Xmin, and x value for imcrop Ymin, because
    % imcrop Xmin uses columns, and imcrop Ymin uses rows
    sampstack(:,:,j) = imcrop(croppedstack(:,:,i),[(suby-(szsample/2)), (subx-(szsample/2)), szsample-1, szsample-1]);
    j = j+1;
    %Progress bar
    waitbar((j/(1.1*szsample)),h);
end

% Remove disconnected objects using bwareaopen if selected
if app.RemovedisobjCheckBox.Value == true
    maxvox = app.RemovepxlsizeEditField.Value;
    sampstack2 = bwareaopen(sampstack,maxvox);
else
    sampstack2 = sampstack;
end

% Use binsurface to generate mesh from binary image stack
% iso2mesh function
[node,elem] = binsurface(sampstack2(:,:,:));

% get colours from mask tab
colours = [(app.StrutcolREditField.Value/255) (app.StrutcolGEditField.Value/255) (app.StrutcolBEditField.Value/255)];

% plot mesh in sample region tab using trisurf
trisurf(elem,node(:,1),node(:,2),node(:,3), 'Parent', app.Subdispaxes, 'FaceColor',colours,'FaceAlpha',app.StrutcolAEditField.Value,'EdgeColor','none');
xlim(app.Subdispaxes, [0 szsample]);
ylim(app.Subdispaxes, [0 szsample]);
zlim(app.Subdispaxes, [0 szsample]);

% plot mesh in mask tab
hold(app.Subdispaxesmask, 'off')
substackstrutsurf = trisurf(elem,node(:,1),node(:,2),node(:,3), 'Parent', app.Subdispaxesmask, 'FaceColor',colours,'FaceAlpha',app.StrutcolAEditField.Value,'EdgeColor','none');
xlim(app.Subdispaxesmask, [0 szsample]);
ylim(app.Subdispaxesmask, [0 szsample]);
zlim(app.Subdispaxesmask, [0 szsample]);

close(h)