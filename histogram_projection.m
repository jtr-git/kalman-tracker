% opt1 : 'horiz', 'vert', 'both'
% opt2 : 'nosmooth', 'smooth'
function [vert_proj, horiz_proj] = histogram_projection(img, opt1)

nrow = size(img, 1);
ncol = size(img, 2);

%vertical projection

if strcmp(opt1, 'vert') || strcmp(opt1, 'both')
    temp = 0;
    
    vert_proj = zeros(1, ncol);
    
    for col = 1 : ncol
        for row = 1 : nrow
            temp = temp + img(row,col);
        end
        vert_proj(col) = temp;
        temp = 0;
    end
end

% horizontal projection
if strcmp(opt1, 'horiz') || strcmp(opt1, 'both')
    temp = 0;
    horiz_proj = zeros(1, nrow);
    
    for row = 1 : nrow
        for col = 1 : ncol
            temp = temp + img(row,col);
        end
        horiz_proj(row) = temp;
        temp = 0;
    end
end