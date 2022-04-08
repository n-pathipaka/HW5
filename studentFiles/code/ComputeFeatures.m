function features = ComputeFeatures(img)
% Compute a feature vector for all pixels of an image. You can use this
% function as a starting point to implement your own custom feature
% vectors.
%
% INPUT
% img - Array of image data of size h x w x 3.
%
% OUTPUT
% features - Array of computed features for all pixels of size h x w x f
%            such that features(i, j, :) is the feature vector (of
%            dimension f) for the pixel img(i, j, :).

    img = double(img);
    height = size(img, 1);
    width = size(img, 2);
    features = zeros([height, width, 1]);

    %%% extra features like edges, gradients( may help cluster together of
    %%% similar texture %%%%

    features(:,:,1:3) = img;

    gray = im2gray(img); %%% converting image to gray scale to get the edges %%%

    % Compute edges using Canny method.
    % This may help bring outliers sticking out of an area of the image
    % into the correct cluster (i.e. hairs sticking out on a cat).

    edge = edge(gray, 'canny'); %% using canny computing edges

    features(:,:,6) = edges;

    col = (1:width);

    row = (1:height)';

    features(:,:,5) = repmat(row, 1, width);

    features(:,:,4) = repmat(col, height, 1);

    % Compute directional gradients using prewitt method.
    % This may help cluster together areas of similar texture, since more
    % textured surfaces in an image will have more changes in direction
    % (i.e. gravel) whereas less textured surfaces will have less changes
    % in direction (i.e. a flat white wall).

    gradients = imgradient(gs, 'prewitt');


    features(:,:,7) = gradients;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                         %
    %                              YOUR CODE HERE                             %
    %                                                                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end