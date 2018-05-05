function dm = lucas0(img1, img2, d)
img1 = imread(img1);
img2 = imread(img2);


img1 = im2double(rgb2gray(img1));
[m, n] = size(img1);

img1 = imresize(img1, 0.5); % downsize to half


img2 = im2double(rgb2gray(img2));
img2 = imresize(img2, 0.5); % downsize to half

ww = 45;
w = round(ww/2);

% Lucas Kanade Here
% for each point, calculate I_x, I_y, I_t
Ix_m = conv2(img1,[-1 1; -1 1], 'valid'); % partial on x
Iy_m = conv2(img1, [-1 -1; 1 1], 'valid'); % partial on y
It_m = conv2(img1, ones(2), 'valid') + conv2(img2, -ones(2), 'valid'); % partial on t
u = zeros(size(img1));
v = zeros(size(img2));

% within window ww * ww
for i = w+1:size(Ix_m,1)-w
   for j = w+1:size(Ix_m,2)-w
      Ix = Ix_m(i-w:i+w, j-w:j+w);
      Iy = Iy_m(i-w:i+w, j-w:j+w);
      It = It_m(i-w:i+w, j-w:j+w);

      Ix = Ix(:);
      Iy = Iy(:);
      b = -It(:); % get b here

      A = [Ix Iy]; % get A here
      nu = pinv(A)*b; % get velocity here

      u(i,j)=nu(1);
      v(i,j)=nu(2);
   end;
end;

% downsize u and v
u_deci = u(1:10:end, 1:10:end);
v_deci = v(1:10:end, 1:10:end);
% get coordinate for u and v in the original frame
[X,Y] = meshgrid(1:n, 1:m);
X_deci = X(1:20:end, 1:20:end);
Y_deci = Y(1:20:end, 1:20:end);

subplot(2, 1, d);
imshow(img2);
hold on;
quiver(X_deci, Y_deci, u_deci,v_deci, 'y')
end