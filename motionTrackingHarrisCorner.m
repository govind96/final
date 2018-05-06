tic;
clear all;
image1 = '263.jpg';
image2 = '264.jpg';

for i = 1:3
    image1 = gaussianPyramidHarrisCorner('263.jpg', i);
    
    image2 = gaussianPyramidHarrisCorner('264.jpg', i);
    opticalFlowHarrisCorner('263.jpg', '264.jpg', i);
end

    
% img1 = 'frame/172.jpg';
% img2 = 'frame/173.jpg';
% initial = 1;
% for i = 172:180
%     opticalFlowHarrisCorner(img1, img2, 1);
%     img1 = img2;
%     img2 = strcat(num2str(i+1) , '.jpg');
%     img2 = strcat('frame/' , img2);
%     initial = 0;
% end
clear;
close all;