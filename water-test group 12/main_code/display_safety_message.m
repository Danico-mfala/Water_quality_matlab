% Display a message box indicating water safety
function display_safety_message(is_safe)
    if is_safe
        msgbox('The water meets all the drinking water standards and is considered safe for drinking.', 'Success', 'modal');
    else
        msgbox('The water does not meet one or more drinking water standards and is not considered safe for drinking.', 'Warning', 'modal');
    end
end
