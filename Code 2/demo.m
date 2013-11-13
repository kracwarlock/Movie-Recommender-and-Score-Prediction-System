function rating=demo(age,gender,occupation,zipcode,movie,K)
    load('D.mat');
    load('train_ratings_final.mat');
    load('movie_demo.mat');
    KDT = KDTreeSearcher(D);
    D=zeros(1,30);
    for i=1:1
        if(age>=0 && age<10)
            D(1,1)=1;
        elseif(age>=10 && age<20)
            D(1,2)=1;
        elseif(age>=20 && age<30)
            D(1,3)=1;
        elseif(age>=30 && age<40)
            D(1,4)=1;
        elseif(age>=40 && age<50)
            D(1,5)=1;
        elseif(age>=50 && age<60)
            D(1,6)=1;
        elseif(age>=60 && age<70)
            D(1,7)=1;
        elseif(age>=70 && age<80)
            D(1,8)=1;
        end
        if(strcmp(gender(i),'M')==1)
            D(1,9)=1;
        else
            D(1,10)=1;
        end
        if(strcmp(occupation(i),'administrator')==1)
            D(1,11)=1;
        elseif(strcmp(occupation(i),'artist')==1)
            D(1,12)=1;
        elseif(strcmp(occupation(i),'doctor')==1)
            D(1,13)=1;
        elseif(strcmp(occupation(i),'educator')==1)
            D(1,14)=1;
        elseif(strcmp(occupation(i),'engineer')==1)
            D(1,15)=1;
        elseif(strcmp(occupation(i),'executive')==1)
            D(1,16)=1;
        elseif(strcmp(occupation(i),'healthcare')==1)
            D(1,17)=1;
        elseif(strcmp(occupation(i),'homemaker')==1)
            D(1,18)=1;    
        elseif(strcmp(occupation(i),'lawyer')==1)
            D(1,19)=1;
        elseif(strcmp(occupation(i),'librarian')==1)
            D(1,20)=1;
        elseif(strcmp(occupation(i),'marketing')==1)
            D(1,21)=1;
        elseif(strcmp(occupation(i),'none')==1)
            D(1,22)=1;
        elseif(strcmp(occupation(i),'other')==1)
            D(1,23)=1;
        elseif(strcmp(occupation(i),'programmer')==1)
            D(1,24)=1;
        elseif(strcmp(occupation(i),'retired')==1)
            D(1,25)=1;
        elseif(strcmp(occupation(i),'salesman')==1)
            D(1,26)=1;
        elseif(strcmp(occupation(i),'scientist')==1)
            D(1,27)=1;
        elseif(strcmp(occupation(i),'student')==1)
            D(1,28)=1;
        elseif(strcmp(occupation(i),'technician')==1)
            D(1,29)=1;
        elseif(strcmp(occupation(i),'writer')==1)
            D(1,30)=1;
        end
    end
    movie = movieID(find(strcmp(movieName,movie)));
    IDX = knnsearch(KDT,D(1,:),'k',K);
    rating=0;
    for k=1:K
        rating = rating + train_ratings(IDX(k),movie);
    end
    rating = rating/K;
    if rating>3.2
        fprintf('Yes, he is likely to watch the movie');
    else
        fprintf('No, he is not likely to watch the movie');
    end
end