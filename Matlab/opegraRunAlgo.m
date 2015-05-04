function [] = opegraRunAlgo() 
args = importdata('matlab_args.txt');
file_path = char(args(1));
tic;
predicted = Test(file_path);
elapsedTime = round(toc);
time_filename = 'time.txt';
fid1 = fopen(time_filename,'w');
fprintf(fid1,'%d', elapsedTime);
fclose(fid1);
output_filename = 'results.txt';
fid2 = fopen(output_filename, 'w');
dlmwrite(output_filename,predicted,'-append',...  %# Print the matrix
'delimiter',' ',...
'newline','pc');
fclose(fid2);
end