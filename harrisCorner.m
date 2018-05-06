function [r, c] = harrisCorner(imgName, frame_no)

% disp(imgName);
I = imread(imgName, 'jpg');
I = rgb2gray(I);
% I = imgName;
Gx = [1, 0 , -1;1, 0 , -1;1, 0 , -1];
Gy = Gx';
Ix = conv2(double(I), double(Gx));
Iy = conv2(double(I), double(Gy));

sigma = 2;

gauss = fspecial('gaussian', fix(6*sigma), sigma);

Ix2 = conv2(Ix.^2, gauss);
Iy2 = conv2(Iy.^2, gauss);
Ixy = conv2(Ix.*Iy, gauss);

r1 = (Ix2.*Iy2 - Ixy.^2)./(Ix2 +Iy2 + eps);

size = 3;
max = ordfilt2(r1, size^2, ones(size));
% disp(r1);
thres = 1000;

% r1 determines if a particular point is corner or not.
% it is a corner when its value is maximum in its neighbourhood and also
% greater than thersold.
r1 = (r1==max)&(r1>thres);
[r, c] = find(r1);

subplot(1, 2, 1);
imagesc(I), axis image, colormap(gray), hold on
plot(c, r, 'y.'), title(['frame ', num2str(frame_no), ' corners']);

end