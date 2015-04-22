
data = importdata('u.data');

% This is a tab separated list of user id | item id | rating | timestamp. 

userID = data(:,1);
movie = data(:,2);
rating = data(:,3);
num_movie = max(movie);
num_user = max(userID);

sparse(movie,userID,rating,num_movie,num_user);
Y = sparse(movie,userID,rating,num_movie,num_user);
Y = full(Y); 

R = zeros(size(Y));
R(Y ~= 0) = 1;