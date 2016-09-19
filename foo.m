
% Simple hollow ball detection

function [] = foo()

addpath('./test_video');

file = 'simple_ball_roll.mp4';

vidRdr = VideoReader(file);

%skip a few initial frames

skipFrames(10, vidRdr);

% extract a frame

frame = im2double(vidRdr.readFrame('default'));

% get black and white image with thresholding = 0.5

frame_bw = imcomplement(im2bw(frame, 0.5));

% OBJECT DETECTION CODE

% histogram projection

%detect_ball(frame_bw,'histogram-projection', 'showplots', file);

% hough circles

%detect_ball(frame_bw, 'hough-circle', 'showplots', file);


% END OF OBJECT DETECTION CODE
