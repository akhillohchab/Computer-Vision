function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)

rho_adj = ceil(sqrt(size(img,1)^2+size(img,2)^2));
rho_step = (2*rho_adj+1)/(rho_num_bins-1);
rho = [-rho_adj:rho_step:rho_adj];

% theta_num_bins = 0;
t_step = 1;
theta = [0:t_step:180-t_step];

accum = zeros(length(rho),length(theta));
[y x] = find(img);

for i=1:length(x)
%     old_r = floor(y(i)*cos(0)-x(i)*sin(0));
                 
    for th = 1:length(theta)
            r = floor((x(i) * sind((theta(th) - t_step)) - y(i) * cosd((theta(th)-t_step)) + rho_adj)/rho_step +1);
%            
            accum(r,th) = accum(r,th)+1;
%           old_r = r;
        end
end

% maxval = max(max(accum));
    
hough_img = uint8(accum);
figure, imshow(hough_img);
end











