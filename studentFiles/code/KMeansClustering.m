function idx = KMeansClustering(X, k, visualize2D, centers)
% Run the k-means clustering algorithm.
%
% INPUTS
% X - An array of size m x n containing the points to cluster. Each row is
%     an n-dimensional point, so X(i, :) gives the coordinates of the ith
%     point.
% k - The number of clusters to compute.
% visualize2D - OPTIONAL parameter telling whether or not to visualize the
%               progress of the algorithm for 2D data. If not set then 2D
%               data will not be visualized.
% centers - OPTIONAL parameter giving initial centers for the clusters.
%           If provided, centers should be a k x n matrix where
%           centers(c, :) is the center of the cth cluster. If not provided
%           then cluster centers will be initialized by selecting random
%           rows of X. You don't need to use this parameter; it is mainly
%           here to make your code more easily testable.
%
% OUTPUTS
% idx     - The assignments of points to clusters. idx(i) = c means that the
%           point X(i, :) has been assigned to cluster c.

    if ~isa(X, 'double')
        X = double(X);
    end
    m = size(X, 1);
    n = size(X, 2);
    
    % If we are going to display the clusters graphically then create a
    % figure in which to draw the visualization.
    figHandle = [];
    if n == 2 && visualize2D
        figHandle = figure;
    end

    
    % If initial cluster centers were not provided then initialize cluster
    % centers to random rows of X. Each row of the centers variable should
    % contain the center of a cluster, so that centers(c, :) is the center
    % of the cth cluster.
    if ~exist('centers', 'var')
        %centers = zeros(k, n);
        random_indices = randperm(m, k);
        centers = X(random_indices,:);
    end
    
    % The assignments of points to clusters. If idx(i) == c then the point
    % X(i, :) belongs to the cth cluster.
    idx = zeros(m, 1);

    % The number of iterations that we have performed.
    iter = 0;
    
    % If the assignments of points to clusters have not converged after
    % performing MAX_ITER iterations then we will break and just return the
    % current cluster assignments.
    MAX_ITER = 100;
    
    while true        
        % Store old cluster assignments
        old_idx = idx;
        disp(iter);
        % Compute distances from each point to the centers and assign each
        % point to the closest cluster.
        for i = 1:m
            point = X(i,:);
            min_dist = Inf;
            index = -1;
            for j = 1:k
                dist = pdist2(point, centers(j,:));
                if dist < min_dist
                    min_dist = dist;
                    index = j;
                end
            end
            idx(i) = index;
        end
        
        % Break if cluster assignments didn't change
        if idx == old_idx
            break;
        end

        % Update the cluster centers
        for i = 1:k
            centers(i,:) = mean(X(idx==i,:), 1);
        end
        
        
        % Display the points in the 2D case.
        if n == 2 && visualize2D
            VisualizeClusters2D(X, idx, centers, figHandle);
            pause;
        end
        
        % Stop early if we have performed more than MAX_ITER iterations
        iter = iter + 1;
        if iter > MAX_ITER
            break;
        end
    end
    idx;
end
