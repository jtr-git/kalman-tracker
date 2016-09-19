function [centers, radii] = region_props(img, opt, opt2)

nrow = size(img, 1);
ncol = size(img, 2);

% regionprops
stats = regionprops('table',img,'Centroid', ...
    'MajorAxisLength','MinorAxisLength');

% Get centers and radii of the circles
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;

if ~strcmp(opt2, 'getall')
    % find the center closest to the image center - @Prof Kinsman's Idea
    mindist = max([nrow ncol]);
    mindistIdx = 0;
    
    im_xc = ncol/2;
    im_yc = nrow/2;
    
    for i = 1 : size(centers, 1)
        cartdist = sqrt((centers(i, 1) - im_xc)^2 + (centers(i, 2) - im_yc)^2);
        if mindist > cartdist
            mindist = cartdist;
            mindistIdx = i;
        end
    end
    % replace with just one circle's values
    centers = [centers(mindistIdx, 1) , centers(mindistIdx, 2)];
    radii = radii(mindistIdx);
    
end

if strcmp(opt, 'showplots')
    % Plot the circles
    figure;
    imshow(img);
    hold on
    viscircles(centers,radii);
    axis image;
    hold off
end