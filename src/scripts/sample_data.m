program.compVia = ones(program.numComps, program.numStuds);

% Companies A (1), B (2), C (3) and D (4)
% A: one students on day 1, one students on day 2
program.compDay(1,1:2) = 1;

% B: two students on day 2
program.compDay(2,2) = 2;

% C: two students on day 3
program.compDay(3,3) = 2;

% D: one students on day 2, one students on day 3
program.compDay(4,2:3) = 1;

% Total availability: 8 spots

% Students 1 to 8
% First four available first two Day
% Last four available last two Day
program.studDay(1:4,1:2) = 1;
program.studDay(5:8,2:3) = 1;

% First four like first two companies
program.studInt(1:4,1:2) = 1;
program.studInt(2,1:2) = 0; % But not student two

% Last four like last two companies
program.studInt(5:8,3:4) = 1;

% First two companies like first five students
program.compInt(1:2,1:5) = 1;

% Last two companies like last five students
program.compInt(3:4,4:8) = 1;