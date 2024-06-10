% Import water data from an Excel file
function water_data = import_data_from_excel()
    [filename, pathname] = uigetfile({'*.xlsx','Excel files (*.xlsx)'}, 'Select an Excel file');
    if isequal(filename, 0) || isequal(pathname, 0)
        disp('User canceled the operation');
        water_data = [];
        return;
    end
    fullpath = fullfile(pathname, filename);
    imported_data = readtable(fullpath);
    water_data = table2struct(imported_data, 'ToScalar', true);
end
