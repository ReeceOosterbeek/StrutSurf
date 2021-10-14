%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%               StrutSurf v1.0
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
classdef StrutSurf < matlab.apps.AppBase
    
    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        TabGroup                      matlab.ui.container.TabGroup
        ImportTab                     matlab.ui.container.Tab
        BrowsefilesButton             matlab.ui.control.Button
        FilestoimportListBox          matlab.ui.control.ListBox
        ImportthresholdedimagefilesLabel  matlab.ui.control.Label
        ImportfilesButton             matlab.ui.control.Button
        ImportedslicesPanel           matlab.ui.container.Panel
        AutocropduringimportCheckBox  matlab.ui.control.CheckBox
        BufferpixelsEditFieldLabel    matlab.ui.control.Label
        BufferpixelsEditField         matlab.ui.control.NumericEditField
        RawimageLabel                 matlab.ui.control.Label
        RunautocropButton             matlab.ui.control.Button
        ViewalongButtonGroup          matlab.ui.container.ButtonGroup
        XaxisButton                   matlab.ui.control.RadioButton
        YaxisButton                   matlab.ui.control.RadioButton
        ZaxisButton                   matlab.ui.control.RadioButton
        UIAxes                        matlab.ui.control.UIAxes
        UIAxes_2                      matlab.ui.control.UIAxes
        SampleRegionTab               matlab.ui.container.Tab
        SampleRegionSizeEditFieldLabel    matlab.ui.control.Label
        SampleRegionSizeEditField    matlab.ui.control.NumericEditField
        AddrandpointButton           matlab.ui.control.Button
        RandmethodLabel              matlab.ui.control.Label
        Randmethod                   matlab.ui.control.DropDown
        ManuallyaddpointButton       matlab.ui.control.Button
        ManualXEditFieldLabel        matlab.ui.control.Label
        ManualXEditField             matlab.ui.control.NumericEditField
        ManualYEditFieldLabel        matlab.ui.control.Label
        ManualYEditField             matlab.ui.control.NumericEditField
        ManualZEditFieldLabel        matlab.ui.control.Label
        ManualZEditField             matlab.ui.control.NumericEditField
        UITable                      matlab.ui.control.Table
        RemovedisobjCheckBox         matlab.ui.control.CheckBox
        RemovepxlsizeEditFieldLabel  matlab.ui.control.Label
        RemovepxlsizeEditField       matlab.ui.control.NumericEditField
        GensubregionButton           matlab.ui.control.Button
        XYZDisp                      matlab.ui.control.EditField
        GenXDisp                   matlab.ui.control.EditField
        GenYDisp                   matlab.ui.control.EditField
        GenZDisp                   matlab.ui.control.EditField
        SubdisplayPanel              matlab.ui.container.Panel
        Subdispaxes                  matlab.ui.control.UIAxes
        UITabContextMenu             matlab.ui.container.ContextMenu
        Menu                         matlab.ui.container.Menu
        Menu2                        matlab.ui.container.Menu
        ExpstlButton                 matlab.ui.control.Button
        MaskTab                      matlab.ui.container.Tab
        SubdisplaymaskPanel          matlab.ui.container.Panel
        Subdispaxesmask              matlab.ui.control.UIAxes
        StrutcolEditFieldLabel       matlab.ui.control.Label
        StrutcolREditField           matlab.ui.control.NumericEditField
        StrutcolGEditField           matlab.ui.control.NumericEditField
        StrutcolBEditField           matlab.ui.control.NumericEditField
        StrutcolAEditField           matlab.ui.control.NumericEditField
        CylcolEditFieldLabel         matlab.ui.control.Label
        CylcolREditField             matlab.ui.control.NumericEditField
        CylcolGEditField             matlab.ui.control.NumericEditField
        CylcolBEditField             matlab.ui.control.NumericEditField
        CylcolAEditField             matlab.ui.control.NumericEditField
        CylstepEditField             matlab.ui.control.NumericEditField
        CylstepButtonGroup           matlab.ui.container.ButtonGroup
        CylstepCoarseToggButton      matlab.ui.control.ToggleButton
        CylstepFineToggButton        matlab.ui.control.ToggleButton
        CylstepFineEditField         matlab.ui.control.NumericEditField
        CylradSpinLabel              matlab.ui.control.Label
        CylradSpin                   matlab.ui.control.Spinner
        CylhgtSpinLabel              matlab.ui.control.Label
        CylhgtSpin                   matlab.ui.control.Spinner
        TransXSpinLabel              matlab.ui.control.Label
        TransXSpin                   matlab.ui.control.Spinner
        TransYSpinLabel              matlab.ui.control.Label
        TransYSpin                   matlab.ui.control.Spinner
        TransZSpinLabel              matlab.ui.control.Label
        TransZSpin                   matlab.ui.control.Spinner
        TransstepEditFieldLabel      matlab.ui.control.Label
        TransstepEditField           matlab.ui.control.NumericEditField
        TransstepButtonGroup         matlab.ui.container.ButtonGroup
        TransstepCoarseToggButton    matlab.ui.control.ToggleButton
        TransstepFineToggButton      matlab.ui.control.ToggleButton
        TransstepFineEditField       matlab.ui.control.NumericEditField
        RotstepEditFieldLabel        matlab.ui.control.Label
        RotstepEditField             matlab.ui.control.NumericEditField
        RotstepButtonGroup           matlab.ui.container.ButtonGroup
        RotstepCoarseToggButton      matlab.ui.control.ToggleButton
        RotstepFineToggButton        matlab.ui.control.ToggleButton
        RotstepFineEditField         matlab.ui.control.NumericEditField
        AZSpinLabel                  matlab.ui.control.Label
        AZSpin                       matlab.ui.control.Spinner
        ELSpinLabel                  matlab.ui.control.Label
        ELSpin                       matlab.ui.control.Spinner
        CreatecylmaskButton          matlab.ui.control.Button
        StrutfitLabel                matlab.ui.control.Label
        Strutfit                     matlab.ui.control.DropDown
        AnalysestrutButton           matlab.ui.control.Button
        AnalysisTab                  matlab.ui.container.Tab
        StrutaxesPanel               matlab.ui.container.Panel
        Strutaxes                    matlab.ui.control.UIAxes
        StrutaxesPanel2              matlab.ui.container.Panel
        Strutaxes2                   matlab.ui.control.UIAxes
        StrutaxesPanel3              matlab.ui.container.Panel
        Strutaxes3                   matlab.ui.control.UIAxes
        PxlPanel                     matlab.ui.container.Panel
        PxEditFieldLabel             matlab.ui.control.Label
        PxEditField                  matlab.ui.control.NumericEditField
        PlotUnitButtonGroup          matlab.ui.container.ButtonGroup
        PlotUmButton                 matlab.ui.control.RadioButton
        PlotPxButton                 matlab.ui.control.RadioButton
        PlotPxUmLabel                matlab.ui.control.Label
        OptionsTabGroup              matlab.ui.container.TabGroup
        StrutOpt                     matlab.ui.container.Tab
        LvlStrutOpt                  matlab.ui.container.Tab
        SurfOpt                      matlab.ui.container.Tab
        StrutviewButtonGroup         matlab.ui.container.ButtonGroup
        StrutviewXButton             matlab.ui.control.RadioButton
        StrutviewYButton             matlab.ui.control.RadioButton
        StrutviewZButton             matlab.ui.control.RadioButton
        Strutview3DButton            matlab.ui.control.RadioButton
        StrutviewresetButton         matlab.ui.control.Button
        StrutviewwindButton          matlab.ui.control.Button
        SVopacEditFieldLabel         matlab.ui.control.Label
        SVopacEditField              matlab.ui.control.NumericEditField
        StrutsurfcolourCheckBox      matlab.ui.control.CheckBox
        FitaxisCheckBox              matlab.ui.control.CheckBox
        SVExpstlButton               matlab.ui.control.Button
        SVExpcsvButton               matlab.ui.control.Button
        LvlstrutviewButtonGroup      matlab.ui.container.ButtonGroup
        LvlstrutviewXButton          matlab.ui.control.RadioButton
        LvlstrutviewYButton          matlab.ui.control.RadioButton
        LvlstrutviewZButton          matlab.ui.control.RadioButton
        Lvlstrutview3DButton         matlab.ui.control.RadioButton
        LvlstrutviewresetButton      matlab.ui.control.Button
        LvlstrutviewwindButton       matlab.ui.control.Button
        LSVopacEditFieldLabel        matlab.ui.control.Label
        LSVopacEditField             matlab.ui.control.NumericEditField
        LvlstrutsurfcolourCheckBox   matlab.ui.control.CheckBox
        FitxsecCheckBox              matlab.ui.control.CheckBox
        LSVExpstlButton              matlab.ui.control.Button
        LSVExpcsvButton              matlab.ui.control.Button
        SurfviewButtonGroup          matlab.ui.container.ButtonGroup
        SurfviewXButton              matlab.ui.control.RadioButton
        SurfviewYButton              matlab.ui.control.RadioButton
        SurfviewZButton              matlab.ui.control.RadioButton
        Surfview3DButton             matlab.ui.control.RadioButton
        SurfviewresetButton          matlab.ui.control.Button
        SurfviewwindButton           matlab.ui.control.Button
        SurfExpstlButton             matlab.ui.control.Button
        SurfExpcsvButton             matlab.ui.control.Button
        AnalysisdataTable            matlab.ui.control.Table
        AnalysisdataTableContextMenu   matlab.ui.container.ContextMenu
        ADMenu                       matlab.ui.container.Menu
        ADMenu2                      matlab.ui.container.Menu
        ADMenu3                      matlab.ui.container.Menu
        TableExpcsvButton            matlab.ui.control.Button
        TableUpdatecsvButton         matlab.ui.control.Button
        HelpTab                      matlab.ui.container.Tab
        OpenmanualButton             matlab.ui.control.Button
        VersionLabel                 matlab.ui.control.Label
    end
    
    %% Callbacks that handle component events
    methods (Access = private)
        
        
        
        % Button pushed function: BrowsefilesButton
        function BrowsefilesButtonPushed(app, event)
            global pathname filestoimport picsetname
            [filename, pathname] = uigetfile( ...
                {'*.bmp;*.tif;*.tiff;*.png;*.jpg', 'All Image Files (*.bmp, *.tif, *.tiff, *.png, *.jpg)'; ...
                '*.*','All Files (*.*)'}, ...
                'Open binary image file');
            % Run import script
            SSgui_importselect
            % Display list of files in box
            app.FilestoimportListBox.Items = filestoimport;
        end
        
        % Value changed function: FilestoimportListBox
        % Display image when selected
        function FilestoimportListBoxValueChanged(app, event)
            global pathname
            % Get name of selected image
            imagetoview = app.FilestoimportListBox.Value;
            % Add path
            imagetoviewpath = strcat(pathname,imagetoview);
            % Load and display selected image
            loadimg = imread(imagetoviewpath);
            imshow(loadimg, 'parent', app.UIAxes);
        end
        
        % Button pushed function: ImportfilesButton
        function ImportfilesButtonPushed(app, event)
            global pathname filestoimport croppedstack slicehandle pics picsall numslice buffer xycentre
            % Run import files script
            SSgui_importfiles
        end
        
        % Selection changed function: ViewalongButtonGroup
        % replot sliceviewer in selected direction
        function ViewalongButtonGroupSelectionChanged(app, event)
            global croppedstack slicehandle
            selectedButton = app.ViewalongButtonGroup.SelectedObject;
            delete(slicehandle)
            slicepan = uipanel('parent', app.ImportedslicesPanel, 'Position', [0,0,app.ImportedslicesPanel.Position(3),app.ImportedslicesPanel.Position(4)]);
            slicehandle = sliceViewer(croppedstack, 'parent', slicepan, 'SliceDirection', selectedButton.Text(1));
        end
        
        % Button pushed function: RunautocropButton
        % re-run autocropper
        function RunautocropButtonPushed(app, event)
            global pics picsall numslice slicehandle croppedstack buffer xycentre
            % get value of crop buffer
            buffer = app.BufferpixelsEditField.Value;
            selectedButton = app.ViewalongButtonGroup.SelectedObject;
            % run cropping script
            SSgui_importcrop
            % display crop shadow
            cla(app.UIAxes_2)
            imshow(picsall, 'parent', app.UIAxes_2);
            % display crop border and centroid
            hold(app.UIAxes_2,"on")
            plot(app.UIAxes_2,xpoints,ypoints,'Color','r','LineWidth',1)
            scatter(app.UIAxes_2,(cropminc+xycentre(2)),(cropminr+xycentre(1)),100,'red','x','LineWidth',2)
            % replot sliceviewer in selected direction
            delete(slicehandle)
            slicepan = uipanel('parent', app.ImportedslicesPanel, 'Position', [0,0,app.ImportedslicesPanel.Position(3),app.ImportedslicesPanel.Position(4)]);
            slicehandle = sliceViewer(croppedstack, 'parent', slicepan, 'SliceDirection', selectedButton.Text(1));
        end
        
        % Button pushed function: AddrandpointButton
        % add random point in volume to list
        function AddrandpointButtonPushed(app, event)
            global croppedstack picsetname buffer szsample
            % get region size
            szsample = app.SampleRegionSizeEditField.Value;
            % run random sampling script
            SSgui_randsamp
            % append point to list in table
            addrowdat = {picsetname buffer, szsample, rndx, rndy, rndz};
            app.UITable.Data = [app.UITable.Data; addrowdat];
        end
        
        % Button pushed function: ManuallyaddpointButton
        function ManuallyaddpointButtonPushed(app, event)
            global croppedstack picsetname buffer szsample
            % get region size and XYZ data entered
            szsample = app.SampleRegionSizeEditField.Value;
            manpointx = app.ManualXEditField.Value;
            manpointy = app.ManualYEditField.Value;
            manpointz = app.ManualZEditField.Value;
            % run manual sampling script
            SSgui_mansamp
            % append point to list in table
            addrowdat = {picsetname buffer, szsample, manpointx, manpointy, manpointz};
            app.UITable.Data = [app.UITable.Data; addrowdat];
        end
        
        % Cell selection callback: UITable
        % get values of selected point from table
        function UITableCellSelection(app, event)
            global subx suby subz rowindex Usepcstname Usebuffer Usesize
            rowindex = event.Indices(1);
            rowdata = app.UITable.Data(rowindex,:);
            Usepcstname = rowdata{1};
            Usebuffer = rowdata{2};
            Usesize = rowdata{3};
            subx = rowdata{4};
            suby = rowdata{5};
            subz = rowdata{6};
            app.GenXDisp.Value = ['X:',num2str(subx)];
            app.GenYDisp.Value = ['Y:',num2str(suby)];
            app.GenZDisp.Value = ['Z:',num2str(subz)];
        end
        
        % Context menu callback: UITable - delete row
        % delete selected row from table
        function DelSelected(app,event)
            global rowindex
            rownums = 1:size(app.UITable.Data, 1);
            keeprows = rownums ~= rowindex;
            rownums = rownums(keeprows);
            app.UITable.Data = app.UITable.Data(rownums,:);
        end
        
        % Button pushed function: GensubregionButton
        function GensubregionButtonPushed(app, event)
            global croppedstack szsample subx suby subz node elem Usepcstname Usebuffer Usesize
            global recentRD1 recentRD2 recentRD3 recentRD4 recentRD5 recentRD6 recentRD7 substackstrutsurf
            % run substack meshing script
            SSgui_substack
            % assign values used to placeholder recent parameters
            recentRD1 = Usepcstname;
            recentRD2 = Usebuffer;
            recentRD3 = Usesize;
            recentRD4 = subx;
            recentRD5 = suby;
            recentRD6 = subz;
            app.XYZDisp.Value = ['X:',num2str(recentRD4),' Y:',num2str(recentRD5),' Z:',num2str(recentRD6)];
            if app.RemovedisobjCheckBox.Value == true
                recentRD7 = app.RemovepxlsizeEditField.Value;
            else
                recentRD7 = NaN;
            end
        end
        
        % Button pushed function: ExpstlButton
        % export region mesh as stl
        function ExpstlButtonPushed(app, event)
            global node elem
            [stlfilename, stlpathname] = uiputfile( ...
                {'*.stl', 'stl mesh file (*.stl)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export stl file');
            stlfpname = strcat(stlpathname, stlfilename);
            savestl(node,elem,stlfpname);
        end
        
        % Value changed function: CylstepEditField
        % Changing step size based on entered values and coarse/fine
        % selection
        function CylstepValueChanged(app, event)
            if app.CylstepCoarseToggButton.Value == true;
                app.CylradSpin.Step = app.CylstepEditField.Value;
                app.CylhgtSpin.Step = app.CylstepEditField.Value;
            else
                app.CylradSpin.Step = app.CylstepFineEditField.Value;
                app.CylhgtSpin.Step = app.CylstepFineEditField.Value;
            end
        end
        
        % Value changed function: TransstepEditField
        % Changing step size based on entered values and coarse/fine
        % selection
        function TransstepValueChanged(app, event)
            if app.TransstepCoarseToggButton.Value == true;
                app.TransXSpin.Step = app.TransstepEditField.Value;
                app.TransYSpin.Step = app.TransstepEditField.Value;
                app.TransZSpin.Step = app.TransstepEditField.Value;
            else
                app.TransXSpin.Step = app.TransstepFineEditField.Value;
                app.TransYSpin.Step = app.TransstepFineEditField.Value;
                app.TransZSpin.Step = app.TransstepFineEditField.Value;
            end
        end
        
        % Value changed function: RotstepEditField
        % Changing step size based on entered values and coarse/fine
        % selection
        function RotstepValueChanged(app, event)
            if app.RotstepCoarseToggButton.Value == true;
                app.AZSpin.Step = app.RotstepEditField.Value;
                app.ELSpin.Step = app.RotstepEditField.Value;
            else
                app.AZSpin.Step = app.RotstepFineEditField.Value;
                app.ELSpin.Step = app.RotstepFineEditField.Value;
            end
        end
        
        % Plot cylinder mask - many buttons trigger this function
        % replots cylinder after parameter change without affect strut mesh
        % plot
        function Plotcylmask(app, event)
            global cylsurf cap1 cap2 V cylheight cylrad
            SSgui_plotcyl
        end
        
        % Plot substack strut
        % replots substack mesh after changes
        function Plotsubstackstrut(app, event)
            global substackstrutsurf szsample node elem
            SSgui_plotSubstackStrut
        end
        
        % Button pushed function: Analysestrut
        function AnalysestrutButtonPushed(app, event)
            global V node elem szsample subx suby subz xycentre cylheight
            global cylrad newelems nodecentred lineBFx lineBFy lineBFz
            global nodeLvl radfit_out resampx resampy resampZ unwrpstrut deviations
            global strutcentred strutLvl nodeind xsecX xsecY xsecZ FerMxMn
            global recentRD1 recentRD2 recentRD3 recentRD4 recentRD5 recentRD6 recentRD7 SavDat
            % crop substack mesh to just masked cylinder
            SSgui_cropcyl
            % Analysing cropped strut
            SSgui_analysis
            
            % Plot analysis results
            resetme = 0;
            newwind = 0;
            
            % Plot strut
            SSgui_Aplotstrut
            % Plot level strut
            SSgui_Aplotlvlstrut
            % Plot extracted surface
            SSgui_Aplotsurf
            
            % Set view column to empty
            for i = 1:size(app.AnalysisdataTable.Data,1)
                app.AnalysisdataTable.Data{i,1} = '';
            end
            
            % Convert radii to diameters
            d1 = 2*radfit_out;
            d2 = 2*radfit_out2;
            
            % Add new analysis row with parameters used
            addrowdat = {'x' recentRD1 recentRD2, recentRD3, recentRD4, recentRD5, recentRD6, recentRD7, cylrad, cylheight, xtrans, ytrans, ztrans, rad2deg(aztheta), rad2deg(eltheta), centredist, buildang, d1, d2, FerMxMn(1), FerMxMn(2), roughSA, roughSQ, roughSZ};
            app.AnalysisdataTable.Data = [app.AnalysisdataTable.Data; addrowdat];
            
            % Save meshes and data used to SavDat variable so that analysis
            % can be recalled later if desired
            addrowSavDat = {newelems,nodecentred,deviations,unwrpstrut,[lineBFx,lineBFy,lineBFz],nodeLvl,[xsecX;xsecY;xsecZ],resampx,resampy,resampZ};
            if size(app.AnalysisdataTable.Data,1) == 1
                SavDat = addrowSavDat;
            else
                SavDat = [SavDat; addrowSavDat];
            end
            app.TableUpdatecsvButton.Enable = 'on';
        end
        
        % Replotting analysis strut after option change
        function replotAstrut(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz deviations
            global unwrpstrut
            resetme = 0;
            newwind = 0;
            SSgui_Aplotstrut
        end
        
        % Replotting analysis strut after option reset
        function replotAstrutReset(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz deviations
            global unwrpstrut
            resetme = 1;
            newwind = 0;
            app.StrutviewXButton.Value = false;
            app.StrutviewYButton.Value = false;
            app.StrutviewZButton.Value = false;
            app.Strutview3DButton.Value = true;
            app.SVopacEditField.Value = 0.5;
            app.StrutsurfcolourCheckBox.Value = false;
            app.FitaxisCheckBox.Value = true;
            SSgui_Aplotstrut
        end
        
        % Replotting analysis strut into new window
        function replotAstrutWind(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz deviations
            global unwrpstrut
            resetme = 0;
            newwind = 1;
            SSgui_Aplotstrut
        end
        
        % Button pushed function: SVExpstlButton
        % export plot as stl
        function SVExpstlButtonPushed(app, event)
            global nodecentred newelems
            [stlfilename, stlpathname] = uiputfile( ...
                {'*.stl', 'stl mesh file (*.stl)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export stl file');
            stlfpname = strcat(stlpathname, stlfilename);
            if app.PlotUmButton.Value
                nodeExp = nodecentred*app.PxEditField.Value;
            else
                nodeExp = nodecentred;
            end
            savestl(nodeExp,newelems,stlfpname);
        end
        
        % Button pushed function: SVExpcsvButton
        % export plot as csv
        function SVExpcsvButtonPushed(app, event)
            global strutcentred
            [csvfilename, csvpathname] = uiputfile( ...
                {'*.csv', 'csv file (*.csv)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export csv file');
            csvfpname = strcat(csvpathname, csvfilename);
            if app.PlotUmButton.Value
                strutExp = strutcentred*app.PxEditField.Value;
            else
                strutExp = strutcentred;
            end
            writematrix(strutExp,csvfpname);
        end
        
        % Replotting analysis strut after option change
        function replotAlvlstrut(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz nodeLvl
            global unwrpstrut deviations xsecX xsecY xsecZ
            resetme = 0;
            newwind = 0;
            SSgui_Aplotlvlstrut
        end
        
        % Replotting analysis strut after option reset
        function replotAlvlstrutReset(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz nodeLvl
            global unwrpstrut deviations xsecX xsecY xsecZ
            resetme = 1;
            newwind = 0;
            app.LvlstrutviewXButton.Value = true;
            app.LvlstrutviewYButton.Value = false;
            app.LvlstrutviewZButton.Value = false;
            app.Lvlstrutview3DButton.Value = false;
            app.LSVopacEditField.Value = 0.5;
            app.LvlstrutsurfcolourCheckBox.Value = true;
            app.FitxsecCheckBox.Value = true;
            SSgui_Aplotlvlstrut
        end
        
        % Replotting analysis strut into new window
        function replotAlvlstrutWind(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz nodeLvl
            global unwrpstrut deviations xsecX xsecY xsecZ
            resetme = 0;
            newwind = 1;
            SSgui_Aplotlvlstrut
        end
        
        % Button pushed function: LSVExpstlButton
        % export plot as stl
        function LSVExpstlButtonPushed(app, event)
            global nodeLvl newelems
            [stlfilename, stlpathname] = uiputfile( ...
                {'*.stl', 'stl mesh file (*.stl)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export stl file');
            stlfpname = strcat(stlpathname, stlfilename);
            if app.PlotUmButton.Value
                nodeExp = nodeLvl*app.PxEditField.Value;
            else
                nodeExp = nodeLvl;
            end
            savestl(nodeExp,newelems,stlfpname);
        end
        
        % Button pushed function: LSVExpcsvButton
        % export plot as csv
        function LSVExpcsvButtonPushed(app, event)
            global strutLvl
            [csvfilename, csvpathname] = uiputfile( ...
                {'*.csv', 'csv file (*.csv)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export csv file');
            csvfpname = strcat(csvpathname, csvfilename);
            if app.PlotUmButton.Value
                strutExp = strutLvl*app.PxEditField.Value;
            else
                strutExp = strutLvl;
            end
            writematrix(strutExp,csvfpname);
        end
        
        % Replotting analysis strut after option change
        function replotAsurf(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz
            global unwrpstrut resampx resampy resampZ deviations
            resetme = 0;
            newwind = 0;
            SSgui_Aplotsurf
        end
        
        % Replotting analysis strut after option reset
        function replotAsurfReset(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz
            global unwrpstrut resampx resampy resampZ deviations
            resetme = 1;
            newwind = 0;
            app.SurfviewXButton.Value = false;
            app.SurfviewYButton.Value = false;
            app.SurfviewZButton.Value = true;
            app.Surfview3DButton.Value = false;
            SSgui_Aplotsurf
        end
        
        % Replotting analysis strut into new window
        function replotAsurfWind(app, event)
            global newelems nodecentred lineBFx lineBFy lineBFz
            global unwrpstrut resampx resampy resampZ deviations
            resetme = 0;
            newwind = 1;
            SSgui_Aplotsurf
        end
        
        % Button pushed function: SurfExpstlButton
        % export plot as stl
        function SurfExpstlButtonPushed(app, event)
            global resampx resampy resampZ
            [stlfilename, stlpathname] = uiputfile( ...
                {'*.stl', 'stl mesh file (*.stl)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export stl file');
            stlfpname = strcat(stlpathname, stlfilename);
            
            [resampX,resampY] = meshgrid(resampx,resampy);
            pointlistX = reshape(resampX,[],1);
            pointlistY = reshape(resampY,[],1);
            pointlistZ = reshape(resampZ,[],1);
            
            triangles = delaunay(pointlistX,pointlistY);
            
            if app.PlotUmButton.Value
                nodeExp = [pointlistX,pointlistY,pointlistZ]*app.PxEditField.Value;
            else
                nodeExp = [pointlistX,pointlistY,pointlistZ];
            end
            savestl(nodeExp,triangles,stlfpname);
        end
        
        % Button pushed function: SurfExpcsvButton
        % export plot as csv
        function SurfExpcsvButtonPushed(app, event)
            global resampx resampy resampZ
            [csvfilename, csvpathname] = uiputfile( ...
                {'*.csv', 'csv file (*.csv)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export csv file');
            csvfpname = strcat(csvpathname, csvfilename);
            
            [resampX,resampY] = meshgrid(resampx,resampy);
            pointlistX = reshape(resampX,[],1);
            pointlistY = reshape(resampY,[],1);
            pointlistZ = reshape(resampZ,[],1);
            
            if app.PlotUmButton.Value
                strutExp = [pointlistX,pointlistY,pointlistZ]*app.PxEditField.Value;
            else
                strutExp = [pointlistX,pointlistY,pointlistZ];
            end
            writematrix(strutExp,csvfpname);
        end
        
        % Replotting analysis strut after option change
        function replotstrutAll(app, event)
            global newelems nodecentred nodeLvl lineBFx lineBFy lineBFz deviations
            global unwrpstrut xsecX xsecY xsecZ resampx resampy resampZ
            resetme = 0;
            newwind = 0;
            SSgui_Aplotstrut
            SSgui_Aplotlvlstrut
            SSgui_Aplotsurf
        end
        
        % Cell selection callback: AnalysisdataTable
        function ADTabCellSelection(app, event)
            global rowindexAD
            % get index of selected analysis row
            rowindexAD = event.Indices(1);
        end
        
        % Context menu callback: AnalysisdataTable - delete row
        % delete selected row from analysis table and SavDat data
        function ADTabDelSelected(app,event)
            global rowindexAD SavDat
            rownums = 1:size(app.AnalysisdataTable.Data, 1);
            keeprows = rownums ~= rowindexAD;
            rownums = rownums(keeprows);
            app.AnalysisdataTable.Data = app.AnalysisdataTable.Data(rownums,:);
            SavDat = SavDat(rownums,:);
            app.TableUpdatecsvButton.Enable = 'on';
        end
        
        
        % Context menu callback: AnalysisdataTable - view analysis
        % view selected analysis
        function ADTabViewSelected(app,event)
            global rowindexAD SavDat unwrpelems
            global newelems nodecentred deviations unwrpstrut
            global lineBFx lineBFy lineBFz nodeLvl xsecX xsecY xsecZ unwrpnode
            
            % Get data from SavDat
            newelems = SavDat{rowindexAD,1};
            nodecentred = SavDat{rowindexAD,2};
            deviations = SavDat{rowindexAD,3};
            unwrpstrut = SavDat{rowindexAD,4};
            lineBF = SavDat{rowindexAD,5};
            lineBFx = lineBF(:,1);
            lineBFy = lineBF(:,2);
            lineBFz = lineBF(:,3);
            nodeLvl = SavDat{rowindexAD,6};
            xsec = SavDat{rowindexAD,7};
            xsecX = xsec(1,:);
            xsecY = xsec(2,:);
            xsecZ = xsec(3,:);
            resampx = SavDat{rowindexAD,8};
            resampy = SavDat{rowindexAD,9};
            resampZ = SavDat{rowindexAD,10};
            
            % Replot data
            resetme = 0;
            newwind = 0;
            
            % Set view column to show the correct data being viewed
            for i = 1:size(app.AnalysisdataTable.Data,1)
                if i == rowindexAD
                    app.AnalysisdataTable.Data{i,1} = 'x';
                else
                    app.AnalysisdataTable.Data{i,1} = '';
                end
            end
            
            SSgui_Aplotstrut
            SSgui_Aplotlvlstrut
            SSgui_Aplotsurf
        end
        
        % Button pushed function: TableExpcsvButton
        % Export analysis data table as csv
        % specify file name
        function TableExpcsvButtonPushed(app, event)
            global Tablecsvfpname SavDat
            [csvfilename, csvpathname] = uiputfile( ...
                {'*.csv', 'csv file (*.csv)'; ...
                '*.*','All Files (*.*)'}, ...
                'Export csv file');
            Tablecsvfpname = strcat(csvpathname, csvfilename);
            numcols = size(app.AnalysisdataTable.Data,2);
            colnames = app.AnalysisdataTable.ColumnName';
            writecell([colnames(:,[2:numcols]); app.AnalysisdataTable.Data(:,[2:numcols])],Tablecsvfpname);
        end
        
        % Button pushed function: TableUpdatecsvButton
        % update previously specified file
        function TableUpdatecsvButtonPushed(app, event)
            global Tablecsvfpname
            numcols = size(app.AnalysisdataTable.Data,2);
            colnames = app.AnalysisdataTable.ColumnName';
            writecell([colnames(:,[2:numcols]); app.AnalysisdataTable.Data(:,[2:numcols])],Tablecsvfpname);
            app.TableUpdatecsvButton.Enable = 'off';
        end
        
        % Button pushed function: OpenmanualButton
        % open manual
        function OpenmanualButtonPushed(app, event)
            winopen('StrutSurf_manual_v1.0.pdf')
        end
    end
    
    
    
    %% Component initialization
    methods (Access = private)
        
        % Create UIFigure and components
        function createComponents(app)
            pause(0.1);
            screen = get(0, 'ScreenSize');
            appHgt = round(0.956*(screen(4) - 40));
            appHgtSpace = appHgt - 30;
            appWid = round(1.746*appHgt);
            appWidSpace = appWid - 10;
            
            uiax = 0.6;
            impboxX = 0.4;
            impboxY = 0.47;
            svScale = 0.8;
            
            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [5 45 appWid appHgt];
            app.UIFigure.Name = 'StrutSurf';
            app.UIFigure.Icon = 'StrutSurf_logo.png';
            
            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 appWid appHgt];
            
            %% Create ImportTab
            app.ImportTab = uitab(app.TabGroup);
            app.ImportTab.Title = 'Import';
            app.ImportTab.Scrollable = 'on';
            
            % Create BrowsefilesButton
            app.BrowsefilesButton = uibutton(app.ImportTab, 'push');
            app.BrowsefilesButton.ButtonPushedFcn = createCallbackFcn(app, @BrowsefilesButtonPushed, true);
            app.BrowsefilesButton.Position = [18 (appHgtSpace-60) 99 22];
            app.BrowsefilesButton.Text = 'Browse files';
            
            % Create FilestoimportListBox
            app.FilestoimportListBox = uilistbox(app.ImportTab);
            app.FilestoimportListBox.Items = {};
            app.FilestoimportListBox.ValueChangedFcn = createCallbackFcn(app, @FilestoimportListBoxValueChanged, true);
            app.FilestoimportListBox.Position = [15 (0.45*appHgtSpace) (impboxX*appHgtSpace) ((0.55*appHgtSpace)-70)];
            app.FilestoimportListBox.Value = {};
            
            % Create ImportthresholdedimagefilesLabel
            app.ImportthresholdedimagefilesLabel = uilabel(app.ImportTab);
            app.ImportthresholdedimagefilesLabel.FontSize = 16;
            app.ImportthresholdedimagefilesLabel.Position = [17 (appHgtSpace-30) 220 22];
            app.ImportthresholdedimagefilesLabel.Text = 'Import thresholded image files';
            
            % Create ImportfilesButton
            app.ImportfilesButton = uibutton(app.ImportTab, 'push');
            app.ImportfilesButton.ButtonPushedFcn = createCallbackFcn(app, @ImportfilesButtonPushed, true);
            app.ImportfilesButton.Position = [(30+(impboxX*appHgtSpace)) (appHgtSpace-213) 147 143];
            app.ImportfilesButton.Text = 'Import files';
            
            % Create ImportedslicesPanel
            app.ImportedslicesPanel = uipanel(app.ImportTab);
            app.ImportedslicesPanel.Title = 'Imported Slices';
            app.ImportedslicesPanel.Position = [((0.6105*appHgtSpace)+212) (0.058*(appHgtSpace-792)) (svScale*appHgtSpace) (1.25*svScale*appHgtSpace)];
            
            % Create AutocropduringimportCheckBox
            app.AutocropduringimportCheckBox = uicheckbox(app.ImportTab);
            app.AutocropduringimportCheckBox.Text = 'Auto-crop during import';
            app.AutocropduringimportCheckBox.Position = [(30+(impboxX*appHgtSpace)) (appHgtSpace-240) 147 22];
            app.AutocropduringimportCheckBox.Value = true;
            
            % Create BufferpixelsEditFieldLabel
            app.BufferpixelsEditFieldLabel = uilabel(app.ImportTab);
            app.BufferpixelsEditFieldLabel.HorizontalAlignment = 'right';
            app.BufferpixelsEditFieldLabel.Position = [(80+(impboxX*appHgtSpace)) (appHgtSpace-270) 71 22];
            app.BufferpixelsEditFieldLabel.Text = 'Buffer pixels';
            
            % Create BufferpixelsEditField
            app.BufferpixelsEditField = uieditfield(app.ImportTab, 'numeric');
            app.BufferpixelsEditField.Limits = [0 Inf];
            app.BufferpixelsEditField.RoundFractionalValues = 'on';
            app.BufferpixelsEditField.ValueDisplayFormat = '%.0f';
            app.BufferpixelsEditField.Position = [(30+(impboxX*appHgtSpace)) (appHgtSpace-270) 44 22];
            app.BufferpixelsEditField.Value = 10;
            
            % Create RunautocropButton
            app.RunautocropButton = uibutton(app.ImportTab, 'push');
            app.RunautocropButton.ButtonPushedFcn = createCallbackFcn(app, @RunautocropButtonPushed, true);
            app.RunautocropButton.Position = [(30+(impboxX*appHgtSpace)) (appHgtSpace-328) 99 50];
            app.RunautocropButton.Text = ['Run auto-crop',newline,'manually'];
            
            % Create ViewalongButtonGroup
            app.ViewalongButtonGroup = uibuttongroup(app.ImportTab);
            app.ViewalongButtonGroup.AutoResizeChildren = 'on';
            app.ViewalongButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ViewalongButtonGroupSelectionChanged, true);
            app.ViewalongButtonGroup.Title = 'View along';
            app.ViewalongButtonGroup.Position = [((0.6395*appHgtSpace)+83) (((1.25*svScale+0.058)*appHgtSpace)-152) 100 106];
            
            % Create XaxisButton
            app.XaxisButton = uiradiobutton(app.ViewalongButtonGroup);
            app.XaxisButton.Text = 'X axis';
            app.XaxisButton.Position = [11 60 55 22];
            
            % Create YaxisButton
            app.YaxisButton = uiradiobutton(app.ViewalongButtonGroup);
            app.YaxisButton.Text = 'Y axis';
            app.YaxisButton.Position = [11 38 55 22];
            
            % Create ZaxisButton
            app.ZaxisButton = uiradiobutton(app.ViewalongButtonGroup);
            app.ZaxisButton.Text = 'Z axis';
            app.ZaxisButton.Position = [11 16 54 22];
            app.ZaxisButton.Value = true;
            
            % Create UIAxes
            app.UIAxes = uiaxes(app.ImportTab);
            title(app.UIAxes, 'Raw Image', 'FontSize', 12, 'FontWeight', 'normal')
            app.UIAxes.TitleHorizontalAlignment = 'left';
            app.UIAxes.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes.XTick = [];
            app.UIAxes.YTick = [];
            app.UIAxes.Color = [0.9412 0.9412 0.9412];
            app.UIAxes.Box = 'off';
            app.UIAxes.YAxis.Visible = 'off';
            app.UIAxes.XAxis.Visible = 'off';
            app.UIAxes.Position = [((-0.029*appHgtSpace)+8) 0 ((0.6395*appHgtSpace)-217) ((0.6395*appHgtSpace)-217)];
            
            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.ImportTab);
            title(app.UIAxes_2, 'Crop Shadow', 'FontSize', 12, 'FontWeight', 'normal')
            app.UIAxes_2.TitleHorizontalAlignment = 'left';
            app.UIAxes_2.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes_2.XTick = [];
            app.UIAxes_2.YTick = [];
            app.UIAxes_2.Color = [0.9412 0.9412 0.9412];
            app.UIAxes_2.Box = 'off';
            app.UIAxes_2.YAxis.Visible = 'off';
            app.UIAxes_2.XAxis.Visible = 'off';
            app.UIAxes_2.Position = [((0.6395*appHgtSpace)-247) 0 ((0.6395*appHgtSpace)-217) ((0.6395*appHgtSpace)-217)];
            
            %% Create Sample Region tab
            app.SampleRegionTab = uitab(app.TabGroup);
            app.SampleRegionTab.Title = 'Sample Region';
            app.SampleRegionTab.Scrollable = 'on';
            
            % Create SampleRegionSizeEditFieldLabel
            app.SampleRegionSizeEditFieldLabel = uilabel(app.SampleRegionTab);
            app.SampleRegionSizeEditFieldLabel.HorizontalAlignment = 'left';
            app.SampleRegionSizeEditFieldLabel.Position = [70 (appHgtSpace-50) 150 22];
            app.SampleRegionSizeEditFieldLabel.Text = 'Sample region size';
            
            % Create SampleRegionSizeEditField
            app.SampleRegionSizeEditField = uieditfield(app.SampleRegionTab, 'numeric');
            app.SampleRegionSizeEditField.Limits = [0 Inf];
            app.SampleRegionSizeEditField.RoundFractionalValues = 'on';
            app.SampleRegionSizeEditField.ValueDisplayFormat = '%.0f';
            app.SampleRegionSizeEditField.Position = [20 (appHgtSpace-50) 44 22];
            app.SampleRegionSizeEditField.Value = 200;
            
            % Create DropDownLabel
            app.RandmethodLabel = uilabel(app.SampleRegionTab);
            app.RandmethodLabel.HorizontalAlignment = 'right';
            app.RandmethodLabel.Position = [20 (appHgtSpace-150) 100 22];
            app.RandmethodLabel.Text = 'Random sampling';
            
            % Create DropDown
            app.Randmethod = uidropdown(app.SampleRegionTab);
            app.Randmethod.Items = {'Cylinder: Radially uniform', 'Cylinder: Cartesian uniform', 'Cartesian uniform'};
            app.Randmethod.Position = [130 (appHgtSpace-150) 95 22];
            app.Randmethod.Value = 'Cylinder: Radially uniform';
            
            % Create AddrandpointButton
            app.AddrandpointButton = uibutton(app.SampleRegionTab, 'push');
            app.AddrandpointButton.ButtonPushedFcn = createCallbackFcn(app, @AddrandpointButtonPushed, true);
            app.AddrandpointButton.Position = [20 (appHgtSpace-120) 190 60];
            app.AddrandpointButton.Text = 'Add random point';
            
            % Create ManuallyaddpointButton
            app.ManuallyaddpointButton = uibutton(app.SampleRegionTab, 'push');
            app.ManuallyaddpointButton.ButtonPushedFcn = createCallbackFcn(app, @ManuallyaddpointButtonPushed, true);
            app.ManuallyaddpointButton.Position = [240 (appHgtSpace-120) 200 60];
            app.ManuallyaddpointButton.Text = 'Manually add point';
            
            % Create ManualXEditFieldLabel
            app.ManualXEditFieldLabel = uilabel(app.SampleRegionTab);
            app.ManualXEditFieldLabel.HorizontalAlignment = 'left';
            app.ManualXEditFieldLabel.Position = [280 (appHgtSpace-150) 150 22];
            app.ManualXEditFieldLabel.Text = 'X';
            
            % Create ManualXEditField
            app.ManualXEditField = uieditfield(app.SampleRegionTab, 'numeric');
            app.ManualXEditField.Limits = [0 Inf];
            app.ManualXEditField.RoundFractionalValues = 'on';
            app.ManualXEditField.ValueDisplayFormat = '%.0f';
            app.ManualXEditField.Position = [240 (appHgtSpace-150) 34 22];
            
            % Create ManualYEditFieldLabel
            app.ManualYEditFieldLabel = uilabel(app.SampleRegionTab);
            app.ManualYEditFieldLabel.HorizontalAlignment = 'left';
            app.ManualYEditFieldLabel.Position = [340 (appHgtSpace-150) 150 22];
            app.ManualYEditFieldLabel.Text = 'Y';
            
            % Create ManualYEditField
            app.ManualYEditField = uieditfield(app.SampleRegionTab, 'numeric');
            app.ManualYEditField.Limits = [0 Inf];
            app.ManualYEditField.RoundFractionalValues = 'on';
            app.ManualYEditField.ValueDisplayFormat = '%.0f';
            app.ManualYEditField.Position = [300 (appHgtSpace-150) 34 22];
            
            % Create ManualZEditFieldLabel
            app.ManualZEditFieldLabel = uilabel(app.SampleRegionTab);
            app.ManualZEditFieldLabel.HorizontalAlignment = 'left';
            app.ManualZEditFieldLabel.Position = [400 (appHgtSpace-150) 150 22];
            app.ManualZEditFieldLabel.Text = 'Z';
            
            % Create ManualZEditField
            app.ManualZEditField = uieditfield(app.SampleRegionTab, 'numeric');
            app.ManualZEditField.Limits = [0 Inf];
            app.ManualZEditField.RoundFractionalValues = 'on';
            app.ManualZEditField.ValueDisplayFormat = '%.0f';
            app.ManualZEditField.Position = [360 (appHgtSpace-150) 34 22];
            
            % Create UITable
            app.UITable = uitable(app.SampleRegionTab);
            tabwid = 340 + 0.145*appHgtSpace;
            app.UITable.ColumnName = {'Slice dataset'; 'Crop buffer'; 'Region size'; 'X'; 'Y'; 'Z'};
            app.UITable.ColumnWidth = {'auto', 80, 90, 45, 45, 45};
            app.UITable.Position = [20 130 tabwid (appHgtSpace-300)];
            app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
            app.UITable.RowName = 'numbered';
            app.UITable.ColumnFormat = {'char', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'};
            
            % Create Remove disconnected objects
            app.RemovedisobjCheckBox = uicheckbox(app.SampleRegionTab);
            app.RemovedisobjCheckBox.Text = 'Remove disconnected objects less than';
            app.RemovedisobjCheckBox.Position = [20 105 270 20];
            app.RemovedisobjCheckBox.Value = true;
            
            % Create RemovepxlsizeEditFieldLabel
            app.RemovepxlsizeEditFieldLabel = uilabel(app.SampleRegionTab);
            app.RemovepxlsizeEditFieldLabel.HorizontalAlignment = 'left';
            app.RemovepxlsizeEditFieldLabel.Position = [340 105 71 20];
            app.RemovepxlsizeEditFieldLabel.Text = 'voxels';
            
            % Create RemovepxlsizeEditField
            app.RemovepxlsizeEditField = uieditfield(app.SampleRegionTab, 'numeric');
            app.RemovepxlsizeEditField.Limits = [0 Inf];
            app.RemovepxlsizeEditField.RoundFractionalValues = 'on';
            app.RemovepxlsizeEditField.ValueDisplayFormat = '%.0f';
            app.RemovepxlsizeEditField.Position = [290 105 44 20];
            app.RemovepxlsizeEditField.Value = 500;
            
            % Create ContextMenu
            app.UITabContextMenu = uicontextmenu(app.UIFigure);
            % Assign app.ContextMenu
            app.UITable.ContextMenu = app.UITabContextMenu;
            % Create Menu
            app.Menu = uimenu(app.UITabContextMenu);
            app.Menu.Text = '';
            % Create Menu2
            app.Menu2 = uimenu(app.UITabContextMenu);
            app.Menu2.Text = 'Delete selected row';
            app.Menu2.MenuSelectedFcn = createCallbackFcn(app, @DelSelected, true);
            
            % Create GensubregionButton
            app.GensubregionButton = uibutton(app.SampleRegionTab, 'push');
            app.GensubregionButton.ButtonPushedFcn = createCallbackFcn(app, @GensubregionButtonPushed, true);
            app.GensubregionButton.Position = [20 30 350 60];
            app.GensubregionButton.Text = 'Generate sub-region';
            
            % Create GenXDisp
            app.GenXDisp = uieditfield(app.SampleRegionTab, 'text');
            app.GenXDisp.Editable = 'off';
            app.GenXDisp.BackgroundColor = [0.9412 0.9412 0.9412];
            app.GenXDisp.Position = [380 70 (tabwid-360) 20];
            app.GenXDisp.Value = ['X:'];
            % Create GenYDisp
            app.GenYDisp = uieditfield(app.SampleRegionTab, 'text');
            app.GenYDisp.Editable = 'off';
            app.GenYDisp.BackgroundColor = [0.9412 0.9412 0.9412];
            app.GenYDisp.Position = [380 50 (tabwid-360) 20];
            app.GenYDisp.Value = ['Y:'];
            % Create GenZDisp
            app.GenZDisp = uieditfield(app.SampleRegionTab, 'text');
            app.GenZDisp.Editable = 'off';
            app.GenZDisp.BackgroundColor = [0.9412 0.9412 0.9412];
            app.GenZDisp.Position = [380 30 (tabwid-360) 20];
            app.GenZDisp.Value = ['X:'];
            
            % Create Panel
            app.SubdisplayPanel = uipanel(app.SampleRegionTab);
            app.SubdisplayPanel.Title = 'Sub-region mesh';
            pansize = 0.56*appHgtSpace + 150;
            app.SubdisplayPanel.Position = [(tabwid+50) 100 pansize pansize];
            
            % Create XYZDisp
            app.XYZDisp = uieditfield(app.SampleRegionTab, 'text');
            app.XYZDisp.Editable = 'off';
            app.XYZDisp.BackgroundColor = [0.9412 0.9412 0.9412];
            app.XYZDisp.Position = [(tabwid+50) (pansize+110) 200 22];
            app.XYZDisp.Value = 'X: Y: Z:';
            
            % Create Sub-region display UIAxes
            app.Subdispaxes = uiaxes(app.SubdisplayPanel);
            app.Subdispaxes.PlotBoxAspectRatio = [1 1 1];
            app.Subdispaxes.Position = [0,0,app.SubdisplayPanel.Position(3),app.SubdisplayPanel.Position(4)];
            xlabel(app.Subdispaxes, 'X')
            ylabel(app.Subdispaxes, 'Y')
            zlabel(app.Subdispaxes, 'Z')
            grid(app.Subdispaxes, 'on')
            
            % Create ExpstlButton
            app.ExpstlButton = uibutton(app.SampleRegionTab, 'push');
            app.ExpstlButton.ButtonPushedFcn = createCallbackFcn(app, @ExpstlButtonPushed, true);
            app.ExpstlButton.Position = [(tabwid+50) 30 430 60];
            app.ExpstlButton.Text = 'Export stl mesh';
            
            %% Create Mask tab
            app.MaskTab = uitab(app.TabGroup);
            app.MaskTab.Title = 'Mask';
            app.MaskTab.Scrollable = 'on';
            
            % Create Panel
            app.SubdisplaymaskPanel = uipanel(app.MaskTab);
            app.SubdisplaymaskPanel.Title = '';
            pansize2 = appHgtSpace - 20;
            app.SubdisplaymaskPanel.Position = [10 10 pansize2 pansize2];
            
            % Create Sub-region display UIAxes
            app.Subdispaxesmask = uiaxes(app.SubdisplaymaskPanel);
            app.Subdispaxesmask.PlotBoxAspectRatio = [1 1 1];
            app.Subdispaxesmask.Position = [0,0,app.SubdisplaymaskPanel.Position(3),app.SubdisplaymaskPanel.Position(4)];
            xlabel(app.Subdispaxesmask, 'X')
            ylabel(app.Subdispaxesmask, 'Y')
            zlabel(app.Subdispaxesmask, 'Z')
            grid(app.Subdispaxesmask, 'on')
            
            % Create StrutcolEditFieldLabel
            app.StrutcolEditFieldLabel = uilabel(app.MaskTab);
            app.StrutcolEditFieldLabel.HorizontalAlignment = 'left';
            app.StrutcolEditFieldLabel.Position = [(pansize2+30) 570 190 22];
            app.StrutcolEditFieldLabel.Text = 'Strut colour (RGBA)';
            
            % Create StrutcolREditField
            app.StrutcolREditField = uieditfield(app.MaskTab, 'numeric');
            app.StrutcolREditField.Limits = [0 255];
            app.StrutcolREditField.RoundFractionalValues = 'on';
            app.StrutcolREditField.ValueDisplayFormat = '%.0f';
            app.StrutcolREditField.Position = [(pansize2+180) 570 54 22];
            app.StrutcolREditField.Value = 0;
            app.StrutcolREditField.ValueChangedFcn = createCallbackFcn(app, @Plotsubstackstrut, true);
            
            % Create StrutcolGEditField
            app.StrutcolGEditField = uieditfield(app.MaskTab, 'numeric');
            app.StrutcolGEditField.Limits = [0 255];
            app.StrutcolGEditField.RoundFractionalValues = 'on';
            app.StrutcolGEditField.ValueDisplayFormat = '%.0f';
            app.StrutcolGEditField.Position = [(pansize2+240) 570 54 22];
            app.StrutcolGEditField.Value = 0;
            app.StrutcolGEditField.ValueChangedFcn = createCallbackFcn(app, @Plotsubstackstrut, true);
            
            % Create StrutcolBEditField
            app.StrutcolBEditField = uieditfield(app.MaskTab, 'numeric');
            app.StrutcolBEditField.Limits = [0 255];
            app.StrutcolBEditField.RoundFractionalValues = 'on';
            app.StrutcolBEditField.ValueDisplayFormat = '%.0f';
            app.StrutcolBEditField.Position = [(pansize2+300) 570 54 22];
            app.StrutcolBEditField.Value = 255;
            app.StrutcolBEditField.ValueChangedFcn = createCallbackFcn(app, @Plotsubstackstrut, true);
            
            % Create StrutcolAEditField
            app.StrutcolAEditField = uieditfield(app.MaskTab, 'numeric');
            app.StrutcolAEditField.Limits = [0 1];
            app.StrutcolAEditField.RoundFractionalValues = 'off';
            app.StrutcolAEditField.ValueDisplayFormat = '%.2f';
            app.StrutcolAEditField.Position = [(pansize2+360) 570 54 22];
            app.StrutcolAEditField.Value = 0.3;
            app.StrutcolAEditField.ValueChangedFcn = createCallbackFcn(app, @Plotsubstackstrut, true);
            
            % Create CylcolEditFieldLabel
            app.CylcolEditFieldLabel = uilabel(app.MaskTab);
            app.CylcolEditFieldLabel.HorizontalAlignment = 'left';
            app.CylcolEditFieldLabel.Position = [(pansize2+30) 540 190 22];
            app.CylcolEditFieldLabel.Text = 'Cylinder colour (RGBA)';
            
            % Create CylcolREditField
            app.CylcolREditField = uieditfield(app.MaskTab, 'numeric');
            app.CylcolREditField.Limits = [0 255];
            app.CylcolREditField.RoundFractionalValues = 'on';
            app.CylcolREditField.ValueDisplayFormat = '%.0f';
            app.CylcolREditField.Position = [(pansize2+180) 540 54 22];
            app.CylcolREditField.Value = 162;
            app.CylcolREditField.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            
            % Create CylcolGEditField
            app.CylcolGEditField = uieditfield(app.MaskTab, 'numeric');
            app.CylcolGEditField.Limits = [0 255];
            app.CylcolGEditField.RoundFractionalValues = 'on';
            app.CylcolGEditField.ValueDisplayFormat = '%.0f';
            app.CylcolGEditField.Position = [(pansize2+240) 540 54 22];
            app.CylcolGEditField.Value = 20;
            app.CylcolGEditField.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            
            % Create CylcolBEditField
            app.CylcolBEditField = uieditfield(app.MaskTab, 'numeric');
            app.CylcolBEditField.Limits = [0 255];
            app.CylcolBEditField.RoundFractionalValues = 'on';
            app.CylcolBEditField.ValueDisplayFormat = '%.0f';
            app.CylcolBEditField.Position = [(pansize2+300) 540 54 22];
            app.CylcolBEditField.Value = 47;
            app.CylcolBEditField.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            
            % Create CylcolAEditField
            app.CylcolAEditField = uieditfield(app.MaskTab, 'numeric');
            app.CylcolAEditField.Limits = [0 1];
            app.CylcolAEditField.RoundFractionalValues = 'off';
            app.CylcolAEditField.ValueDisplayFormat = '%.2f';
            app.CylcolAEditField.Position = [(pansize2+360) 540 54 22];
            app.CylcolAEditField.Value = 0.7;
            app.CylcolAEditField.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            
            % Create CreatecylmaskButton
            app.CreatecylmaskButton = uibutton(app.MaskTab, 'push');
            app.CreatecylmaskButton.ButtonPushedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.CreatecylmaskButton.Position = [(pansize2+50) 412 100 80];
            app.CreatecylmaskButton.Text = ['Create cylinder',newline,'mask'];
            
            % Create CylstepEditField
            app.CylstepEditField = uieditfield(app.MaskTab, 'numeric');
            app.CylstepEditField.Limits = [0 Inf];
            app.CylstepEditField.RoundFractionalValues = 'off';
            app.CylstepEditField.ValueDisplayFormat = '%.2f';
            app.CylstepEditField.Position = [(pansize2+180) 480 54 22];
            app.CylstepEditField.Value = 5;
            app.CylstepEditField.ValueChangedFcn = createCallbackFcn(app, @CylstepValueChanged, true);
            
            % Create CylstepButtonGroup
            app.CylstepButtonGroup = uibuttongroup(app.MaskTab);
            app.CylstepButtonGroup.BorderType = 'none';
            app.CylstepButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @CylstepValueChanged, true);
            app.CylstepButtonGroup.Position = [(pansize2+240) 480 220 22];
            % Create CylstepCoarseToggButton
            app.CylstepCoarseToggButton = uitogglebutton(app.CylstepButtonGroup);
            app.CylstepCoarseToggButton.Text = 'Coarse';
            app.CylstepCoarseToggButton.Position = [1 1 55 22];
            app.CylstepCoarseToggButton.Value = true;
            % Create CylstepFineToggButton2
            app.CylstepFineToggButton = uitogglebutton(app.CylstepButtonGroup);
            app.CylstepFineToggButton.Text = 'Fine';
            app.CylstepFineToggButton.Position = [60 1 45 22];
            
            % Create CylstepFineEditField
            app.CylstepFineEditField = uieditfield(app.MaskTab, 'numeric');
            app.CylstepFineEditField.Limits = [0 Inf];
            app.CylstepFineEditField.RoundFractionalValues = 'off';
            app.CylstepFineEditField.ValueDisplayFormat = '%.2f';
            app.CylstepFineEditField.Position = [(pansize2+345) 480 54 22];
            app.CylstepFineEditField.Value = 1;
            app.CylstepFineEditField.ValueChangedFcn = createCallbackFcn(app, @CylstepValueChanged, true);
            
            % Create CylradSpinLabel
            app.CylradSpinLabel = uilabel(app.MaskTab);
            app.CylradSpinLabel.HorizontalAlignment = 'right';
            app.CylradSpinLabel.Position = [(pansize2+145) 431 30 22];
            app.CylradSpinLabel.Text = 'r';
            
            % Create CylradSpin
            app.CylradSpin = uispinner(app.MaskTab);
            app.CylradSpin.ValueDisplayFormat = '%.2f';
            app.CylradSpin.Value = 13;
            app.CylradSpin.Position = [(pansize2+180) 412 100 60];
            app.CylradSpin.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.CylradSpin.Step = app.CylstepEditField.Value;
            
            % Create CylhgtSpinLabel
            app.CylhgtSpinLabel = uilabel(app.MaskTab);
            app.CylhgtSpinLabel.HorizontalAlignment = 'right';
            app.CylhgtSpinLabel.Position = [(pansize2+275) 431 30 22];
            app.CylhgtSpinLabel.Text = 'h';
            
            % Create CylhgtSpin
            app.CylhgtSpin = uispinner(app.MaskTab);
            app.CylhgtSpin.ValueDisplayFormat = '%.2f';
            app.CylhgtSpin.Value = 50;
            app.CylhgtSpin.Position = [(pansize2+310) 412 100 60];
            app.CylhgtSpin.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.CylhgtSpin.Step = app.CylstepEditField.Value;
            
            % Create TransstepEditFieldLabel
            app.TransstepEditFieldLabel = uilabel(app.MaskTab);
            app.TransstepEditFieldLabel.HorizontalAlignment = 'left';
            app.TransstepEditFieldLabel.Position = [(pansize2+30) 350 190 22];
            app.TransstepEditFieldLabel.Text = 'Translation';
            
            % Create TransstepEditField
            app.TransstepEditField = uieditfield(app.MaskTab, 'numeric');
            app.TransstepEditField.Limits = [0 Inf];
            app.TransstepEditField.RoundFractionalValues = 'off';
            app.TransstepEditField.ValueDisplayFormat = '%.2f';
            app.TransstepEditField.Position = [(pansize2+180) 350 54 22];
            app.TransstepEditField.Value = 5;
            app.TransstepEditField.ValueChangedFcn = createCallbackFcn(app, @TransstepValueChanged, true);
            
            % Create TransstepButtonGroup
            app.TransstepButtonGroup = uibuttongroup(app.MaskTab);
            app.TransstepButtonGroup.BorderType = 'none';
            app.TransstepButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @TransstepValueChanged, true);
            app.TransstepButtonGroup.Position = [(pansize2+240) 350 220 22];
            % Create TransstepCoarseToggButton
            app.TransstepCoarseToggButton = uitogglebutton(app.TransstepButtonGroup);
            app.TransstepCoarseToggButton.Text = 'Coarse';
            app.TransstepCoarseToggButton.Position = [1 1 55 22];
            app.TransstepCoarseToggButton.Value = true;
            % Create TransstepFineToggButton
            app.TransstepFineToggButton = uitogglebutton(app.TransstepButtonGroup);
            app.TransstepFineToggButton.Text = 'Fine';
            app.TransstepFineToggButton.Position = [60 1 45 22];
            
            % Create TransstepFineEditField
            app.TransstepFineEditField = uieditfield(app.MaskTab, 'numeric');
            app.TransstepFineEditField.Limits = [0 Inf];
            app.TransstepFineEditField.RoundFractionalValues = 'off';
            app.TransstepFineEditField.ValueDisplayFormat = '%.2f';
            app.TransstepFineEditField.Position = [(pansize2+345) 350 54 22];
            app.TransstepFineEditField.Value = 1;
            app.TransstepFineEditField.ValueChangedFcn = createCallbackFcn(app, @TransstepValueChanged, true);
            
            % Create TransXSpinLabel
            app.TransXSpinLabel = uilabel(app.MaskTab);
            app.TransXSpinLabel.HorizontalAlignment = 'right';
            app.TransXSpinLabel.Position = [(pansize2+10) 301 30 22];
            app.TransXSpinLabel.Text = 'X';
            
            % Create TransXSpin
            app.TransXSpin = uispinner(app.MaskTab);
            app.TransXSpin.ValueDisplayFormat = '%.2f';
            app.TransXSpin.Position = [(pansize2+50) 282 100 60];
            app.TransXSpin.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.TransXSpin.Step = app.TransstepEditField.Value;
            app.TransXSpin.Value = 10;
            
            % Create TransYSpinLabel
            app.TransYSpinLabel = uilabel(app.MaskTab);
            app.TransYSpinLabel.HorizontalAlignment = 'right';
            app.TransYSpinLabel.Position = [(pansize2+145) 301 30 22];
            app.TransYSpinLabel.Text = 'Y';
            
            % Create TransYSpin
            app.TransYSpin = uispinner(app.MaskTab);
            app.TransYSpin.ValueDisplayFormat = '%.2f';
            app.TransYSpin.Position = [(pansize2+180) 282 100 60];
            app.TransYSpin.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.TransYSpin.Step = app.TransstepEditField.Value;
            app.TransYSpin.Value = 10;
            
            % Create TransZSpinLabel
            app.TransZSpinLabel = uilabel(app.MaskTab);
            app.TransZSpinLabel.HorizontalAlignment = 'right';
            app.TransZSpinLabel.Position = [(pansize2+275) 301 30 22];
            app.TransZSpinLabel.Text = 'Z';
            
            % Create TransZSpin
            app.TransZSpin = uispinner(app.MaskTab);
            app.TransZSpin.ValueDisplayFormat = '%.2f';
            app.TransZSpin.Position = [(pansize2+310) 282 100 60];
            app.TransZSpin.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.TransZSpin.Step = app.TransstepEditField.Value;
            app.TransZSpin.Value = 10;
            
            % Create RotstepEditFieldLabel
            app.RotstepEditFieldLabel = uilabel(app.MaskTab);
            app.RotstepEditFieldLabel.HorizontalAlignment = 'left';
            app.RotstepEditFieldLabel.Position = [(pansize2+30) 220 190 22];
            app.RotstepEditFieldLabel.Text = 'Rotation (°)';
            
            % Create RotstepEditField
            app.RotstepEditField = uieditfield(app.MaskTab, 'numeric');
            app.RotstepEditField.Limits = [0 Inf];
            app.RotstepEditField.RoundFractionalValues = 'off';
            app.RotstepEditField.ValueDisplayFormat = '%.2f';
            app.RotstepEditField.Position = [(pansize2+180) 220 54 22];
            app.RotstepEditField.Value = 5;
            app.RotstepEditField.ValueChangedFcn = createCallbackFcn(app, @RotstepValueChanged, true);
            
            % Create RotstepButtonGroup
            app.RotstepButtonGroup = uibuttongroup(app.MaskTab);
            app.RotstepButtonGroup.BorderType = 'none';
            app.RotstepButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @RotstepValueChanged, true);
            app.RotstepButtonGroup.Position = [(pansize2+240) 220 220 22];
            % Create RotstepCoarseToggButton
            app.RotstepCoarseToggButton = uitogglebutton(app.RotstepButtonGroup);
            app.RotstepCoarseToggButton.Text = 'Coarse';
            app.RotstepCoarseToggButton.Position = [1 1 55 22];
            app.RotstepCoarseToggButton.Value = true;
            % Create RotstepFineToggButton
            app.RotstepFineToggButton = uitogglebutton(app.RotstepButtonGroup);
            app.RotstepFineToggButton.Text = 'Fine';
            app.RotstepFineToggButton.Position = [60 1 45 22];
            
            % Create RotstepFineEditField
            app.RotstepFineEditField = uieditfield(app.MaskTab, 'numeric');
            app.RotstepFineEditField.Limits = [0 Inf];
            app.RotstepFineEditField.RoundFractionalValues = 'off';
            app.RotstepFineEditField.ValueDisplayFormat = '%.2f';
            app.RotstepFineEditField.Position = [(pansize2+345) 220 54 22];
            app.RotstepFineEditField.Value = 1;
            app.RotstepFineEditField.ValueChangedFcn = createCallbackFcn(app, @RotstepValueChanged, true);
            
            % Create AZSpinLabel
            app.AZSpinLabel = uilabel(app.MaskTab);
            app.AZSpinLabel.HorizontalAlignment = 'left';
            app.AZSpinLabel.Position = [(pansize2+30) 171 60 22];
            app.AZSpinLabel.Text = 'Azimuth';
            
            % Create AZSpin
            app.AZSpin = uispinner(app.MaskTab);
            app.AZSpin.ValueDisplayFormat = '%.2f';
            app.AZSpin.Position = [(pansize2+90) 152 90 60];
            app.AZSpin.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.AZSpin.Step = app.RotstepEditField.Value;
            
            % Create ELSpinLabel
            app.ELSpinLabel = uilabel(app.MaskTab);
            app.ELSpinLabel.HorizontalAlignment = 'left';
            app.ELSpinLabel.Position = [(pansize2+215) 171 60 22];
            app.ELSpinLabel.Text = 'Elevation';
            
            % Create ELSpin
            app.ELSpin = uispinner(app.MaskTab);
            app.ELSpin.ValueDisplayFormat = '%.2f';
            app.ELSpin.Position = [(pansize2+280) 152 90 60];
            app.ELSpin.ValueChangedFcn = createCallbackFcn(app, @Plotcylmask, true);
            app.ELSpin.Step = app.RotstepEditField.Value;
            app.ELSpin.Value = 90;
            
            % Create StrutfitLabel
            app.StrutfitLabel = uilabel(app.MaskTab);
            app.StrutfitLabel.HorizontalAlignment = 'left';
            app.StrutfitLabel.Position = [(pansize2+50) 80 100 22];
            app.StrutfitLabel.Text = 'Strut fit';
            
            % Create Strutfit
            app.Strutfit = uidropdown(app.MaskTab);
            app.Strutfit.Items = {'Cylinder', 'Elliptic cylinder'};
            app.Strutfit.Position = [(pansize2+100) 80 130 22];
            app.Strutfit.Value = 'Cylinder';
            
            % Create AnalysestrutButton
            app.AnalysestrutButton = uibutton(app.MaskTab, 'push');
            app.AnalysestrutButton.ButtonPushedFcn = createCallbackFcn(app, @AnalysestrutButtonPushed, true);
            app.AnalysestrutButton.Position = [(pansize2+50) 10 240 60];
            app.AnalysestrutButton.Text = 'Analyse strut';
            
            
            %% Create Analysis tab
            app.AnalysisTab = uitab(app.TabGroup);
            app.AnalysisTab.Title = 'Analysis';
            app.AnalysisTab.Scrollable = 'on';
            
            % Create Panel
            panheight = 0.5*appHgtSpace - 30;
            midheight = 0.5*appHgtSpace + 20;
            app.StrutaxesPanel = uipanel(app.AnalysisTab);
            app.StrutaxesPanel.Title = '';
            app.StrutaxesPanel.Position = [10 midheight (1.14*panheight) panheight];
            
            % Create Strut display UIAxes
            app.Strutaxes = uiaxes(app.StrutaxesPanel);
            app.Strutaxes.PlotBoxAspectRatio = [1 1 1];
            app.Strutaxes.Position = [0,0,app.StrutaxesPanel.Position(3),app.StrutaxesPanel.Position(4)];
            
            % Create Panel
            app.StrutaxesPanel2 = uipanel(app.AnalysisTab);
            app.StrutaxesPanel2.Title = '';
            app.StrutaxesPanel2.Position = [(1.14*panheight+20) midheight (1.14*panheight) panheight];
            
            % Create Levelled Strut display UIAxes
            app.Strutaxes2 = uiaxes(app.StrutaxesPanel2);
            app.Strutaxes2.PlotBoxAspectRatio = [1 1 1];
            app.Strutaxes2.Position = [0,0,app.StrutaxesPanel2.Position(3),app.StrutaxesPanel2.Position(4)];
            
            % Create Panel
            app.StrutaxesPanel3 = uipanel(app.AnalysisTab);
            app.StrutaxesPanel3.Title = '';
            app.StrutaxesPanel3.Position = [(2.28*panheight+30) midheight (1.14*panheight) panheight];
            
            % Create Unwrapped Strut display UIAxes
            app.Strutaxes3 = uiaxes(app.StrutaxesPanel3);
            app.Strutaxes3.PlotBoxAspectRatio = [1 1 1];
            app.Strutaxes3.Position = [0,0,app.StrutaxesPanel3.Position(3),app.StrutaxesPanel3.Position(4)];
            
            % Create Panel
            app.PxlPanel = uipanel(app.AnalysisTab);
            app.PxlPanel.Title = '';
            app.PxlPanel.Position = [(3.42*panheight+40) (midheight+(0.4*panheight)) 120 (0.6*panheight)];
            
            % Create PxEditFieldLabel
            app.PxEditFieldLabel = uilabel(app.PxlPanel);
            app.PxEditFieldLabel.HorizontalAlignment = 'left';
            app.PxEditFieldLabel.Position = [10 (0.6*panheight-30) 80 22];
            app.PxEditFieldLabel.Text = 'Pixel size (µm)';
            
            % Create PxEditField
            app.PxEditField = uieditfield(app.PxlPanel, 'numeric');
            app.PxEditField.Limits = [0 Inf];
            app.PxEditField.RoundFractionalValues = 'off';
            app.PxEditField.ValueDisplayFormat = '%.5f';
            app.PxEditField.Position = [10 (0.6*panheight-50) 80 22];
            app.PxEditField.ValueChangedFcn = createCallbackFcn(app, @replotstrutAll, true);
            
            % Create PlotUnitButtonGroup
            app.PlotUnitButtonGroup = uibuttongroup(app.PxlPanel);
            app.PlotUnitButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @replotstrutAll, true);
            app.PlotUnitButtonGroup.Title = 'Display plots in:';
            app.PlotUnitButtonGroup.AutoResizeChildren = 'on';
            app.PlotUnitButtonGroup.BorderType = 'none';
            app.PlotUnitButtonGroup.Position = [10 (0.6*panheight-160) 100 100];
            
            % Create PlotPxButton
            app.PlotPxButton = uiradiobutton(app.PlotUnitButtonGroup);
            app.PlotPxButton.Text = 'pixels';
            app.PlotPxButton.Position = [10 55 80 22];
            app.PlotPxButton.Value = true;
            
            % Create PlotUmButton
            app.PlotUmButton = uiradiobutton(app.PlotUnitButtonGroup);
            app.PlotUmButton.Text = 'µm';
            app.PlotUmButton.Position = [10 35 80 22];
            
            % Create PlotPxUmLabel
            app.PlotPxUmLabel = uilabel(app.PxlPanel);
            app.PlotPxUmLabel.FontSize = 11;
            app.PlotPxUmLabel.Position = [12 (0.6*panheight-170) 105 44];
            app.PlotPxUmLabel.Text = ['Note: results table is',newline,'always in pixel units'];
            
            
            % Create OptionsTabGroup
            app.OptionsTabGroup = uitabgroup(app.AnalysisTab);
            app.OptionsTabGroup.Position = [10 (midheight-320) 240 310];
            
            
            % Create StrutOpt tab
            app.StrutOpt = uitab(app.OptionsTabGroup);
            app.StrutOpt.Title = 'Strut';
            app.StrutOpt.AutoResizeChildren = 'on';
            
            % Create ViewalongButtonGroup
            app.StrutviewButtonGroup = uibuttongroup(app.StrutOpt);
            app.StrutviewButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @replotAstrut, true);
            app.StrutviewButtonGroup.Title = 'Strut view';
            app.StrutviewButtonGroup.AutoResizeChildren = 'on';
            app.StrutviewButtonGroup.BorderType = 'none';
            app.StrutviewButtonGroup.Position = [5 163 70 117];
            
            % Create StrutviewXButton
            app.StrutviewXButton = uiradiobutton(app.StrutviewButtonGroup);
            app.StrutviewXButton.Text = 'X axis';
            app.StrutviewXButton.Position = [11 71 55 22];
            
            % Create StrutviewYButton
            app.StrutviewYButton = uiradiobutton(app.StrutviewButtonGroup);
            app.StrutviewYButton.Text = 'Y axis';
            app.StrutviewYButton.Position = [11 49 55 22];
            
            % Create StrutviewZButton
            app.StrutviewZButton = uiradiobutton(app.StrutviewButtonGroup);
            app.StrutviewZButton.Text = 'Z axis';
            app.StrutviewZButton.Position = [11 27 54 22];
            
            % Create Strutview3DButton
            app.Strutview3DButton = uiradiobutton(app.StrutviewButtonGroup);
            app.Strutview3DButton.Text = '3D';
            app.Strutview3DButton.Position = [11 5 54 22];
            app.Strutview3DButton.Value = true;
            
            % Create StrutviewresetButton
            app.StrutviewresetButton = uibutton(app.StrutOpt, 'push');
            app.StrutviewresetButton.ButtonPushedFcn = createCallbackFcn(app, @replotAstrutReset, true);
            app.StrutviewresetButton.Position = [90 215 90 40];
            app.StrutviewresetButton.Text = 'Reset';
            
            % Create StrutviewwindButton
            app.StrutviewwindButton = uibutton(app.StrutOpt, 'push');
            app.StrutviewwindButton.ButtonPushedFcn = createCallbackFcn(app, @replotAstrutWind, true);
            app.StrutviewwindButton.Position = [90 170 90 40];
            app.StrutviewwindButton.Text = 'New window';
            
            % Create SVopacEditFieldLabel
            app.SVopacEditFieldLabel = uilabel(app.StrutOpt);
            app.SVopacEditFieldLabel.HorizontalAlignment = 'left';
            app.SVopacEditFieldLabel.Position = [10 135 50 22];
            app.SVopacEditFieldLabel.Text = 'Opacity';
            
            % Create SVopacEditField
            app.SVopacEditField = uieditfield(app.StrutOpt, 'numeric');
            app.SVopacEditField.Limits = [0 1];
            app.SVopacEditField.RoundFractionalValues = 'off';
            app.SVopacEditField.ValueDisplayFormat = '%.2f';
            app.SVopacEditField.Position = [65 135 54 22];
            app.SVopacEditField.Value = 0.3;
            app.SVopacEditField.ValueChangedFcn = createCallbackFcn(app, @replotAstrut, true);
            
            % Create StrutsurfcolourCheckBox
            app.StrutsurfcolourCheckBox = uicheckbox(app.StrutOpt);
            app.StrutsurfcolourCheckBox.Text = 'Show surface colour on strut';
            app.StrutsurfcolourCheckBox.Position = [10 105 200 22];
            app.StrutsurfcolourCheckBox.Value = false;
            app.StrutsurfcolourCheckBox.ValueChangedFcn = createCallbackFcn(app, @replotAstrut, true);
            
            % Create FitaxisCheckBox
            app.FitaxisCheckBox = uicheckbox(app.StrutOpt);
            app.FitaxisCheckBox.Text = 'Show fitted axis';
            app.FitaxisCheckBox.Position = [10 80 200 22];
            app.FitaxisCheckBox.Value = true;
            app.FitaxisCheckBox.ValueChangedFcn = createCallbackFcn(app, @replotAstrut, true);
            
            % Create SVExpstlButton
            app.SVExpstlButton = uibutton(app.StrutOpt, 'push');
            app.SVExpstlButton.ButtonPushedFcn = createCallbackFcn(app, @SVExpstlButtonPushed, true);
            app.SVExpstlButton.Position = [10 45 130 30];
            app.SVExpstlButton.Text = 'Export stl mesh';
            
            % Create SVExpcsvButton
            app.SVExpcsvButton = uibutton(app.StrutOpt, 'push');
            app.SVExpcsvButton.ButtonPushedFcn = createCallbackFcn(app, @SVExpcsvButtonPushed, true);
            app.SVExpcsvButton.Position = [10 10 130 30];
            app.SVExpcsvButton.Text = 'Export csv points';
            
            % Create LvlStrutOpt tab
            app.LvlStrutOpt = uitab(app.OptionsTabGroup);
            app.LvlStrutOpt.Title = 'Level strut';
            
            % Create ViewalongButtonGroup
            app.LvlstrutviewButtonGroup = uibuttongroup(app.LvlStrutOpt);
            app.LvlstrutviewButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @replotAlvlstrut, true);
            app.LvlstrutviewButtonGroup.Title = 'Levelled strut view';
            app.LvlstrutviewButtonGroup.AutoResizeChildren = 'on';
            app.LvlstrutviewButtonGroup.BorderType = 'none';
            app.LvlstrutviewButtonGroup.Position = [5 163 130 117];
            
            % Create LvlstrutviewXButton
            app.LvlstrutviewXButton = uiradiobutton(app.LvlstrutviewButtonGroup);
            app.LvlstrutviewXButton.Text = 'X axis';
            app.LvlstrutviewXButton.Position = [11 71 55 22];
            app.LvlstrutviewXButton.Value = true;
            
            % Create LvlstrutviewYButton
            app.LvlstrutviewYButton = uiradiobutton(app.LvlstrutviewButtonGroup);
            app.LvlstrutviewYButton.Text = 'Y axis';
            app.LvlstrutviewYButton.Position = [11 49 55 22];
            
            % Create LvlstrutviewZButton
            app.LvlstrutviewZButton = uiradiobutton(app.LvlstrutviewButtonGroup);
            app.LvlstrutviewZButton.Text = 'Z axis';
            app.LvlstrutviewZButton.Position = [11 27 54 22];
            
            % Create Lvlstrutview3DButton
            app.Lvlstrutview3DButton = uiradiobutton(app.LvlstrutviewButtonGroup);
            app.Lvlstrutview3DButton.Text = '3D';
            app.Lvlstrutview3DButton.Position = [11 5 54 22];
            
            % Create LvlstrutviewresetButton
            app.LvlstrutviewresetButton = uibutton(app.LvlStrutOpt, 'push');
            app.LvlstrutviewresetButton.ButtonPushedFcn = createCallbackFcn(app, @replotAlvlstrutReset, true);
            app.LvlstrutviewresetButton.Position = [90 215 90 40];
            app.LvlstrutviewresetButton.Text = 'Reset';
            
            % Create LvlstrutviewwindButton
            app.LvlstrutviewwindButton = uibutton(app.LvlStrutOpt, 'push');
            app.LvlstrutviewwindButton.ButtonPushedFcn = createCallbackFcn(app, @replotAlvlstrutWind, true);
            app.LvlstrutviewwindButton.Position = [90 170 90 40];
            app.LvlstrutviewwindButton.Text = 'New window';
            
            % Create LSVopacEditFieldLabel
            app.LSVopacEditFieldLabel = uilabel(app.LvlStrutOpt);
            app.LSVopacEditFieldLabel.HorizontalAlignment = 'left';
            app.LSVopacEditFieldLabel.Position = [10 135 50 22];
            app.LSVopacEditFieldLabel.Text = 'Opacity';
            
            % Create LSVopacEditField
            app.LSVopacEditField = uieditfield(app.LvlStrutOpt, 'numeric');
            app.LSVopacEditField.Limits = [0 1];
            app.LSVopacEditField.RoundFractionalValues = 'off';
            app.LSVopacEditField.ValueDisplayFormat = '%.2f';
            app.LSVopacEditField.Position = [65 135 54 22];
            app.LSVopacEditField.Value = 0.5;
            app.LSVopacEditField.ValueChangedFcn = createCallbackFcn(app, @replotAlvlstrut, true);
            
            % Create LvlstrutsurfcolourCheckBox
            app.LvlstrutsurfcolourCheckBox = uicheckbox(app.LvlStrutOpt);
            app.LvlstrutsurfcolourCheckBox.Text = 'Show surface colour on strut';
            app.LvlstrutsurfcolourCheckBox.Position = [10 105 200 22];
            app.LvlstrutsurfcolourCheckBox.Value = true;
            app.LvlstrutsurfcolourCheckBox.ValueChangedFcn = createCallbackFcn(app, @replotAlvlstrut, true);
            
            % Create FitxsecCheckBox
            app.FitxsecCheckBox = uicheckbox(app.LvlStrutOpt);
            app.FitxsecCheckBox.Text = 'Show fitted cross-section';
            app.FitxsecCheckBox.Position = [10 80 200 22];
            app.FitxsecCheckBox.Value = true;
            app.FitxsecCheckBox.ValueChangedFcn = createCallbackFcn(app, @replotAlvlstrut, true);
            
            % Create LSVExpstlButton
            app.LSVExpstlButton = uibutton(app.LvlStrutOpt, 'push');
            app.LSVExpstlButton.ButtonPushedFcn = createCallbackFcn(app, @LSVExpstlButtonPushed, true);
            app.LSVExpstlButton.Position = [10 45 130 30];
            app.LSVExpstlButton.Text = 'Export stl mesh';
            
            % Create LSVExpcsvButton
            app.LSVExpcsvButton = uibutton(app.LvlStrutOpt, 'push');
            app.LSVExpcsvButton.ButtonPushedFcn = createCallbackFcn(app, @LSVExpcsvButtonPushed, true);
            app.LSVExpcsvButton.Position = [10 10 130 30];
            app.LSVExpcsvButton.Text = 'Export csv points';
            
            % Create SurfOpt tab
            app.SurfOpt = uitab(app.OptionsTabGroup);
            app.SurfOpt.Title = 'Strut surface';
            
            % Create ViewalongButtonGroup
            app.SurfviewButtonGroup = uibuttongroup(app.SurfOpt);
            app.SurfviewButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @replotAsurf, true);
            app.SurfviewButtonGroup.Title = 'Surface view';
            app.SurfviewButtonGroup.AutoResizeChildren = 'on';
            app.SurfviewButtonGroup.BorderType = 'none';
            app.SurfviewButtonGroup.Position = [5 163 130 117];
            
            % Create SurfviewXButton
            app.SurfviewXButton = uiradiobutton(app.SurfviewButtonGroup);
            app.SurfviewXButton.Text = 'X axis';
            app.SurfviewXButton.Position = [11 71 55 22];
            
            % Create SurfviewYButton
            app.SurfviewYButton = uiradiobutton(app.SurfviewButtonGroup);
            app.SurfviewYButton.Text = 'Y axis';
            app.SurfviewYButton.Position = [11 49 55 22];
            
            % Create SurfviewZButton
            app.SurfviewZButton = uiradiobutton(app.SurfviewButtonGroup);
            app.SurfviewZButton.Text = 'Z axis';
            app.SurfviewZButton.Position = [11 27 54 22];
            app.SurfviewZButton.Value = true;
            
            % Create Surfview3DButton
            app.Surfview3DButton = uiradiobutton(app.SurfviewButtonGroup);
            app.Surfview3DButton.Text = '3D';
            app.Surfview3DButton.Position = [11 5 54 22];
            
            % Create SurfviewresetButton
            app.SurfviewresetButton = uibutton(app.SurfOpt, 'push');
            app.SurfviewresetButton.ButtonPushedFcn = createCallbackFcn(app, @replotAsurfReset, true);
            app.SurfviewresetButton.Position = [90 215 90 40];
            app.SurfviewresetButton.Text = 'Reset';
            
            % Create SurfviewwindButton
            app.SurfviewwindButton = uibutton(app.SurfOpt, 'push');
            app.SurfviewwindButton.ButtonPushedFcn = createCallbackFcn(app, @replotAsurfWind, true);
            app.SurfviewwindButton.Position = [90 170 90 40];
            app.SurfviewwindButton.Text = 'New window';
            
            % Create SurfExpstlButton
            app.SurfExpstlButton = uibutton(app.SurfOpt, 'push');
            app.SurfExpstlButton.ButtonPushedFcn = createCallbackFcn(app, @SurfExpstlButtonPushed, true);
            app.SurfExpstlButton.Position = [10 45 130 30];
            app.SurfExpstlButton.Text = 'Export stl mesh';
            
            % Create SurfExpcsvButton
            app.SurfExpcsvButton = uibutton(app.SurfOpt, 'push');
            app.SurfExpcsvButton.ButtonPushedFcn = createCallbackFcn(app, @SurfExpcsvButtonPushed, true);
            app.SurfExpcsvButton.Position = [10 10 130 30];
            app.SurfExpcsvButton.Text = 'Export csv points';
            
            % Create UITable
            app.AnalysisdataTable = uitable(app.AnalysisTab);
            %tabwid = 750;
            tabwid = appWidSpace - 270;
            app.AnalysisdataTable.ColumnName = {'View'; 'Slice dataset'; 'cb'; 'rs'; 'X'; 'Y'; 'Z'; 'VxF'; 'Cr'; 'Ch'; 'Ctx'; 'Cty'; 'Ctz'; 'Caz°'; 'Cel°'; 'cd'; 'El°'; 'D1'; 'D2'; 'Dfmx'; 'Dfmn'; 'Sa'; 'Sq'; 'Sz'};
            app.AnalysisdataTable.ColumnWidth = {45 , 'auto', 35, 35, 35, 35, 35, 40, 35, 35, 35, 35, 35, 45, 45, 50, 50, 50, 50, 50, 50, 50, 50, 50};
            app.AnalysisdataTable.Position = [260 60 tabwid (midheight-70)];
            app.AnalysisdataTable.CellSelectionCallback = createCallbackFcn(app, @ADTabCellSelection, true);
            app.AnalysisdataTable.ColumnFormat = {'char', 'char', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'};
            
            % Create ContextMenu
            app.AnalysisdataTableContextMenu = uicontextmenu(app.UIFigure);
            % Assign app.ContextMenu
            app.AnalysisdataTable.ContextMenu = app.AnalysisdataTableContextMenu;
            % Create Menu
            app.ADMenu = uimenu(app.AnalysisdataTableContextMenu);
            app.ADMenu.Text = '';
            % Create Menu2
            app.ADMenu2 = uimenu(app.AnalysisdataTableContextMenu);
            app.ADMenu2.Text = 'View analysis';
            app.ADMenu2.MenuSelectedFcn = createCallbackFcn(app, @ADTabViewSelected, true);
            % Create Menu3
            app.ADMenu3 = uimenu(app.AnalysisdataTableContextMenu);
            app.ADMenu3.Text = 'Delete selected row';
            app.ADMenu3.MenuSelectedFcn = createCallbackFcn(app, @ADTabDelSelected, true);
            
            % Create TableExpcsvButton
            app.TableExpcsvButton = uibutton(app.AnalysisTab, 'push');
            app.TableExpcsvButton.ButtonPushedFcn = createCallbackFcn(app, @TableExpcsvButtonPushed, true);
            app.TableExpcsvButton.Position = [700 15 200 30];
            app.TableExpcsvButton.Text = 'Save table';
            
            % Create TableUpdatecsvButton
            app.TableUpdatecsvButton = uibutton(app.AnalysisTab, 'push');
            app.TableUpdatecsvButton.ButtonPushedFcn = createCallbackFcn(app, @TableUpdatecsvButtonPushed, true);
            app.TableUpdatecsvButton.Position = [910 15 200 30];
            app.TableUpdatecsvButton.Text = 'Update saved table';
            app.TableUpdatecsvButton.Enable = 'off';
            
            %% Create Help tab
            app.HelpTab = uitab(app.TabGroup);
            app.HelpTab.Title = 'Help';
            app.HelpTab.Scrollable = 'on';
            
            % Create VersionLabel
            app.VersionLabel = uilabel(app.HelpTab);
            app.VersionLabel.FontSize = 14;
            app.VersionLabel.Position = [17 (appHgtSpace-90) 220 70];
            app.VersionLabel.Text = ['StrutSurf (version 1.0)',newline,'07/10/2021',newline,'Reece Oosterbeek'];
            
            % Create OpenmanualButton
            app.OpenmanualButton = uibutton(app.HelpTab, 'push');
            app.OpenmanualButton.ButtonPushedFcn = createCallbackFcn(app, @OpenmanualButtonPushed, true);
            app.OpenmanualButton.Position = [17 (appHgtSpace-160) 220 60];
            app.OpenmanualButton.Text = 'Open user manual';
            
            % Show the figure after all components are created
            pause(3)
            app.UIFigure.Visible = 'on';
        end
    end
    
    % App creation and deletion
    methods (Access = public)
        
        % Construct app
        function app = StrutSurf
            
            % Create UIFigure and components
            createComponents(app)
            
            
            % Register the app with App Designer
            %registerApp(app, app.UIFigure)
            
            if nargout == 0
                clear app
            end
        end
        
        % Code that executes before app deletion
        function delete(app)
            
            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end