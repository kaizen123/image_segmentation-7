clear;
clc;
close all;

dir_name = '..\data\outside\';
im_left = imresize(imread([dir_name '218708.JPG']), 0.25);
im_right = imresize(imread([dir_name '184010.JPG']), 0.25);

threshold = 8;
[valid_left, layer_left] = rgb_segment(im_left, threshold);
[valid_right, layer_right] = rgb_segment(im_right, threshold);

figure(1);
imshow(layer_left/numel(layer_left));
figure(2);
imshow(layer_right/numel(layer_right));