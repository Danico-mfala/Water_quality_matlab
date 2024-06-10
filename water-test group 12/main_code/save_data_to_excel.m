% Save water data to an Excel file
function save_data_to_excel(water_data, is_safe)
    result = 'Safe';
    if ~is_safe
        result = 'Not Safe';
    end
    
    save_to_excel = questdlg('Do you want to save the data to an Excel file?', 'Save to Excel', 'Yes', 'No', 'No');
    if strcmpi(save_to_excel, 'Yes')
        filename = 'water_quality_data.xlsx';
        data = struct2table(water_data);
        data.Result = {result};
        
        if isfile(filename)
            writetable(data, filename, 'WriteMode', 'append', 'WriteVariableNames', false);
        else
            writetable(data, filename);
        end
        fprintf('Data has been saved to %s\n', filename);
    end
end
