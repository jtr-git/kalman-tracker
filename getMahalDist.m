function [class_im] = getMahalDist(img, x_ball, y_ball, x_bg, y_bg)

fg_indices = sub2ind(size(img), round(y_ball), round(x_ball));
bg_indices = sub2ind(size(img), round(y_bg), round(x_bg));

im_rgb = img;

im_r = im_rgb(:, :, 1);
im_g = im_rgb(:, :, 2);
im_bl = im_rgb(:, :, 3);

im_lab = rgb2lab(im_rgb);

im_L = im_lab(:, :, 1);
im_a = im_lab(:, :, 2);
im_b = im_lab(:, :, 3);

im_hsv = rgb2hsv(im_rgb);

im_h = im_hsv(:, :, 1);
im_s = im_hsv(:, :, 2);
im_v = im_hsv(:, :, 3);

fg_r = im_r(fg_indices);
fg_g = im_g(fg_indices);
fg_bl = im_bl(fg_indices);

fg_h = im_h(fg_indices);
fg_s = im_h(fg_indices);
fg_v = im_h(fg_indices);

fg_L = im_L(fg_indices);
fg_a = im_a(fg_indices);
fg_b = im_b(fg_indices);


bg_r = im_r(bg_indices);
bg_g = im_g(bg_indices);
bg_bl = im_b(bg_indices);

bg_h = im_h(bg_indices);
bg_s = im_h(bg_indices);
bg_v = im_h(bg_indices);

bg_L = im_L(bg_indices);
bg_a = im_a(bg_indices);
bg_b = im_b(bg_indices);

%fg_all = [fg_r fg_g fg_bl fg_h fg_s fg_v fg_L fg_a fg_b];
%bg_all = [bg_r bg_g bg_bl bg_h bg_s bg_v bg_L bg_a bg_b];

fg_all = [fg_s fg_b];
bg_all = [bg_s bg_b];

%im_all = [im_r(:), im_g(:), im_bl(:), im_h(:), im_s(:), im_v(:), im_L(:), im_a(:), im_b(:)];

im_all = [im_s(:), im_b(:)];

mahal_fg = mahal(im_all, fg_all).^(1/2);
mahal_bg = mahal(im_all, bg_all).^(1/2);

class_fg = mahal_fg < mahal_bg;

class_im = reshape(class_fg, size(im_a, 1), size(im_b, 2));
