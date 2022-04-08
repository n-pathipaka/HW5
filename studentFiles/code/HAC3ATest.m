function HAC3ATest(visualize)
% Tests your implementation of HAClustering.m by comparing its output on a
% test dataset with the output of our reference implementation on the same
% dataset.
%
% INPUT
% visualize - Whether or not to visualize each step of the clustering
%             algorithm. Optional; default is true.

    if nargin < 1
        visualize = true;
    end
   

    load('test_data/HAClusteringTest.mat');
    X_1 = X(randperm(20),:);
    my_idx = HAC3A(X_1, k, visualize); 
    
    
end