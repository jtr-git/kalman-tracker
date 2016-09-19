function [c] = showColorSpaces(im_rgb)

a = 3;
b = 3;
c = 1;

 im_hsv = rgb2hsv(im_rgb);
 im_lab = rgb2lab(im_rgb);
 
 c = splitShowPlanes(im_rgb, 'rgb', 'red', 'green', 'blue', a, b, c);
 c = splitShowPlanes(im_hsv, 'hsv', 'hue', 'sat', 'val', a, b, c);
 c = splitShowPlanes(im_lab, 'lab', 'Lum', 'adiff', 'bdiff', a, b, c);
