function imgName = gaussianPyramidHarrisCorner(img, reductionFactor)

I = imread(img, 'jpg');
sizeI = size(I);
I = rgb2gray(I);
ReducedI = I;
sizeI = size(I);
sigma = 2;
k = fspecial('gaussian', fix(6*sigma), sigma);
ReductionFactor = reductionFactor;
for t = 1:1:ReductionFactor
    FinalI = ReducedI;
    if t==1 FinalI = filter2(k, ReducedI)/255; else FinalI = filter2(k, ReducedI);end;
    
    sizeI(1) = floor(sizeI(1)/2);
    sizeI(2) = floor(sizeI(2)/2);
    
    ReducedI = zeros(sizeI(1), sizeI(2));
    for i = 1:1:sizeI(1)
        for j = 1:1:sizeI(2)
            ReducedI(i, j) = FinalI(i*2, j*2);
        end
    end
end

imgName = [img '-' int2str(reductionFactor)];
imwrite(ReducedI, imgName, 'jpg');
% subplot(1, 3, 1);
% imshow(imgName);
end
    