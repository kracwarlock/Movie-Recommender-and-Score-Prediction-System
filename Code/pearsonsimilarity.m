function similarity=pearsonsimilarity(dataset);
% from dataset composed of userid,itemid,ratings
% compute a 943 X 943 similarity matrix (total no of users = 943)
% similarity(i,j) represents pearson correlation between user i and j
% based on the movies they both have seen.
% 
% 
% Akarshan, Oct 2013
similarity=zeros(943,943);
for i = 1:943
  for j = i:943
   if(mod(j,50)==0)
     fprintf( 'i=%d\n',i);
     fprintf( 'j=%d ',j);
   end
   similarity(i,j)=Compute_similarity(i,j,dataset);
   similarity(j,i)=similarity(i,j);
  end
end


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

 final = pearsoncorrelation(ratingmatrix);
%final = Constrainedpearsoncorrelation(ratingmatrix);

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Find pearson correlation coefficients calculated from an input matrix whose rows are observations
%%% and whose columns are variables
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
function val=pearsoncorrelation(ratingmatrix)
[ix,iy]=size(ratingmatrix);
if((ix==0))
  val=99999; % some random high value
else
  if(ix == 1)
    val=99999;  % for a single element, standard deviation is 0 so correlation not defined
  else
    Corr = cov(ratingmatrix);
    if(Corr(1,1)==0 | Corr(2,2)==0)
     val = 99999; % standard deviation is 0
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
  val=99999; % some random high value
else
  if(ix == 1)
    val=99999;  % for a single element, standard deviation is 0 so correlation not defined
  else
    Corr = cov(ratingmatrix);
    if(Corr(1,1)==0 | Corr(2,2)==0)
     val = 99999; % standard deviation is 0
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

