% An example of how your function will be called, and what it should
% output.
% image_file_path is the absolute path to the image that you should
% process. This should be used to read in the file.
% image_file_name is just the name of the image. This should be written to
% the output file.
% output_file_path is the absolute path to the file where you should output
% the name of the file as well as the chocolates that you have detected.
% program_folder is the folder that your function is running in.
function z3330656_MTRN4230_ASST1(image_file_path, image_file_name, ...
    output_file_path, program_folder)

im = imread(image_file_path);

chocolates = detect_chocolates(im);

write_output_file(chocolates, image_file_name, output_file_path);

% Your chocolate detection.
function c = detect_chocolates(im)

Data = detect(im);
c=Data;
% Do your image processing...

% You may store your results in matrix as shown below.
%    X    Y    Theta Length Width Flavour     1 = Top     1 = Reachable   1 = Pickable
%                                             0 = Bottom  0 = Unreachable 0 = Not pickable
% c = [100, 100, 0.1,  177,  81,    3,          1,          1,              1                ;  % First chocolate.
%      200, 200, 0.2,  177,  81,    1,          0,          0,              0                ]; % Second chocolate.

 % This is an example of how to write the results to file.
 % This will only work if you store your chocolates exactly as above.
 % Please ensure that you output your detected chocolates correctly. A
 % script will be made available so that you can run the comparison
 % yourselves, to test that it is working.
function write_output_file(chocolates, image_file_name, output_file_path)

fid = fopen(output_file_path, 'w');

fprintf(fid, 'image_file_name:\n');
fprintf(fid, '%s\n', image_file_name);
fprintf(fid, 'rectangles:\n');
fprintf(fid, ...
        [repmat('%f ', 1, size(chocolates, 2)), '\n'], chocolates');
    
% Please ensure that you close any files that you open. If you fail to do
% so, there may be a noticeable decrease in the speed of your processing.
fclose(fid);
