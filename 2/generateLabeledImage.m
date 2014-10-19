function labeled_img = generateLabeledImage(gray_img, threshold)

% To convert the image from gray to binary, we simply multiply the
% threshold value with the maximum intensity value of I for gray images
% (255) and compare with the intensity  value at a pixel with it, if the
% pixel value is higher, we assign it 1 else we assign it 0.

max_value = 255;
compare_value = 255 * threshold;

%  we do comparison at every value in gray_img, if it is greater than the
%  compare value, we assign the corresponding cell in the binary image the
%  value of 1, if it is smaller, we assign it 0.
binary_img = [gray_img > compare_value];

% figure, imshow(binary_img);       //This is just to check if it's working
%                                     properly


labeled_img = bwlabel(binary_img,8);
end
% compute2DProperties(gray_img,labeled_img);

