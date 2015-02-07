function displayPassed(message, passed)
    if passed
        display(['TEST: ' message ': OK']);
    else
        display(['TEST: ' message ': failed']);
    end
end