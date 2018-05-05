tic;
clear all;
image1 = '15.jpg';
image2 = '16.jpg';

for i = 1:3
    image1 = gaussianPyramidHarrisCorner('15.jpg', i);
    
    image2 = gaussianPyramidHarrisCorner('16.jpg', i);
    opticalFlowHarrisCorner(image1, image2, i);
end

    