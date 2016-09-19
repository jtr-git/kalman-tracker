
% Detecting a blue ball flowing in water

function [] = bar ()
addpath('./test_video');

file = 'blue_ball_roll.mp4';

vidRdr = VideoReader(file);

skipFrames(10, vidRdr);

frame = im2double(vidRdr.readFrame('default'));

frame_bw = im2bw(frame, 0.5);

% object detection

% histogram projection

%detect_ball(frame_bw,'histogram-projection', 'showplots', file);

% mahalanobis classification

%class_img_bw = detect_ball(frame, 'mahal', 'noshowplots', file);

% histogram over mahal image (needs previous line)

%detect_ball(class_img_bw,'histogram-projection', 'showplots', file);

%center detection (below code needs line 25)

[center, radius] = region_props(class_img_bw, 'noshowplots', 'nogetall');
figure;
imshow(frame);
xlabel('Finding circles after mahalanobis');
hold on
viscircles(center, radius);
axis image;
hold off;