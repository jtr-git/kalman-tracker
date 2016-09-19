function [x_centers, y_centers, acc] = hough_circle(img, r)

% get number of rows and columns

[nrow, ncol] = size(img);

% set up accumulator

acc = zeros(size(img));

% get all "white" points (ypts : row points, xpts : column points)

[ypts, xpts] = find(img);

% for efficiency

r2 = r^2;

% for all points in a column

for i = 1 : numel(xpts)
    
    % set range of x values within the circle
    
    low = xpts(i) - r;
    if low < 1
        low = 1;
    end
    high = xpts(i) + r;
    if high > ncol
        high = ncol;
    end
    
    % loop over the range of x values 
    
    for h = low : high
        % using (x - h)^2 + (y - k)^2 = r^2 and solving for k
        % where (h,k) is center of circle
        y = sqrt(r2 - (xpts(i) - h)^2);
        
        % take both solution +ve and -ve
        % for k = y +/- a (where a = sqrt(r^2 - (x-h)^2))
        
        k1 = round(ypts(i) + y);
        k2 = round(ypts(i) - y);
        
        if k1 >= 1 && k1 < nrow
            acc(k1, h) = acc(k1, h) + 1;
        end
        
        if k2 >= 1 && k2 < nrow
            acc(k2, h) = acc(k2, h) + 1;
        end
        
    end 
end

% find local maxima to separate center of circle
% from other points around it that might have got high votes
acc_bin_max = imregionalmax(acc);

% get possible x-y center points in rows
[potential_ys, potential_xs] = find(acc_bin_max == 1);

% Center Preference Idea => Giving points close to absolute image center preference

% "What we look for is at the center of the picture - usually " @ Prof.
% Kinsman "

% get image center points

ctr_y = floor(size(img, 1)/2);
ctr_x = floor(size(img, 2)/2);

% generate center distance matrix

acc_cpref = zeros(size(acc));

for i = 1 : numel(potential_ys)
    for j = 1 : numel(potential_xs)
        xdist = ctr_y - potential_ys(i);
        ydist = ctr_x - potential_xs(j);
        acc_cpref(potential_ys(i), potential_xs(j)) = (sqrt (xdist^2 + ydist^2));
    end
end

% normalize matrices

acc_cpref = acc_cpref - min(acc_cpref(:));
acc_cpref = acc_cpref ./ max(acc_cpref(:));

% subtract negative matrix to give center points preference

acc_w_cpref = acc - acc_cpref;

% applying threshold

% take only top 5 % votes

acc_sorted = sort(acc_w_cpref);

thresh = acc_sorted( round( 0.95 * length(acc_sorted(:)) ) );

acc_temp = acc_w_cpref - thresh;

% get values above 0

y_centers = [];
x_centers = [];

for i = 1 : numel(potential_ys)
    if acc_temp(potential_ys(i), potential_xs(i)) >= 0
        y_centers = [y_centers; potential_ys(i)];
        x_centers = [x_centers; potential_xs(i)];
    end
end

% Reference - HOUGHCIRCLE by Aman Sarafraz at http://www.computervisiononline.com