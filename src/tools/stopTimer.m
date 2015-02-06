function stopTimer(timer)
    % Stop a timer

    time = toc(timer.tic);
    display(['[time: ' num2str(round(time*100)/100) ' seconds]']);
end