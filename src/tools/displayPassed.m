function displayPassed(message, passed)
    if passed
        display([message ': OK']);
    else
        display([message ': failed']);
    end
end