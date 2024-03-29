%if exist('images_read');
%   active_images = active_images & images_read;
%end;

var2fix = 'dX_default';

fixvariable;

var2fix = 'dY_default';

fixvariable;

var2fix = 'map';

fixvariable;


if ~exist('n_ima'),
    data_calib_coins;
end;

check_active_images;

if ~exist(['I_' num2str(ind_active(1))]),
    ima_read_calib;
    if isempty(ind_read),
        disp('Cannot extract corners without images');
        return;
    end;
end;


fprintf(1,'\nExtraction of the grid corners on the images\n');


if (exist('map')~=1), map = gray(256); end;


if exist('dX'),
    dX_default = dX;
end;

if exist('dY'),
    dY_default = dY;
end;

if exist('n_sq_x'),
    n_sq_x_default = n_sq_x;
end;

if exist('n_sq_y'),
    n_sq_y_default = n_sq_y;
end;


if ~exist('dX_default')|~exist('dY_default');
    
    % Setup of JY - 3D calibration rig at Intel (new at Intel) - use units in mm to match Zhang
    dX_default = 30;
    dY_default = 30;
    
    % Setup of JY - 3D calibration rig at Google - use units in mm to match Zhang
    dX_default = 100;
    dY_default = 100;
    
end;


if ~exist('n_sq_x_default')|~exist('n_sq_y_default'),
    n_sq_x_default = 10;
    n_sq_y_default = 10;
end;

if ~exist('wintx_default')|~exist('winty_default'),
    wintx_default = max(round(nx/128),round(ny/96));
    winty_default = wintx_default;
    clear wintx winty
end;


if ~exist('wintx') | ~exist('winty'),
    clear_windows; % Clear all the window sizes (to re-initiate)
end;



if ~exist('dont_ask'),
    dont_ask = 0;
end;


% if ~dont_ask,
%     ima_numbers = input('Number(s) of image(s) to process ([] = all images) = ');
% else
%     ima_numbers = [];
% end;
 ima_numbers = [];
if isempty(ima_numbers),
    ima_proc = 1:n_ima;
else
    ima_proc = ima_numbers;
end;


% Useful option to add images:
kk_first = ima_proc(1); %input('Start image number ([]=1=first): ');


% if exist(['wintx_' num2str(kk_first)]),
%     
%     eval(['wintxkk = wintx_' num2str(kk_first) ';']);
%     
%     if isempty(wintxkk) | isnan(wintxkk),
%         
%         disp('Window size for corner finder (wintx and winty):');
%         wintx = input(['wintx ([] = ' num2str(wintx_default) ') = ']);
%         if isempty(wintx), wintx = wintx_default; end;
%         wintx = round(wintx);
%         winty = input(['winty ([] = ' num2str(winty_default) ') = ']);
%         if isempty(winty), winty = winty_default; end;
%         winty = round(winty);
%         
%         fprintf(1,'Window size = %dx%d\n',2*wintx+1,2*winty+1);
%         
%     end;
%     
% else
%     
%     disp('Window size for corner finder (wintx and winty):');
%     wintx = input(['wintx ([] = ' num2str(wintx_default) ') = ']);
%     if isempty(wintx), wintx = wintx_default; end;
%     wintx = round(wintx);
%     winty = input(['winty ([] = ' num2str(winty_default) ') = ']);
%     if isempty(winty), winty = winty_default; end;
%     winty = round(winty);
%     
%     fprintf(1,'Window size = %dx%d\n',2*wintx+1,2*winty+1);
%     
% end;


% if ~dont_ask,
%     fprintf(1,'Do you want to use the automatic square counting mechanism (0=[]=default)\n');
%     manual_squares = input('  or do you always want to enter the number of squares manually (1,other)? ');
%     if isempty(manual_squares),
%         manual_squares = 0;
%     else
%         manual_squares = ~~manual_squares;
%     end;
% else
%     manual_squares = 0;
% end;

if (exist('dX')~=1)|(exist('dY')~=1), % This question is now asked only once
    % Enter the size of each square
    
%     dX = input(['Size dX of each square along the X direction ([]=' num2str(dX_default) 'mm) = ']);
      dX = 30;
%     dY = input(['Size dY of each square along the Y direction ([]=' num2str(dY_default) 'mm) = ']);
      dY = 30;
    if isempty(dX), dX = dX_default; else dX_default = dX; end;
    if isempty(dY), dY = dY_default; else dY_default = dY; end;
else
    fprintf(1,['Size of each square along the X direction: dX=' num2str(dX) 'mm\n']);
    fprintf(1,['Size of each square along the Y direction: dY=' num2str(dY) 'mm   (Note: To reset the size of the squares, clear the variables dX and dY)\n']);
    %fprintf(1,'Note: To reset the size of the squares, clear the variables dX
    %and dY\n');
end


for kk = ima_proc,
    if exist(['I_' num2str(kk)]),
        click_ima_calib;
    else
        eval(['dX_' num2str(kk) ' = NaN;']);
        eval(['dY_' num2str(kk) ' = NaN;']);  
        
        eval(['wintx_' num2str(kk) ' = NaN;']);
        eval(['winty_' num2str(kk) ' = NaN;']);
        
        eval(['x_' num2str(kk) ' = NaN*ones(2,1);']);
        eval(['X_' num2str(kk) ' = NaN*ones(3,1);']);
        
        eval(['n_sq_x_' num2str(kk) ' = NaN;']);
        eval(['n_sq_y_' num2str(kk) ' = NaN;']);
    end;
end;


check_active_images;



% Fix potential non-existing variables:

for kk = 1:n_ima,
    if ~exist(['x_' num2str(kk)]),
        eval(['dX_' num2str(kk) ' = NaN;']);
        eval(['dY_' num2str(kk) ' = NaN;']);  
        
        eval(['x_' num2str(kk) ' = NaN*ones(2,1);']);
        eval(['X_' num2str(kk) ' = NaN*ones(3,1);']);
        
        eval(['n_sq_x_' num2str(kk) ' = NaN;']);
        eval(['n_sq_y_' num2str(kk) ' = NaN;']);
    end;
    
    if ~exist(['wintx_' num2str(kk)]) | ~exist(['winty_' num2str(kk)]),
        
        eval(['wintx_' num2str(kk) ' = NaN;']);
        eval(['winty_' num2str(kk) ' = NaN;']);
        
    end;
    if ~exist('wintx')
        wintx=NaN;
        winty=NaN;
    end
        
end;

string_save = 'save calib_data active_images ind_active wintx winty n_ima type_numbering N_slots first_num image_numbers format_image calib_name Hcal Wcal nx ny map dX_default dY_default dX dY wintx_default winty_default';

for kk = 1:n_ima,
    string_save = [string_save ' X_' num2str(kk) ' x_' num2str(kk) ' n_sq_x_' num2str(kk) ' n_sq_y_' num2str(kk) ' wintx_' num2str(kk) ' winty_' num2str(kk) ' dX_' num2str(kk) ' dY_' num2str(kk)];
end;

eval(string_save);

% Fail Mode
for kk=1:n_ima
    if exist(['extfail_',num2str(kk)],'var')
        if eval(['extfail_',num2str(kk)])==true
            eval(['extfail_',num2str(kk),'=false;']);%reset
            fprintf('\nImage %d Failed and Suppressed\n',kk);
        end
    end
end

% Suspicious Mode
for kk= 1:n_ima
    if exist(['sus_',num2str(kk)],'var')
        if eval(['sus_',num2str(kk)])
            eval(['sus_',num2str(kk),'=0;'])
            I=eval(['I_',num2str(kk)]);
            figure(2);
            image(I); colormap(map); hold on;
            grid_pts_mat=eval(['grid_pts_mat_',num2str(kk)]);
            plot(grid_pts_mat(:,:,2),grid_pts_mat(:,:,1),'+');
            fprintf('\nPlease Check Validity of Corners on Image %d\nSuppress If necessary\n',kk);
            pause;
        end
    end
end

disp('done');

return;

go_calib_optim;

