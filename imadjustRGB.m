function [img_out] = imadjustRGB(img)

    img_1 = img(:,:,1);
    img_2 = img(:,:,2);
    img_3 = img(:,:,3);
    
    img_1 = imadjust(img_1);
    img_2 = imadjust(img_2);
    img_3 = imadjust(img_3);
    
    img_out = cat(3,img_1, img_2, img_3);    
end