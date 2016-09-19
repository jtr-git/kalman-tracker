function [class_im]  = mahal_image(img, run)

% for the first run, gather points data
if strcmp(run, 'first')
    figure('Position', [10 10 1024 768]);
imshow(img);

fprintf('Select Ball Points ... ');
fprintf('Click on points to capture positions:  Hit return to end...\n');
[x_ball, y_ball] = ginput();
      
fprintf('Select Background Points ... ');
fprintf('Click on points to capture positions:  Hit return to end...\n');
[x_bg, y_bg] = ginput();

save feature_pts_mahal;

end

if ~strcmp(run, 'first')
    load feature_pts_mahal;
end

% get classified image
class_im = getMahalDist(img, x_ball, y_ball, x_bg, y_bg);
