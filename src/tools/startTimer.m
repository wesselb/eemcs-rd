function [timer] = startTimer(title)
    % Start a timer
    
    timer = struct;
    timer.title = title;
    timer.tic = tic;
    display(['[' title ']']);
end