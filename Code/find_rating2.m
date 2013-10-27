function rating=find_rating2(user_a,item,dataset,N);
% predicts the rating given by user_a on item
% N is number of most similar users to be considered in giving prediction
% 
% Akarshan, Oct 2013

temp=dataset(2,:);

similarity = zeros(943); % this array is similarity between user_a to every other user
for i = 1:943
  if(mod(i,50)==0)
   fprintf( 'i=%d\n',i);
  end
  similarity(i) = Compute_similarity(user_a,i,dataset);
end

users_who_rated_item = find(temp==item); % find indices of all the users who have rated the item
dataset_uwri = dataset(:,users_who_rated_item);

neighbors = similarity(dataset_uwri(1,:));
neighbors = [neighbors;dataset_uwri(1,:);dataset_uwri(3,:)]; % to keep track of the users and items associated

%%%%
% first row of neighbor matrix is similarity value
% second row is users
% third row is rating
%%%

temp1=neighbors(1,:);
[B,ix] = sort(temp1,'descend');
top_N_neighbor_indices = ix(1:N);

neighbors_topN = neighbors(:,top_N_neighbor_indices);
sum=0;
sum_similarity = 0;
for i=1:N
  user_u = neighbors_topN(2,i); % which user is being considered
  sum = sum + ( (neighbors_topN(3,i) - average_rating(user_u,dataset) ) * similarity(user_u)) ;
  sum_similarity = sum_similarity + similarity(user_u) ;
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


%%%%%%%%%%%%%%%%%%%
%%%
%%% return pearson correlation between user a and u
%%%
%%%%%%%%%%%%%%%%%%%
function final=Compute_similarity(a,u,dataset)

userinfo=dataset(1,:);
[m,n]=sort(userinfo);
dataset_user_sorted = dataset(:,n);

temp=find(userinfo==a); % find those index where user a is sitting
dataset_a = dataset(:,temp);

temp=find(userinfo==u);
dataset_u = dataset(:,temp);

dataset_a_items = dataset_a(2,:); % retain only the movies rated  by user a
dataset_u_items = dataset_u(2,:); % retain only the movies rated by user u

[C,ia,ib] = intersect(dataset_a_items,dataset_u_items); % find the common movies rated by both
dataset_a_bothrated = dataset_a(:,ia);
dataset_u_bothrated = dataset_u(:,ib);

ratingmatrix = [dataset_a_bothrated(3,:)' , dataset_u_bothrated(3,:)'];

 final = pearsoncorrelation(ratingmatrix);                                %   These are two variants of pearsoncorrelation
%  final = Constrainedpearsoncorrelation(ratingmatrix);                   %   experiment with both

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Find pearson correlation coefficients calculated from an input matrix whose rows are observations
%%% and whose columns are variables
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
function val=pearsoncorrelation(ratingmatrix)
[ix,iy]=size(ratingmatrix);
if((ix==0))
  val=-99999; % some random low value to discard it.
else
  if(ix == 1)
    val=-99999;  % for a single element, standard deviation is 0 so correlation not defined
  else
    Corr = cov(ratingmatrix);
    if(Corr(1,1)==0 | Corr(2,2)==0)
     val = -99999; % standard deviation is 0
    else
     %val = Corr(1,2)/sqrt(Corr(1,1)*Corr(2,2));
     temp1=corrcoef(ratingmatrix);
     val=temp1(1,2);
    end
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Constrained pearson correlation
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function val=Constrainedpearsoncorrelation(ratingmatrix)
[ix,iy]=size(ratingmatrix);
if((ix==0))
  val=-99999; % some random low value to discard it.
else
  if(ix == 1)
    val=-99999;  % for a single element, standard deviation is 0 so correlation not defined
  else
    Corr = cov(ratingmatrix);
    if(Corr(1,1)==0 | Corr(2,2)==0)
     val = -99999; % standard deviation is 0
    else
      std_a=std(ratingmatrix(:,1));
      std_b=std(ratingmatrix(:,2));
      val=0;
      for counter=1:ix
	val = val + ((ratingmatrix(counter,1) - 3 )*(ratingmatrix(counter,2)- 3 )); %% 3 is the mid-point of 5 star rating scale
      end
      val = val/(std_a * std_b);
    end
  end
end