% Plot water data against standards in 3D
function plot_3d(water_data, standards)
    parameters = {'pH', 'turbidity', 'tds', 'hardness', 'sulphates', 'bod', 'cod', 'do', 'nitrate', 'alkalinity'};
    user_values = [water_data.pH, water_data.turbidity, water_data.tds, water_data.hardness, ...
                   water_data.sulphates, water_data.bod, water_data.cod, water_data.do, ...
                   water_data.nitrate, water_data.alkalinity];
    standard_values = [mean(standards.pH), standards.turbidity, standards.tds, standards.hardness, ...
                       standards.sulphates, standards.bod, standards.cod, mean(standards.do), ...
                       standards.nitrate, standards.alkalinity];

    bar3([standard_values; user_values]', 0.4);
    set(gca, 'xticklabel', {'Standard', 'User'});
    set(gca, 'yticklabel', parameters);
    zlabel('Values');
    xlabel('Source');
    ylabel('Parameters');
    title('Water Quality Parameters 3D');
    colormap([1 0 0; 0 0 1]);
end
