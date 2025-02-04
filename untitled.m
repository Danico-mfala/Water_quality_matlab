function get_water_data1()
    % Define the drinking water standards
    % Cell arrays
    standards = struct('pH', [6.5, 8.5], 'turbidity', 1, 'tds', 500, ...
                       'hardness', 200, 'sulphates', 200, ...
                       'bod', 5, 'cod', 10, 'do', [6.5, 8], ...
                       'nitrate', 10, 'alkalinity', 200);

    while true
        % Create a menu for the user to choose an option
        choice = menu('Select an option:', ...
                      'Import data from an Excel file', ...
                      'Enter data manually', ...
                      'Exit');

        switch choice
            case 1
                % Import data from an Excel file
                filename = input('Enter the Excel file name (including extension): ', 's');
                if isfile(filename)
                    % Read the data from the Excel file
                    imported_data = readtable(filename);

                    % Convert the table to a structure
                    water_data = table2struct(imported_data, 'ToScalar', true);
                else
                    error('File not found. Please ensure the file exists in the current directory.');
                end
            case 2
                % Enter data manually
                % Initialize water_data structure
                water_data = struct();

                % Get and validate user inputs
                water_data.pH = get_valid_input('Enter pH value: ', @(x) x >= standards.pH(1) && x <= standards.pH(2), 3);
                water_data.turbidity = get_valid_input('Enter Turbidity (NTU): ', @(x) x <= standards.turbidity, 3);
                water_data.tds = get_valid_input('Enter Total Dissolved Solids (mg/l): ', @(x) x <= standards.tds, 3);
                water_data.hardness = get_valid_input('Enter Total Hardness (as CaCO3, mg/l): ', @(x) x == standards.hardness, 3);
                water_data.sulphates = get_valid_input('Enter Sulphates (mg/l): ', @(x) x <= standards.sulphates, 3);
                water_data.bod = get_valid_input('Enter BOD (mg/l): ', @(x) x <= standards.bod, 3);
                water_data.cod = get_valid_input('Enter COD (mg/l): ', @(x) x <= standards.cod, 3);
                water_data.do = get_valid_input('Enter DO (mg/l): ', @(x) x >= standards.do(1) && x <= standards.do(2), 3);
                water_data.nitrate = get_valid_input('Enter Nitrate (mg/l): ', @(x) x == standards.nitrate, 3);
                water_data.alkalinity = get_valid_input('Enter Total Alkalinity (as CaCO3, mg/l): ', @(x) x == standards.alkalinity, 3);
            case 3
                % Exit the program
                fprintf('Exiting the program.\n');
                return;
        end

        % Save the structure to a .mat file
        save('water_data.mat', 'water_data');

        % Initialize a flag to determine if water is suitable for drinking
        is_safe = true;

        % Compare the user input against the standards and display messages
        if water_data.pH < standards.pH(1) || water_data.pH > standards.pH(2)
            fprintf('Warning: pH value (%.2f) is out of the acceptable range (6.5 - 8.5)\n', water_data.pH);
            is_safe = false;
        end
        if water_data.turbidity > standards.turbidity
            fprintf('Warning: Turbidity value (%.2f NTU) exceeds the standard (<= 1 NTU)\n', water_data.turbidity);
            is_safe = false;
        end
        if water_data.tds > standards.tds
            fprintf('Warning: Total Dissolved Solids (%.2f mg/l) exceeds the standard (<= 500 mg/l)\n', water_data.tds);
            is_safe = false;
        end
        if water_data.hardness ~= standards.hardness
            fprintf('Warning: Total Hardness (%.2f mg/l) does not meet the standard (= 200 mg/l)\n', water_data.hardness);
            is_safe = false;
        end
        if water_data.sulphates > standards.sulphates
            fprintf('Warning: Sulphates (%.2f mg/l) exceed the standard (<= 200 mg/l)\n', water_data.sulphates);
            is_safe = false;
        end
        if water_data.bod > standards.bod
            fprintf('Warning: BOD (%.2f mg/l) exceeds the standard (<= 5 mg/l)\n', water_data.bod);
            is_safe = false;
        end
        if water_data.cod > standards.cod
            fprintf('Warning: COD (%.2f mg/l) exceeds the standard (<= 10 mg/l)\n', water_data.cod);
            is_safe = false;
        end
        if water_data.do < standards.do(1) || water_data.do > standards.do(2)
            fprintf('Warning: DO value (%.2f mg/l) is out of the acceptable range (6.5 - 8 mg/l)\n', water_data.do);
            is_safe = false;
        end
        if water_data.nitrate ~= standards.nitrate
            fprintf('Warning: Nitrate (%.2f mg/l) does not meet the standard (= 10 mg/l)\n', water_data.nitrate);
            is_safe = false;
        end
        if water_data.alkalinity ~= standards.alkalinity
            fprintf('Warning: Total Alkalinity (%.2f mg/l) does not meet the standard (= 200 mg/l)\n', water_data.alkalinity);
            is_safe = false;
        end

        % Provide a summary evaluation
        if is_safe
            fprintf('The water meets all the drinking water standards and is considered safe for drinking.\n');
            result = 'Safe';
        else
            fprintf('The water does not meet one or more drinking water standards and is not considered safe for drinking.\n');
            result = 'Not Safe';
        end

        % Ask the user if they want to save the data to an Excel file
        save_to_excel = input('Do you want to save the data to an Excel file? (y/n): ', 's');
        if lower(save_to_excel) == 'y'
            % Define the filename for the Excel file
            filename = 'water_quality_data.xlsx';

            % Prepare data for writing to Excel
            data = struct2table(water_data);
            data.Result = {result};

            % Write data to Excel file
            if isfile(filename)
                % Append to the existing file
                writetable(data, filename, 'WriteMode', 'append', 'WriteVariableNames', false);
            else
                % Create a new file
                writetable(data, filename);
            end
            fprintf('Data has been saved to %s\n', filename);
        end

        % Plot the data
        plot_data(water_data, standards);

        % Ask the user if they want to test another water sample
        cont = input('Do you want to test another water sample? (y/n): ', 's');
        if lower(cont) ~= 'y'
            break;
        end
    end
end

function value = get_valid_input(prompt, validation_func, max_attempts)
    attempts = 0;
    while attempts < max_attempts
        value = input(prompt);
        if validation_func(value)
            return;
        else
            fprintf('Invalid input. Please try again.\n');
            attempts = attempts + 1;
        end
    end
    error('Maximum attempts exceeded. Exiting program.');
end

function plot_data(water_data, standards)
    % Define the parameters and their values
    parameters = {'pH', 'turbidity', 'tds', 'hardness', 'sulphates', 'bod', 'cod', 'do', 'nitrate', 'alkalinity'};
    user_values = [water_data.pH, water_data.turbidity, water_data.tds, water_data.hardness, ...
                   water_data.sulphates, water_data.bod, water_data.cod, water_data.do, ...
                   water_data.nitrate, water_data.alkalinity];
    standard_values = [mean(standards.pH), standards.turbidity, standards.tds, standards.hardness, ...
                       standards.sulphates, standards.bod, standards.cod, mean(standards.do), ...
                       standards.nitrate, standards.alkalinity];

    % Create the 3D bar plot
    figure;
    bar3([standard_values; user_values]', 0.4);
    set(gca, 'xticklabel', {'Standard', 'User'});
    set(gca, 'yticklabel', parameters);
    legend({'Standard', 'User'}, 'Location', 'northeastoutside');
    title('Water Quality Parameters');gui
    zlabel('Values');
    xlabel('Source');
    ylabel('Parameters');

    % Customize the plot
    colormap([1 0 0; 0 0 1]); % Red for standards, Blue for user values
end
