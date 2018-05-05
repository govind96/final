tic;
img1 = 'frame1/1.jpg';
img2 = 'frame1/2.jpg';
initial = 1;
for i = 100:225
    lucas(img1, img2, initial);
    img1 = img2;
    img2 = strcat(num2str(i+1) , '.jpg');
    img2 = strcat('frame1/' , img2);
    initial = 0;
end
%lucas('172.jpg', '173.jpg', 1);
%lucas('174.jpg', '175.jpg', 3);
%lucas('176.jpg', '177.jpg', 5);
toc;

%close all;
%clear all;
