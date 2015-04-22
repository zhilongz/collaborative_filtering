%% Collaborative algorithms
% edited base 

%% =============== Part 1: Loading movie ratings dataset ================
%  You will start by loading the movie ratings dataset to understand the
%  structure of the data.
%  
% fprintf('Loading movie ratings dataset.\n\n');
% 
% %  Load data
% load ('ex8_movies.mat');
load('train_test.mat');
%  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies on 
%  943 users
%
%  R is a 1682x943 matrix, where R(i,j) = 1 if and only if user j gave a
%  rating to movie i

% if R is not provided use the following to compute
% R = zeros(size(Y));
% R(Y ~= 0) = 1;


%  We can "visualize" the ratings matrix by plotting it with imagesc
% imagesc(Y);
% ylabel('Movies');
% xlabel('Users');
% 
% fprintf('\nProgram paused. Press enter to continue.\n');
% pause;


%% ================== Part 2: Learning Movie Ratings ====================
%  Y is divided into Y_train and Y_test at roughly 80 to 20 ratio 

fprintf('\nTraining collaborative filtering...\n');

%  Normalize Ratings: this is important to handle special case of user
%  giving no input
[Ynorm, Ymean] = normalizeRatings(Y_train, R_train);

%  Useful Values
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 1;

% Set Initial Parameters (Theta, X)
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% Set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

% Set Regularization
lambda = 3; %initially 3
theta = fmincg (@(t)(cofiCostFunc(t, Ynorm, R_train, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and W
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');

fprintf('\nProgram paused. Press enter to continue.\n');


%% ================== Part 3: Testing ====================
%  After training the model, now testing the features extracted with the
%  testing set
fprintf('\nBegin testing \n');
Y_hat_norm = X * Theta';%normalized rating 
Y_hat = Y_hat_norm + repmat(Ymean,1,num_users); %rating between 1-5
J = 1/2*sum(sum((Y_hat.*R_test - Y_test.*R_test).^2)); %cost function
avgErr = J/length(find(R_test==1));
fprintf('Total cost %d and error per rating is %d\n', J,avgErr)
% min J so far 1.1947e+04
% feature = 20, avgErr = 0.699
% feature =5, avgErr = 0.6106
% feature =8, avgErr = 0.6346240
% feature =10, avgErr = 0.6459108
% feature = 3, avgErr = 0.5906561
% feature = 1, avgErr = 0.5548493

