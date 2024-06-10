% Check if the water meets safety standards
function is_safe = check_water_safety(water_data, standards)
    % Check each parameter against the standard
    is_safe = true;
    if water_data.pH < standards.pH(1) || water_data.pH > standards.pH(2)
        is_safe = false;
    end
    if water_data.turbidity > standards.turbidity
        is_safe = false;
    end
    if water_data.tds > standards.tds
        is_safe = false;
    end
    if water_data.hardness > standards.hardness
        is_safe = false;
    end
    if water_data.sulphates > standards.sulphates
        is_safe = false;
    end
    if water_data.bod > standards.bod
        is_safe = false;
    end
    if water_data.cod > standards.cod
        is_safe = false;
    end
    if water_data.do < standards.do(1) || water_data.do > standards.do(2)
        is_safe = false;
    end
    if water_data.nitrate > standards.nitrate
        is_safe = false;
    end
    if water_data.alkalinity > standards.alkalinity
        is_safe = false;
    end
end
