clear;
clc;
close all;

dir_name = '..\data\outside\';
im1 = imread([dir_name '184010.JPG']);
im2 = imread([dir_name '218708.JPG']);
im1 = imresize(im1, 0.25);
im2 = imresize(im2, 0.25);
 
lab_im1 = rgb2lab(im1);
lab_im2 = rgb2lab(im2);

ab1 = lab_im1(:,:,2:3);
nrows1 = size(ab1,1);
ncols1 = size(ab1,2);
ab1 = reshape(ab1,nrows1*ncols1,2);

ab2 = lab_im2(:,:,2:3);
nrows2 = size(ab2,1);
ncols2 = size(ab2,2);
ab2 = reshape(ab2,nrows2*ncols2,2);

nColors = 5;
% repeat the clustering 3 times to avoid local minima
[cluster1_idx, cluster1_center] = kmeans(ab1,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
[cluster2_idx, cluster2_center] = kmeans(ab2,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);

figure(1);
subplot(1, 2, 1);
pixel_labels1 = reshape(cluster1_idx,nrows1,ncols1);
imshow(pixel_labels1,[]), title('image labeled by cluster index');
subplot(1, 2, 2);
pixel_labels2 = reshape(cluster2_idx,nrows2,ncols2);
imshow(pixel_labels2,[]), title('image labeled by cluster index');

segmented_images1 = cell(1,3);
rgb_label1 = repmat(pixel_labels1,[1 1 3]);

segmented_images2 = cell(1,3);
rgb_label2 = repmat(pixel_labels2,[1 1 3]);

for k = 1:nColors
    color1 = im1;
    color1(rgb_label1 ~= k) = 0;
    segmented_images1{k} = color1;
    
    color2 = im2;
    color2(rgb_label2 ~= k) = 0;
    segmented_images2{k} = color2;
end

for k = 1:nColors
    figure;
    imshow(segmented_images1{k});
end

for k = 1:nColors
    figure;
    imshow(segmented_images2{k});
end