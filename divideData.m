%input R and Y 
%divide R and Y into training set (80%) and testing sets (20%)
% make sure R and Y all have at least one rating

%randomly select

%num_valid = nnz(Y); %returns number of non-zero entries 
% %to do
% % select training data randomly
% [a,b] = find(R==1); %coordinate in a matrix
% Y_new = Y(R==1); 
% sample_index = round(rand(num_valid*0.02,1)*num_valid);
% Y_new(sample_index)=0;
% R_new = R(R==1); 
% R_new(sample_index)=0;
% 
% %reconstruct matrix 
% Y_new_2d = full(sparse(a,b,Y_new));
% R_new_2d = full(sparse(a,b,R_new));
% 
% %check entry
% user_valid = sum(R_new_2d,1);
% movie_valid = sum(R_new_2d,2); 
% 
% user_valid_min = min(user_valid);
% movie_valid_min = min(movie_valid);
% 
% if movie_valid_min == 0 || user_valid_min == 0
%     disp('cannot remove')
% end 
% %impossible 

%% second approach: select sample size proportional to number of movies
clear all; clc 
load('ex8_movies.mat')
[num_movie, num_user] = size(Y);
   Y_train = Y;
   R_train = R;
   Y_test = zeros(size(Y));
   R_test = false(size(R));
   movie_rated = sum(R,2);
    
for i = 1:num_movie
    valid_ind = R(i,:)==1;
    %Y(1,valid_ind);
    
    k = floor(movie_rated(i)*0.25);
    [sample_val,sample_ind]=datasample(Y_train(i,valid_ind),k);
    Y_test(i,sample_ind) = sample_val;
    R_test(i,sample_ind) = true;
    Y_train(i,sample_ind) = 0; 
    R_train(i,sample_ind) = 0;
end 

% test selection criteria
user_valid = sum(Y_train,1);
movie_valid = sum(Y_train,2); 

user_valid_min = min(user_valid);
movie_valid_min = min(movie_valid);

if movie_valid_min == 0 || user_valid_min == 0
    disp('cannot remove')
else
    disp('Original data has been divided into training and testing batches')
end 
