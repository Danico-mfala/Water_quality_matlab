function water_data = get_water_data1()
    % Prompt the user to enter values for various water quality parameters
    pH = input('Enter pH value: ');
    turbidity = input('Enter Turbidity (NTU): ');
    tds = input('Enter Total Dissolved Solids (mg/l): ');
    hardness = input('Enter Total Hardness (as CaCO3, mg/l): ');
    sulphates = input('Enter Sulphates (mg/l): ');
    bod = input('Enter BOD (mg/l): ');
    cod = input('Enter COD (mg/l): ');
    do = input('Enter DO (mg/l): ');
    nitrate = input('Enter Nitrate (mg/l): ');
    alkalinity = input('Enter Total Alkalinity (as CaCO3, mg/l): ');

    % Store the input values in a structure
    water_data = struct('pH', pH, 'turbidity', turbidity, 'tds', tds, ...
                        'hardness', hardness, 'sulphates', sulphates, ...
                        'bod', bod, 'cod', cod, 'do', do, ...
                        'nitrate', nitrate, 'alkalinity', alkalinity);

    % Save the structure to a .mat file
    save('water_data.mat', 'water_data');
    
    % Define the drinking water standards
    standards = struct('pH', [6.5, 8.5], 'turbidity', 1, 'tds', 500, ...
                       'hardness', 200, 'sulphates', 200, ...
                       'bod', 5, 'cod', 10, 'do', [6.5, 8], ...
                       'nitrate', 10, 'alkalinity', 200);
    
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
    else
        fprintf('The water does not meet one or more drinking water standards and is not considered safe for drinking.\n');
    end
end
