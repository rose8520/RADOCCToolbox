%%Automatically script a code to capture images


%Using Kinect_images.m to obtain and save images 

%%Automatically script to run the calibration coding


%%Run calib.m to see the buttons function

%% Go to data_calib_rosie to always change the name of the file (if present)

for i=1:10;    
    %Reading images in
    I = load_image(1,'calibdance','jpg',1,i,1);    
end;
%Read images into calib toolbox. 

%Extract the grid corners. 
click_calib_rose;
go_calib_optim;
ext_calib;

% Pink-cushion effects on figures and projection of errors
reproject_calib;

% Showing instrinsics properties 
show_calib_results;



% Printing the extrinsics values
% For n = 1:10
H_1
H_2
.
.
K
H_n