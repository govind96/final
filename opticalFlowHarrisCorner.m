function opticalFlowHarrisCorner(img1, img2, dim)

image1 = imread(img1, 'jpg');
image2 = imread(img2,'jpg' );
image1 = rgb2gray(image1);
image2 = rgb2gray(image2);

% image1 = im2double(image1);
% image2 = im2double(image2);
% subplot(2, 3, 1);
% imshow(image1);
% subplot(2, 3, 2);
% imshow(image2);
[height, width] = size(image1);
image1_smoothen = zeros(height, width);
image2_smoothen = zeros(height, width);
dx1 = zeros(height, width); 
dx2 = zeros(height, width);
dy1 = zeros(height, width);
dy2 = zeros(height, width);

sigma = 1;
kernelSize = 6*sigma + 1;
k = 3;
kernelX = zeros(kernelSize, kernelSize); 
kernelY = zeros(kernelSize, kernelSize);
kernel = zeros(kernelSize, kernelSize);

for i = 1:kernelSize
    for j = 1:kernelSize
        kernelX(i, j) = -((j-k-1)/(2*pi*sigma^3)) * exp(-((i-k-1)^2 + (j-k-1)^2) / (2*sigma^2));
    end
end

for i = 1:kernelSize
    for j = 1:kernelSize
        kernelY(i, j) = -((j-k-1)/(2*pi*sigma^3)) * exp(-((i-k-1)^2 + (j-k-1)^2) / (2*sigma^2));
    end
end

dx1 = filter2(kernelX, image1);
dy1 = filter2(kernelY, image1);
dx2 = filter2(kernelX, image2);
dy2 = filter2(kernelY, image2);

Ix = (dx1+dx2)/2;
Iy = (dy1+dy2)/2;

for i = 1:kernelSize
    for j = 1:kernelSize
        kernel(i, j) = (1/(2*pi*(sigma^2))) * exp(-((i-k-1)^2 + (j-k-1)^2) / (2*sigma^2));
    end
end

image1Smooth = filter2(kernel, image1);
image2Smooth = filter2(kernel, image2);
It = image1Smooth - image2Smooth;
% subplot(2, 3, dim);
% imshow(It);
neighbourhoodN = 5;
mat1 = zeros(2, 2);
mat2 = zeros(2, 1);

final1 = zeros(height, width);
final2 = zeros(height, width);

%[r1, c1] = harrisCorner(img1, dim);
%r1 = zeros(200);
%c1 = zeros(200);
sc = 2;
im1c = imresize(image1, 1/sc);
[r1, c1] = harrisCorner(im1c, dim);
% subplot(2, 3, dim);
% imagesc(image1), axis image, colormap(gray), hold on
% plot(c1, r1, 'ys'), title('corner');
% disp(r1);
% disp(c1);
% corners = detectHarrisFeatures(image1);
% C1 = corners.Location;
% r1 = int64(C1(:,1));
% c1 = int64(C1(:,2));
% subplot(2, 3, dim);
% imagesc(image1), axis image, colormap(gray), hold on
% plot(c1, r1, 'ys'), title('corner');
% disp(C1);

% r1= x(1);
% c1 = x(2);
%for i = 1:200
%    r1(i) = i;
%   c1(i) = i;
%end
length1 = length(r1);

for i = 1:length1
    mat1 = zeros(2,2);
    mat2 = zeros(2, 1);
    indexrow = r1(i);
    indexcol = c1(i);
    
    for m = indexrow-floor(neighbourhoodN/2):indexrow+floor(neighbourhoodN/2)
        for n = indexcol-floor(neighbourhoodN/2):indexcol+floor(neighbourhoodN/2)
            if ((m >= (1+floor(neighbourhoodN/2))) && (m<= (height - floor(neighbourhoodN/2))) ...
                    && (n >= (1 + floor(neighbourhoodN/2)) ) && (n<=(width - floor(neighbourhoodN/2)) ))
            
             mat1(1, 1) = mat1(1, 1) + Ix(m, n)*Ix(m,n);
             mat1(1, 2) = mat1(1, 2) + Ix(m, n)*Iy(m,n);
             mat1(2, 1) = mat1(2, 1) + Ix(m, n)*Iy(m,n);
             mat1(2, 2) = mat1(2, 2) + Iy(m, n)*Iy(m,n);
             mat2(1, 1) = mat2(1, 1) + Ix(m, n)*It(m,n);
             mat2(2, 1) = mat2(2, 1) + Iy(m, n)*It(m,n);
            end
        end
    end
    
    Ainv = pinv(mat1);
%     disp(Ainv);
    result = Ainv*(-mat2);
%     disp(result);
    final1(indexrow, indexcol) = result(1, 1);
    final2(indexrow, indexcol) = result(2, 1);
    
end
final1 = flipud(final1);
final2 = flipud(final2);
subplot(1, 2, 2);
imagesc(image1), axis image, colormap(gray), hold on
quiver (final1, final2, 15), title('op. flow');
% disp(final1);
drawnow;
    
end