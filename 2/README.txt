README

Computer Vision CS 4731 Hw2

Name: Akhil Lohchab

UNI : al3372
=========================================

walkthrough1
-----------------------------------------

Walkthrough1 was pretty straightforward. The value for threshold 
as well as the 'k' parameter for dilation and erosion was chosen 
after trying out differnt values. 

-----------------------------------------

challenge1a
-----------------------------------------

For challenge1a, one constant threshold was required for all images,
thresholds were tried between 0.3 and 0.9 with a step size of 0.01 to 
finally decide on 0.51 as it seemed to be the best one.

The threshold was then multiplied with the maximum intensity value (255)
to get a comparison value to convert our image frmo grayscale to binary.
For the pixels in the original grayscale image, any values greater than
this comparison value were set to 1, and the others to 0.

bwlabel was used with 8-connection to label the image.
-----------------------------------------

challenge1b
-----------------------------------------

I computed four additional properties apart from the asked 6 - Area, euler
number, max Moment of Inertia and a parameter called ratio, where ratio is
equal to (min Moment of Inertia/ Area^2) which is an invariant moment for 
images (source: wikipedia.)



-----------------------------------------

challenge1c1, challenge1c2
-----------------------------------------
In the function recognizeObjects(), I've used a combination of euler number and the ratio parameter
described above to match objects between two databases. For euler_number,
the 


-----------------------------------------

walkthrough2
-----------------------------------------
Again, the threshold was chosen after trying out different values
and comparing the results.


-----------------------------------------

challenge2a
-----------------------------------------

Just added a canny filter with a threshold of 0.1.



-----------------------------------------

challenge2b
-----------------------------------------

theta_num_bins were set to be 180, 1 for each degree from 1 to 180.
rho_num_bins was set equal to the diagonal of the image. This is also
later used as the offset 'rho_adj' to bring the value of 'rho' from [-diag:diag]
to [0:diag].

rho_step was calculated and based on that the bins for rho were acquired.

Since the input image to the generateHoughAccumulator is a binary edge image,
the points that are equal to 1, their indices are obtained and stored in [y x]

for each such point, for all theta, the value of r is calculated and the value of 
the appropriate bin in the hough space is incremented.


The hough space, after conversion to uint8, has been displayed as an image.


-------------------------------------------

challenge2c
-------------------------------------------

The thresholds for the three images were set after repeated experiments which 
involved tweaking all these values.