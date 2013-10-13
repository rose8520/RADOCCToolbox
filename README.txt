README FILE

==========================================================================================================
This folder allows user to perform an automatic Camera Calibration using a standard 30mm x 30mm squares 
checkerboard. 

1. Run the code Rosie.m to allow automatic camera calibration by using Kinect_images to obtain the checkerboard
images.

2. The code allows user to capture up to 10 image of checkerboard dance as found within the folder as an example. 

3. It's purely up to user to choose how many images to take.

4. The Rosie.m code is dependent on the RADOOCToolbox and the other scripts :
	-click_calib_rose
	-data_calib_rosie
	-go_calib_optim
	-ext_calib
	-reproject_calib
	-show_calib_results

--------------------------------------------------------------------------------------------------------------

5. If you are to change the name of the load_images in Rosie.m as such

for i=1:10;    
    %Reading images in
    I = load_image(1,'calibdance','jpg',1,i,1);    
end;


############################## TO #####################################


for i=1:10;    
    %Reading images in
    I = load_image(1,'cameracalib','jpg',1,i,1);    
end;

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

to ensure that the code works, capturing image using the Kinect_images


imwrite(rgb,strcat('calibdance',int2str(k),'.jpg'),'jpg');


############################## TO #####################################


imwrite(rgb,strcat('cameracalib',int2str(k),'.jpg'),'jpg');



>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ALSO in the data_calib_rosie 

dir;

Nima_valid = 0;

while (Nima_valid==0), %Fix file format name 

   fprintf(1,'\n');
   calib_name = 'calibdance';
   format_image = 'jpg';
      
   check_directory;
   
end;

############################## TO #####################################

dir;

Nima_valid = 0;

while (Nima_valid==0), %Fix file format name 

   fprintf(1,'\n');
   calib_name = 'cameracalib';
   format_image = 'jpg';
      
   check_directory;