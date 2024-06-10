% Plot water data against standards
function plot_data(water_data, standards)
    parameters = {'pH', 'turbidity', 'tds', 'hardness', 'sulphates', 'bod', 'cod', 'do', 'nitrate', 'alkalinity'};
    user_values = [water_data.pH, water_data.turbidity, water_data.tds, water_data.hardness, ...
                   water_data.sulphates, water_data.bod, water_data.cod, water_data.do, ...
                   water_data.nitrate, water_data.alkalinity];
    standard_values = [mean(standards.pH), standards.turbidity, standards.tds, standards.hardness, ...
                       standards.sulphates, standards.bod, standards.cod, mean(standards.do), ...
                       standards.nitrate, standards.alkalinity];

    figure;
    for i = 1:length(parameters)
        subplot(3, 4, i);
        bar([standard_values(i); user_values(i)]);
        set(gca, 'xticklabel', {'Standard', 'User'});
        title(parameters{i});
        ylabel('Value');
        if i == 1
            legend({'Standard', 'User'}, 'Location', 'northeastoutside');
        end
    end

    figure;
    plot_3d(water_data, standards);
end
