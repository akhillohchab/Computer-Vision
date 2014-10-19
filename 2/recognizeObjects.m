function output_img = recognizeObjects(orig_img, labeled_img, obj_db)

total_objects = max(max(labeled_img));

[obj_db2, out_img2] = compute2DProperties(orig_img, labeled_img);
% obj_db2

permitted_error = 0.12;
index = [];
output = zeros(size(labeled_img));

for i=1:total_objects
    for j=1:size(obj_db,2)

%         
        if(obj_db2(8,i)==obj_db(8,j)) 
            
 if (abs(obj_db2(10,i)-obj_db(10,j))<0.12*obj_db2(10,i));
%
%                 
%                 [i j]
                output = [output; labeled_img==i];
            
            end
        
        end
    end
end

output_img = output;
    
end
