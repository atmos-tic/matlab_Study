%https://jp.mathworks.com/help/matlab/matlab_external/writing-and-reading-data.html
s = serial('COM1');
fopen(s);
fprintf(s,'*IDN?');
out = fscanf(s);

fclose(s);
delete(s);
clear s