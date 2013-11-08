load('age');
load('gender');
load('occupation');
D=zeros(943,30);
for i=1:943
    if(age(i)>=0 && age(i)<10)
        D(i,1)=1;
    elseif(age(i)>=10 && age(i)<20)
        D(i,2)=1;
    elseif(age(i)>=20 && age(i)<30)
        D(i,3)=1;
    elseif(age(i)>=30 && age(i)<40)
        D(i,4)=1;
    elseif(age(i)>=40 && age(i)<50)
        D(i,5)=1;
    elseif(age(i)>=50 && age(i)<60)
        D(i,6)=1;
    elseif(age(i)>=60 && age(i)<70)
        D(i,7)=1;
    elseif(age(i)>=70 && age(i)<80)
        D(i,8)=1;
    end
    if(strcmp(gender(i),'M')==1)
        D(i,9)=1;
    else
        D(i,10)=1;
    end
    if(strcmp(occupation(i),'administrator')==1)
        D(i,11)=1;
    elseif(strcmp(occupation(i),'artist')==1)
        D(i,12)=1;
    elseif(strcmp(occupation(i),'doctor')==1)
        D(i,13)=1;
    elseif(strcmp(occupation(i),'educator')==1)
        D(i,14)=1;
    elseif(strcmp(occupation(i),'engineer')==1)
        D(i,15)=1;
    elseif(strcmp(occupation(i),'executive')==1)
        D(i,16)=1;
    elseif(strcmp(occupation(i),'healthcare')==1)
        D(i,17)=1;
    elseif(strcmp(occupation(i),'homemaker')==1)
        D(i,18)=1;    
    elseif(strcmp(occupation(i),'lawyer')==1)
        D(i,19)=1;
    elseif(strcmp(occupation(i),'librarian')==1)
        D(i,20)=1;
    elseif(strcmp(occupation(i),'marketing')==1)
        D(i,21)=1;
    elseif(strcmp(occupation(i),'none')==1)
        D(i,22)=1;
    elseif(strcmp(occupation(i),'other')==1)
        D(i,23)=1;
    elseif(strcmp(occupation(i),'programmer')==1)
        D(i,24)=1;
    elseif(strcmp(occupation(i),'retired')==1)
        D(i,25)=1;
    elseif(strcmp(occupation(i),'salesman')==1)
        D(i,26)=1;
    elseif(strcmp(occupation(i),'scientist')==1)
        D(i,27)=1;
    elseif(strcmp(occupation(i),'student')==1)
        D(i,28)=1;
    elseif(strcmp(occupation(i),'technician')==1)
        D(i,29)=1;
    elseif(strcmp(occupation(i),'writer')==1)
        D(i,30)=1;
    end
end