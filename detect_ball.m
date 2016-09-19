function [out_img]  = detect_ball(img, algo, opt, file)

% object detection algorithms

out_img = img;

nrow = size(img, 1);
ncol = size(img, 2);

if strcmp(algo, 'histogram-projection')
    
    % histogram projection
    
    [vert_proj, horiz_proj] = histogram_projection(img, 'both');
    
    % is object hollow or filled ?
    if strcmp(file, 'simple_ball_roll.mp4')
        [y_center, x_center] = find_center(vert_proj, horiz_proj, 'hollow');
    end
    
    if strcmp(file, 'blue_ball_roll.mp4')
        [y_center, x_center] = find_center(vert_proj, horiz_proj, 'filled');
    end
    
    % plot center on image
    if strcmp(opt, 'showplots')
        
        subplot(1,2,1);
        axis image;
        imshow(img);
        hold on;
        plot(x_center, y_center, 'ro-', 'MarkerSize', 10);
        hold off;
        
        % plot histograms
        subplot(1,2,2);
        % plot values
        plot(1 : ncol, vert_proj);
        hold on;
        % reverse horizontal projection
        plot(fliplr(horiz_proj), 1 : nrow);
        axis image;
        hold off;
    end
end

if strcmp(algo, 'mahal')
    % Mahalanobis distance
    out_img = mahal_image(img, 'nofirst');
    if strcmp(opt, 'showplots')
        figure('Position', [10 10 1024 768]);
        imshow(out_img);
        xlabel('Mahalanobis distance for classification');
    end
end

if strcmp(algo, 'hough-circle')
    % hough circle
    [xcs, ycs, acc] = hough_circle(img, 50);
    
    % plots
    if strcmp(opt, 'showplots')
        subplot(1,2,1);
        axis image;
        imshow(img);
        hold on;
        plot(xcs, ycs, 'r.-', 'MarkerSize', 5);
        xlabel('Located Centers');
        hold off;
        subplot(1,2,2);
        imshow(acc);
        xlabel('Circles Found');
    end
end
