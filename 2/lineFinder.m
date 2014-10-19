function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)

rho_num_bins = size(hough_img,1);

max_r = size(orig_img,1);
max_c = size(orig_img,2);
rho_adj = ceil(sqrt(max_r^2 + max_c^2));
rho_step = (2*rho_adj+1)/(rho_num_bins-1);
li = figure();
imshow(orig_img);

hough_new = (hough_img >= hough_threshold);
[final_r,final_t] = find(hough_new);

x=[1:max_c];

for i=1:length(final_r)
%     bringing rho back into (x,y) space.
    rho = (final_r(i,1))*rho_step - rho_adj; 
    
    y = floor((x.*tand(final_t(i,1)-1)) - rho/cosd(final_t(i,1)-1));
    hold on
    plot(x,y-3,'MarkerFaceColor', [1 0 0], 'color','b');
    
end
F = getframe(li);
line_detected_img = F.cdata;

%plotWithAnnotation2(orig_img,loopxy,rmax/10);
end
