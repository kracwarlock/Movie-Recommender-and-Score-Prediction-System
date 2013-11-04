dataset=read_dataset('../ml-100k/u1.base',0);
save('dataset','dataset');
%{
similarity=pearsonsimilarity(dataset);
save('similarity','similarity');
train_ratings=zeros(943,1682);

for i=1:1682
    for j=1:943
        ind=find((dataset(1,:)==j) & (dataset(2,:)==i));
        if isempty(ind)
            train_ratings(j,i)=-1;
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
for i=1:1682
    for j=1:943
        if train_ratings(j,i)==-1
            train_ratings(j,i)=find_rating(j,i,dataset,similarity,20);
        end
        sprintf('%d %d',j,i)
    end
end
save('train_ratings_all_done','train_ratings');
%}
testset=read_dataset('../ml-100k/u1.test',0);
save('testset','testset');
demog_simi=;
