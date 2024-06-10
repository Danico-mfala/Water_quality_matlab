% Main loop to get water data and analyze it
function run_main_loop(standards)
    while true
        choice = menu('Select an option:', ...
                      'Import data from an Excel file', ...
                      'Enter data manually', ...
                      'Exit');
        
        switch choice
            case 1
                water_data = import_data_from_excel();
            case 2
                water_data = enter_data_manually();
            case 3
                fprintf('Exiting the program.\n');
                return;
        end
        
        if isempty(water_data)
            continue;
        end
        
        save('water_data.mat', 'water_data');
        is_safe = check_water_safety(water_data, standards);
        
        display_safety_message(is_safe);
        save_data_to_excel(water_data, is_safe);
        plot_data(water_data, standards);
        
        if ~test_another_sample()
            break;
        end
    end
end
