function rating=find_rating(user_a,item,dataset,similarity,N);
% predicts the rating given by user_a on item
% 
% 
% Akarshan, Oct 2013

temp=dataset(2,:);
users_who_rated_item = find(temp==item); % find indices of all the users who have rated the item
dataset_uwri = dataset(:,users_who_rated_item);

neighbors = similarity(user_a,dataset_uwri(1,:));
neighbors = [neighbors;dataset_uwri(1,:);dataset_uwri(3,:)]; % to keep track of the users associated

%%%%
% first row of neighbor matrix is similarity value
% second row is users
% third row is rating
%%%

temp1=neighbors(1,:);
[B,ix] = sort(temp1,'descend');
%% edited by Shikhar for testing
if(size(ix,2)<N)
    N=size(ix,2);
end
%%
top_N_neighbor_indices = ix(1:N);

neighbors_topN = neighbors(:,top_N_neighbor_indices);
sum=0;
sum_similarity = 0;
for i=1:N
  user_u = neighbors_topN(2,i); % which user is being considered
  sum = sum + ( (neighbors_topN(3,i) - average_rating(user_u,dataset) ) * similarity(user_a,user_u)) ;
  sum_similarity = sum_similarity + similarity(user_a,user_u) ;
end
sum = sum / sum_similarity;
rating = sum + average_rating(user_a,dataset);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% average rating given by user_i
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function avg_rate=average_rating(user_i,dataset)
temp2 = dataset(1,:);
temp3 = find(temp2==user_i);
dataset_i = dataset(:,temp3);
ratings_i = dataset_i(3,:);
avg_rate = mean(ratings_i);
