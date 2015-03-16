% Automatically generate all company's schedules

for j = 1:program.numComps
    disp(['Generate output company: ' num2str(j) '/' num2str(program.numComps)]);
    
    filename = [];
    fh = fopen(['../output/doc-comp-' num2str(program.compID(j)) '.tex'], 'w');

    content = [...
        '\\documentclass{article}\n'...
        '\\usepackage[top=1.7in, bottom=0.5in, left=0.75in, right=0.75in]{geometry}\n'...
        '\\usepackage{tabularx}\n'...
        '\\usepackage{float}\n'...
        '\\newlength\\tindent\n'...
        '\\setlength{\\tindent}{\\parindent}\n'...
        '\\setlength{\\parindent}{0pt}\n'...
        '\\setlength{\\parskip}{2em}\n'...
        '\\setlength{\\tabcolsep}{10pt}\n'...
        '\\renewcommand{\\indent}{\\hspace*{\\tindent}}\n'...
        '\\renewcommand{\\arraystretch}{1.4}\n'...
        '\\renewcommand*{\\familydefault}{\\sfdefault}\n'...
        '\\begin{document}\n'...
        '\\pagenumbering{gobble}\n'...
        '\\LARGE{' program.compName{j} '}\\newline\n'...
        '\\large{Interview schedule}\n'...
        '\\normalsize\n'...
     ];
    fprintf(fh, content);
    
    generateCompanyTables(fh, program, scheduleInjected, j);
    fprintf(fh, '\\end{document}\n');

    fclose(fh);

    cd ../output
    [~,~] = system(['pdflatex doc-comp-' num2str(program.compID(j)) '.tex']);
    [~,~] = system(['pdflatex doc-comp-' num2str(program.compID(j)) '.tex']);
    [~,~] = system(['mv doc-comp-' num2str(program.compID(j)) '.pdf "pdf-comps/' program.compName{j} '.pdf"']);
    cd ../src
end