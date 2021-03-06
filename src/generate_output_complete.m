% Automatically generate a complete schedule pdf

fh = fopen('../output/schedule-complete.tex', 'w');

content = [...
    '\\documentclass[letterpaper]{article}\n'...
    '\\usepackage[a4paper,margin=1in]{geometry}\n'...
    '\\usepackage[T1]{fontenc}\n'...
    '\\usepackage[utf8x]{inputenc}\n'...
    '\\usepackage{lastpage}\n'...
    '\\usepackage{fancyhdr}\n'...
    '\\usepackage{afterpage}\n'...
    '\\usepackage{hyperref}\n'...
    '\\usepackage{tabularx}\n'...
    '\\usepackage{titlesec}\n'...
    '\\usepackage{float}\n'...
    '\\pagestyle{fancy}\n'...
    '\\titleformat{\\section}[hang]{\\normalfont\\bfseries\\Large}{}{0pt}{}\n'...
    '\\renewcommand{\\thesection}{}\n'...
    '\\renewcommand{\\thesubsection}{\\arabic{subsection}}\n'...
    '\\lhead{}\n'...
    '\\chead{}\n'...
    '\\rhead{}\n'...
    '\\lfoot{}\n'...
    '\\cfoot{}\n'...
    '\\rfoot{Page~\\thepage~of~\\pageref{LastPage}}\n'...
    '\\renewcommand{\\headrulewidth}{0pt}\n'...
    '\\renewcommand{\\footrulewidth}{0pt}\n'...
    '\\begin{document}\n'...
    '\\begin{center}\\textit{This document is automatically generated by the EEMCS RD algorithm.}\\end{center}\n'...
    '\\tableofcontents\n'...
    '\\newpage\n'...
    '\\section{Schedule overview}\n'...
];
fprintf(fh, content);

for j = 1:program.numComps
    compID = program.compID(j);
    fprintf(fh,'\\subsection{%s} \n', program.compName{j});
    fprintf(fh,'\\subsubsection{Schedule} \n');
    generateCompanyTables(fh, program, scheduleInjected, j);
    fprintf(fh,'\\subsubsection{Waiting list} \n');
    generateWaitingListTables(fh, program, scheduleInjected, waitingList, j);
end

fprintf(fh, '\\end{document}\n');

fclose(fh);

cd ../output
[~,~] = system('pdflatex schedule-complete.tex');
[~,~] = system('pdflatex schedule-complete.tex');
[~,~] = system('mv schedule-complete.pdf pdf-comps/schedule-complete.pdf');
cd ../src