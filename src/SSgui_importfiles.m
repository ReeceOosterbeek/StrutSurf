%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_importfiles.m      script file
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

% Number of files to import
numslice = length(filestoimport);
picnums = 1:numslice;

% Get filename of first image
firstfn = char(strcat(pathname,filestoimport(1,:)));
% Load first image to detect size
loadimg = imread(firstfn);

%Initialising pics variable to contain all slices in 8-bit
pics = zeros([size(loadimg),numslice],'uint8');
%Initialising picsall variable to contain first image
picsall = loadimg;

%Loading every image
h = waitbar(0,'Loading images...');
j = 1;
for i = 1:numslice
    %Generate file name to import
    filenameimport = char(strcat(pathname,filestoimport(i,:)));
    %Import file
    pics(:,:,j) = imread(filenameimport);
    %Progress bar
    waitbar(j/numslice,h)
    j = j+1;
end
close(h)

%Collapsing all slices into single shadow
h = waitbar(0,'Combining stack...');
j = 1;
for i = 1:numslice
    %Using or function to combine all slices
    picsall = or(picsall,pics(:,:,j));
    %Progress bar
    waitbar(j/numslice,h)
    j = j+1;
end
close(h)

% Normalise binary stack so it varies from 0 to 1, not 0 to 255
bitMax = max(max(max(pics)));
pics = pics/bitMax;
bitMaxAll = max(max(picsall));
picsall = picsall/bitMaxAll;

% If user selects auto-crop
if app.AutocropduringimportCheckBox.Value == true
    % get value of crop buffer
    buffer = app.BufferpixelsEditField.Value;
    % run cropping script
    SSgui_importcrop
    % display crop shadow
    cla(app.UIAxes_2)
    imshow(picsall, 'parent', app.UIAxes_2);
    hold(app.UIAxes_2,"on")
    % display crop border and centroid
    plot(app.UIAxes_2,xpoints,ypoints,'Color','r','LineWidth',1)
    scatter(app.UIAxes_2,(cropminc+xycentre(2)),(cropminr+xycentre(1)),100,'red','x','LineWidth',2)
    % If user doesn't select auto-crop
else
    % set buffer to zero
    buffer = 0;
    app.BufferpixelsEditField.Value = 0;
    % assign imported pics to croppedstack without cropping
    croppedstack = pics;
    % display crop shadow
    cla(app.UIAxes_2)
    imshow(picsall, 'parent', app.UIAxes_2);
    %Finding row and column indices of material in cropped region
    [r2, c2] = find(picsall == 1);
    %Locating centroid in xy plane
    xycentre = [mean(r2), mean(c2)];
end
% Display 3D data using sliceViewer using selected view button
selectedButton = app.ViewalongButtonGroup.SelectedObject;
slicepan = uipanel('parent', app.ImportedslicesPanel, 'Position', [0,0,app.ImportedslicesPanel.Position(3),app.ImportedslicesPanel.Position(4)]);
slicehandle = sliceViewer(croppedstack, 'parent', slicepan, 'SliceDirection', selectedButton.Text(1));
