function [db, out_img] = compute2DProperties(orig_img, labeled_img)
% orig_img = imread('two_objects.png');
% labeled_img = logical(labeled_img);
% To find out how many objects there are in the image, we find the highest
% label in the image
maxlabel = max(max(labeled_img));


% Computing Area
% To compute area of an object, we use a function bwarea which gives the
% area of the foreground in an image. 
% 
% So, for every labeled object, we create a temporary image with only that
% object and use the function to get the area.
% 
% Initializing properties
Area = ones(1,maxlabel);
orientation = zeros(1,maxlabel);
center_coord = zeros(maxlabel,2);
MOI_min = zeros(maxlabel,1);
MOI_max = zeros(maxlabel,1);
eulern = zeros(maxlabel,1);
ratio = zeros(maxlabel,1); 

for i = 1:maxlabel
%     creating a temporary image with just the ith object
    temp_img = [labeled_img ==i];

%   bweuler() and bwarea()give us the euler number and area of the object,
%   respectively.
    p = bweuler(temp_img,8);
    eulern(i) = p;
    Area(i) = bwarea(temp_img);
    
    a = 0 ; b = 0; c = 0;
   for j = 1:size(temp_img,1)
        for k = 1:size(temp_img, 2)
            center_coord(i,1) = center_coord(i,1)+(k*temp_img(j,k));
            center_coord(i,2) = center_coord(i,2)+(j*temp_img(j,k));
        end
    end
    center_coord(i,1) = round((1/Area(i))*center_coord(i,1));
    center_coord(i,2) = round((1/Area(i))*center_coord(i,2));
    
    for j= 1:size(temp_img,1)
        for k=1:size(temp_img,2)
            xp = j - center_coord(i,2);
            yp = -k + center_coord(i,1);
            
            a = a + (xp^2)*(temp_img(j,k));
            b = b + 2*(xp*yp)*(temp_img(j,k));
            c = c + (yp^2)*(temp_img(j,k));
            
%             we define this parameter to be an identifier for the object.
            ratio(i) = Area(i)/(a+c);
        end
    end
    
%     Initializing the two values of thetas, one represents the minimum
%     Moment of inertia for the object, one the maximum Moment of Inertia.
    angle1 = atan2(b,a-c);
    angle2 = angle1 + pi;
    
    if ((a-c)*cos(angle1) + b*(sin(angle1))>0)
        orientation(i) = angle2;
      
    
    else    
        orientation(i) = angle1;
%         
        
    end
    
%     Orientation(i) should have the value of \theta and not 2*\theta. So
%     we divide the value by 2.
    orientation(i) = orientation(i)/2;
    
    MOI_max(i,1) = a*(sin(orientation(i)-pi/2)^2)-b*(sin(orientation(i)-pi/2)*cos(orientation(i)-pi/2))+c*((cos(orientation(i)-pi/2))^2);
    MOI_min(i,1) = a*(sin(orientation(i))^2)-b*(sin(orientation(i)+pi/2)*cos(orientation(i)+pi/2))+c*((cos(orientation(i)+pi/2))^2);

    if MOI_max(i,1)<MOI_min(i,1)
       
        Roundedness(i) = MOI_max(i,1)/MOI_min(i,1);
        temp = MOI_max(i,1);
        MOI_max(i,1) = MOI_min(i,1);
        MOI_min(i,1) = temp;
    else
        Roundedness(i) = MOI_min(i,1)/MOI_max(i,1);
   
    end
    
end
label = [1:maxlabel];


% creating the database
db = vertcat(double(label),(center_coord(:,2))',(center_coord(:,1))',(MOI_min(:,1))',orientation,Roundedness,Area,eulern',(MOI_max(:,1))',ratio')

fig = figure();
imshow(orig_img);
hold on;

% Plotting the Centroid

plot(db(3,:),db(2,:), 'r*', 'MarkerFaceColor', [1 1 1]);
% rangeX = [center_coord(1,1):center_coord(1,1)+200]';

for i = 1:maxlabel
    
rangeX = [-99:100]';
m=[tan(orientation(i))];
mat(:,1) = rangeX;
mat(:,2) = m*(mat(:,1)) + center_coord(i,2);

%  Plotting the axis of orientation
plot(mat(:,1)+center_coord(i,1),mat(:,2), 'c--');
end;
hold off;

out_img = saveAnnotatedImg(fig);
% figure;imshow(out_img);
%%
function annotated_img = saveAnnotatedImg(fig)
figure(fig); % Shift the focus back to the figure fh

% The figure needs to be undocked
set(fig, 'WindowStyle', 'normal');

% The following two lines just to make the figure true size to the
% displayed image. The reason will become clear later.
img = getimage(fig);
truesize(fig, [size(img, 1), size(img, 2)]);

% getframe does a screen capture of the figure window, as a result, the
% displayed figure has to be in true size. 
frame = getframe(fig);
frame = getframe(fig);
pause(0.5); 
% Because getframe tries to perform a screen capture. it somehow 
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround. 
annotated_img = frame.cdata;
