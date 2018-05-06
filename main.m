tic;
img1 = 'frame2/1.jpg';
img2 = 'frame2/2.jpg';
initial = 1;
for i = 1:40
    opticalFlow(img1, img2, i);
    img1 = img2;
    img2 = strcat(num2str(i+1) , '.jpg');
    img2 = strcat('frame2/' , img2);
    initial = 0;
end
%lucas('172.jpg', '173.jpg', 1);
%lucas('174.jpg', '175.jpg', 3);
%lucas('176.jpg', '177.jpg', 5);
timespent = toc;
disp(timespent);
%close all;
%clear all;
