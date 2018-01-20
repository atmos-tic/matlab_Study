s = serial('COM1');
fopen(s);
fprintf(s,'*IDN?');
out = fscanf(s);

fclose(s);
delete(s);
clear s