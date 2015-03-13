%% Distribution scheduled
% Find amount of times every student is scheduled
amount = zeros(program.numStuds, 1);
for i = 1:program.numStuds
    for j = 1:program.numComps
        for k = 1:program.numDays
            for b = 1:length(schedule{j,k})
                for s = 1:program.numInters
                    if schedule{j,k}{b}(s) == i
                        amount(i) = amount(i) + 1;
                    end
                end
            end
        end
    end
end

% Put all amounts of scheduled into bins
x = 0:9;
y = zeros(10, 1);
for i = 1:program.numStuds
    y(amount(i)+1) = y(amount(i)+1) + 1;
end

figure(1);
cla
stem(x,y/program.numStuds*100,'or','MarkerSize',8,'MarkerFaceColor','red');
xlabel('Times scheduled','FontSize',12);
ylabel('Number students (percentage)','FontSize',12);
title('Scheduling distribution','FontSize',14);
grid on

%% Distribution liked
% Find amount of times every student is liked
amount = zeros(program.numStuds, 1);
for i = 1:program.numStuds
    for j = 1:program.numComps
        if program.compInt(j,i)
            amount(i) = amount(i) + 1;
        end
    end
end

% Put all amounts of likes into bins
x = 0:program.numComps;
y = zeros(program.numComps+1, 1);
for i = 1:program.numStuds
    y(amount(i)+1) = y(amount(i)+1) + 1;
end

figure(2);
cla
stem(x,y/program.numStuds*100,'or','MarkerSize',8,'MarkerFaceColor','red');
xlabel('Times liked by company','FontSize',12);
ylabel('Number students (percentage)','FontSize',12);
title('Times liked distribution','FontSize',14);
grid on


%% Non-scheduled perfect matches
display 'Non-scheduled perfect matches:'
for i = 1:program.numStuds
    for j = 1:program.numComps
        if program.studInt(i,j) && program.compInt(j,i)
            scheduled = 0;
            for k = 1:program.numDays
                for b = 1:length(schedule{j,k})
                    for s = 1:program.numInters
                        if schedule{j,k}{b}(s) == i
                            scheduled = 1;
                        end
                    end
                end
            end
            % Check if not scheduled
            if ~scheduled
                fprintf('%s (%d) - %s (%d)\n',...
                    program.studName{i},...
                    program.studID(i),...
                    program.compName{j},...
                    program.compID(j));
            end
        end
    end
end
                
               
                          


