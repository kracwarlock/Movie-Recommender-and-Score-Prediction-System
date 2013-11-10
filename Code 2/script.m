
dataset=read_dataset('../ml-100k/u3.base',0);
save('dataset','dataset');

similarity=pearsonsimilarity(dataset);
save('similarity','similarity');

train_ratings=zeros(943,1682);

for i=1:1682
    for j=1:943
        ind=find((dataset(1,:)==j) & (dataset(2,:)==i));
        if isempty(ind)
            train_ratings(j,i)=0;
        else
            train_ratings(j,i)=dataset(3,ind);
        end
    end
    if (mod(i,50)==0)
        disp(i);
    end
end
save('train_ratings','train_ratings');

load('train_ratings.mat');
train_ratings_orig=train_ratings;
save('train_ratings_orig','train_ratings_orig');
train_ratings_temp=zeros(943,1682);
for i=1:1682
    for j=1:943
        train_ratings_temp(j,i)=find_rating(j,i,dataset,similarity,20);
    end
    sprintf('%d',i)
end
train_ratings=train_ratings_temp;
save('train_ratings_all_done','train_ratings');
train_ratings(isnan(train_ratings))=0;
save('train_ratings_wonan','train_ratings');

load('train_ratings_wonan.mat');
for i=1:1682
    for j=1:943
        if train_ratings(j,i)<=0
            train_ratings(j,i)=0;
        end
        if train_ratings(j,i)>=5
            train_ratings(j,i)=5;
        end
    end
    if (mod(i,50)==0)
        disp(i);
    end
end
save('train_ratings_final','train_ratings');




testset=read_dataset('../ml-100k/u3.test',0);
save('testset','testset');
test_ratings=zeros(943,1682);
for i=1:1682
    for j=1:943
        ind=find((testset(1,:)==j) & (testset(2,:)==i));
        if isempty(ind)
            test_ratings(j,i)=0;
        else
            test_ratings(j,i)=testset(3,ind);
        end
    end
    if (mod(i,50)==0)
        disp(i);
    end
end
save('test_ratings','test_ratings');



error_sq = 0;
count = 0;
for i=1:1682
    for j=1:943
        if(train_ratings_orig(j,i)>=1)
            count = count+1;
            error_sq = error_sq + abs(train_ratings_orig(j,i)-train_ratings(j,i))*abs(train_ratings_orig(j,i)-train_ratings(j,i));
        end
    end
end
count
error_sq
crossval_rmse = sqrt(error_sq/count)



load('D.mat');
KDT = KDTreeSearcher(D);
testset_predicted=zeros(943,1682);
for i=1:943
    for j=1:1682
        if(test_ratings(i,j)>0)
            IDX = knnsearch(KDT,D(1,:),'k',5);
            rating=0;
            for k=1:5
                rating = rating + train_ratings(IDX(k),j);
            end
            rating = rating/5;
            testset_predicted(i,j)=rating;
        end
    end
    if (mod(i,50)==0)
        disp(i);
    end
end
save('testset_predicted','testset_predicted');


load('testset_predicted.mat');
error_sq = 0;
count = 0;
for i=1:1682
    for j=1:943
        if(test_ratings(j,i)>=1)
            count = count+1;
            error_sq = error_sq + abs(test_ratings(j,i)-testset_predicted(j,i))*abs(test_ratings(j,i)-testset_predicted(j,i));
        end
    end
end
count
error_sq
testset_rmse = sqrt(error_sq/count)
