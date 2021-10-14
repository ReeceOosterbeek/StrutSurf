%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
%
% SSgui_importselect.m      script file
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

%% SSgui import

% Variables pathname and filename are outputs of the browse files button

% Get list of all files in folder
foldercontents = dir(pathname);
foldercontentscell = struct2cell(foldercontents);
filenamelist = foldercontentscell(1,:);

% Find last dot '.' separator and detect file extension
dotseps = filename == '.';
fileextchar = max(find(dotseps==1));
exttype = filename(fileextchar:length(filename));

% Find file prefix length (without extension or numbers) 
charsinflnm = isstrprop(filename(1:fileextchar-1),'alpha');
preflength = max(find(charsinflnm==1));
picsetname = filename(1:preflength);

% Find all files that have the same prefix and filetype
fileselect = strncmp(filenamelist,filename,preflength);
filetypecheck = endsWith(filenamelist,exttype);
fileslogical = and(fileselect,filetypecheck);

% Select these files to import
filestoimport = filenamelist(fileslogical)';


