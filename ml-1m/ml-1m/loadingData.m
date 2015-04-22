clear all; clc


% This is a tab separated list of user id | item id | rating | timestamp. 

ratings = importdata('ratings.dat');
userID = ratings(:,1);
MovieID = ratings(:,3);
Ratings = ratings(:,5);

num_movie = max(MovieID);
num_user = max(userID);

%sparse(movie,userID,rating,num_movie,num_user);
Y = sparse(MovieID,userID,Ratings,num_movie,num_user);
Y = full(Y); 

R = zeros(size(Y));
R(Y ~= 0) = 1;