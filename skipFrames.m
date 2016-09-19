function [vidObj] = skipFrames(n, vidObj)

for i = 1 : n
    readFrame(vidObj);
end
