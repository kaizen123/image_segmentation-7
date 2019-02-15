clear;
clc;
close all;

dir_name = '..\data\outside\';
im_left = imresize(imread([dir_name '218708.JPG']), 0.25);
im_right = imresize(imread([dir_name '184010.JPG']), 0.25);

[label, label_num] = superpixels(im_left, 500);

simple_image = zeros(size(im_left),'like',im_left);
idx = label2idx(label);
num_row = size(im_left,1);
num_col = size(im_left,2);
for i = 1:label_num
    redIdx = idx{i};
    greenIdx = idx{i}+num_row*num_col;
    blueIdx = idx{i}+2*num_row*num_col;
    simple_image(redIdx) = mean(im_left(redIdx));
    simple_image(greenIdx) = mean(im_left(greenIdx));
    simple_image(blueIdx) = mean(im_left(blueIdx));
end

figure(1);
bd = boundarymask(label);
imshow(imoverlay(im_left, bd, 'cyan'), 'InitialMagnification', 67);
figure(2);
imshow(label/500);
figure(3);
imshow(simple_image,'InitialMagnification',67)