%%% This script alets the user enter the name of the images (base name, numbering scheme,...

      
% Checks that there are some images in the directory:

l_ras = dir('*ras');
s_ras = size(l_ras,1);
l_bmp = dir('*bmp');
s_bmp = size(l_bmp,1);
l_tif = dir('*tif');
s_tif = size(l_tif,1);
l_pgm = dir('*pgm');
s_pgm = size(l_pgm,1);
l_ppm = dir('*ppm');
s_ppm = size(l_ppm,1);
l_jpg = dir('*jpg');
s_jpg = size(l_jpg,1);
l_jpeg = dir('*jpeg');
s_jpeg = size(l_jpeg,1);
l_png = dir('*png');
s_png = size(l_png,1);

s_tot = s_ras + s_bmp + s_tif + s_pgm + s_jpg + s_ppm + s_jpeg + s_png;

if s_tot < 1,
   fprintf(1,'No image in this directory in either ras, bmp, tif, pgm, ppm, png or jpg format. Change directory and try again.\n');
   break;
end;


% IF yes, display the directory content:

dir;

Nima_valid = 0;

while (Nima_valid==0), %Fix file format name 

   fprintf(1,'\n');
   calib_name = 'calibdance';
   format_image = 'jpg';
      
   check_directory;
   
end;



%string_save = 'save calib_data n_ima type_numbering N_slots image_numbers format_image calib_name first_num';

%eval(string_save);



if (Nima_valid~=0),
    % Reading images:
    
    ima_read_calib; % may be launched from the toolbox itself
    % Show all the calibration images:
    
    if ~isempty(ind_read),
        
        mosaic;
        
    end;
    
end;

