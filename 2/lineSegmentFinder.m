function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)

max_r = size(orig_img,1);
max_c = size(orig_img,2);
rho_adj = ceil(sqrt(max_r^2 + max_c^2));
rho_num_bins = size(hough_img,1);
rho_step = (2*rho_adj+1)/(rho_num_bins-1);
t_step  = 1;

hough_new = hough_img - hough_threshold;

l_img = bwlabel(hough_new,8);
l_img_edge = edge(l_img, 'canny');

maxlabel = max(max(l_img));


hold on;
figure;
imshow(orig_img);
for i = 1:maxlabel

%      we create a mask that would run over the entire image 
    f = [l_img == i];
    g = f.*double(hough_img);
    
%     imshow(g);
    
    


end
hold off;




cropped_line_img = orig_img;
end


