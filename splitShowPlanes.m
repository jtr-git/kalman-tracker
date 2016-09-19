function [c] = splitShowPlanes(img, csp, p1Str, p2Str, p3Str, a, b, c)

p1 = img(:,:,1);
p2 = img(:,:,2);
p3 = img(:,:,3);

subplot(a,b,c);
imshow(p1);
xlabel(strcat(csp, '-' , p1Str));

subplot(a,b,c+1);
imshow(p2);
xlabel(strcat(csp , '-' , p2Str));

subplot(a,b,c+2);
imshow(p3);
xlabel(strcat(csp , '-' , p3Str));

c = c + 3;