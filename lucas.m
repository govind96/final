function dm = lucas(img1, img2, initial)

im1 = imread(img1);
im2 = imread(img2);

im1 = im2double(rgb2gray(im1));

im2 = im2double(rgb2gray(im2));

ww = 40;
w = round(ww/2);

sc = 3;
% im2c = imresize(im2, 1/sc);
subplot(1, 3, 1);
imshow(img2);
im2c = gaussianPyramidHarrisCorner(img2, 2);
% C1 = corner(im2c);
% subplot(1, 3, 2);
% 
% imshow(im2c);
% subplot(1, 3, 1);
im2c = imread(im2c);
im2c = im2double(im2c);

corners = detectHarrisFeatures(im2c);
C1 = corners.Location;
% 
% C1 = [r2, c2];
C1 = C1*sc;
disp(C1);
% imshow(C1);
k = 1;
for i = 1:size(C1,1)
    disp(i);
    x_i = C1(i, 2);
    y_i = C1(i, 1);
    if x_i-w>=1 && y_i-w>=1 && x_i+w<=size(im1,1)-1 && y_i+w<=size(im1,2)-1
      C(k,:) = C1(i,:);
      k = k+1;
    end
end

subplot(1,3,2);
% 
imshow(img2);
hold on
plot(C(:,1), C(:,2),'c.');

Ix_m = conv2(im1,[-1 1; -1 1], 'valid'); 
Iy_m = conv2(im1, [-1 -1; 1 1], 'valid'); 
It_m = conv2(im1, ones(2), 'valid') + conv2(im2, -ones(2), 'valid'); 
u = zeros(length(C),1);
v = zeros(length(C),1);

for k = 1:length(C(:,2))
    i = C(k,2);
    j = C(k,1);
      Ix = Ix_m(i-w:i+w, j-w:j+w);
      Iy = Iy_m(i-w:i+w, j-w:j+w);
      It = It_m(i-w:i+w, j-w:j+w);

      Ix = Ix(:);
      Iy = Iy(:);
      b = -It(:); 

      A = [Ix Iy]; 
      nu = pinv(A)*b;

      u(k)=nu(1);
      v(k)=nu(2);
end


subplot(1, 3, 3);% 
size(C(:,1));
size(C(:,2));


% min(C(x/2:x-1,:,1))
% min(C(y/2:y-1,:,2))
% max(C(x/2:x-1,:,1))
% max(C(y/2:y-1,:,2))
% rectangle('position',[min(C(:,1)),min(C(:,2)),max(C(:,2)), max(C(:,1))]);

imshow(img2);
hold on;
quiver(C(:,1), C(:,2), u,v, 0.8,'c');
% if initial==1
%     rect = getrect;
%     
% disp(rect);
% disp(min(C(:,1)));
% disp(max(C(:,1)));
% disp(min(C(:,2)));
% disp(max(C(:,2)));
% 
drawnow;
end
