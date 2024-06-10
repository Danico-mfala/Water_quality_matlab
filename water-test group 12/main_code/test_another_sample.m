% Prompt the user to test another water sample
function retest = test_another_sample()
    test_again = questdlg('Do you want to test another water sample?', 'Test Again', 'Yes', 'No', 'No');
    retest = strcmpi(test_again, 'Yes');
end
