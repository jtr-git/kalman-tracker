% find the center of a circle using histogram projections
% works differently for hollow and filled circular regions
function [yc, xc] = find_center(vert_proj, horiz_proj, circleType)
% find hollow circle center

[peaks_horiz, locs_horiz] = findpeaks(vert_proj);
[peaks_vert, locs_vert] = findpeaks(horiz_proj);

pvs = sort(peaks_horiz);
phs = sort(peaks_vert);

% apply a threshold (not needed as we uniquely choose a circle point)

% thresh = 0.98;
% pvs_thresh = pvs(thresh*length(pvs) : end);
% phs_thresh = phs(thresh*length(phs) : end);


% find center using top two peaks

peak_vert_1_idx = 0;
peak_vert_2_idx = 0;

peak_horiz_1_idx = 0;
peak_horiz_2_idx = 0;

% x-direction

for i = 1 : length(peaks_horiz)
    if(pvs(end) == peaks_horiz(i))
        peak_horiz_1_idx = i;
    end
    if(pvs(end - 1) == peaks_horiz(i))
        peak_horiz_2_idx = i;
    end
end

% y-direction

for i = 1 : length(peaks_vert)
    if(phs(end) == peaks_vert(i))
        peak_vert_1_idx = i;
    end
    if(phs(end - 1) == peaks_vert(i))
        peak_vert_2_idx = i;
    end
end

% center lies at the mid point of two peaks for a circle(hollow)
if strcmp(circleType, 'filled')
    yc = locs_vert(peak_vert_1_idx);
    xc = locs_horiz(peak_horiz_1_idx);
end

if strcmp(circleType, 'hollow')
    yc = round((locs_vert(peak_vert_1_idx) + locs_vert(peak_vert_2_idx)) / 2);
    xc = round((locs_horiz(peak_horiz_1_idx) + locs_horiz(peak_horiz_2_idx)) / 2);
end
