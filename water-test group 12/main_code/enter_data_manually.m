% Enter water data manually
function water_data = enter_data_manually()
    water_data = struct();
    prompt = {'pH value:', 'Turbidity (NTU):', 'Total Dissolved Solids (mg/l):', ...
              'Total Hardness (as CaCO3, mg/l):', 'Sulphates (mg/l):', ...
              'BOD (mg/l):', 'COD (mg/l):', 'DO (mg/l):', ...
              'Nitrate (mg/l):', 'Total Alkalinity (as CaCO3, mg/l):'};
    dlg_title = 'Enter Data';
    num_lines = 1;
    default_data = {'', '', '', '', '', '', '', '', '', ''};
    input_data = inputdlg(prompt, dlg_title, num_lines, default_data);
    
    for i = 1:numel(input_data)
        water_data.(lower(strrep(prompt{i}, ' ', '_'))) = str2double(input_data{i});
    end
end
