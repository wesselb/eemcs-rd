function [scheduleInjected] = injectRules(program, schedule)
    % Inject the specified rules into the schedule
    
    load_rules
    
    for r = 1:size(rules,1)
        studOld = rules{r,1};
        studNew = rules{r,2};
        compID = rules{r,3};
        compInt = rules{r,4};
        day = rules{r,5};
        slot = rules{r,6};
        
        % Check precondition
        if day <= 0 || day > program.numDays
            error(['Incorrect day for rule ' num2str(r)]);
        end
        if isempty(getCompanyIndex(program, compID))
            error(['Incorrect company for rule ' num2str(r)]);
        end
        if isempty(getStudentIndex(program, studOld)) && studOld ~= 0
            error(['Incorrect old student for rule ' num2str(r)]);
        end
        if isempty(getStudentIndex(program, studNew)) && studNew ~= 0
            error(['Incorrect new student for rule ' num2str(r)]);
        end
        if slot <= 0 || slot > program.numInters
            error(['Incorrect slot for rule ' num2str(r)]);
        end
        if compInt <= 0 || compInt > length(schedule{getCompanyIndex(program, compID), day})
            error(['Incorrect interviewer for rule ' num2str(r)]);
        end
        if (studOld == 0 && schedule{getCompanyIndex(program, compID), day}{compInt}(slot) ~= 0) ||...
            (studOld > 0 && schedule{getCompanyIndex(program, compID), day}{compInt}(slot) ~= getStudentIndex(program, studOld))
                error(['Schedule not compatible for rule ' num2str(r)])
        end
        
        if studNew == 0
            schedule{getCompanyIndex(program, compID), day}{compInt}(slot) = 0;
        else
            schedule{getCompanyIndex(program, compID), day}{compInt}(slot) = getStudentIndex(program, studNew);
        end
    end
    
    scheduleInjected = schedule;
end