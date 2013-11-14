Movie Recommender and Score Prediction System
====================================================
Team Members
* Akarshan Sarkar (akarshan2701)
* Anuj Sharma (sharmaar12)
* Muktinath Vishwakarma (foxx3)
* Shikhar Sharma (kracwarlock)

Usage
-----------------------------------------------------
All scripts are in 'Code 2' folder so switch to that directory

To find out rating of a movie for a user whose only the demographic information is known run this command:
    demo(age,gender,occupation,zipcode,movie_name,K_for_k-NN)
    demo(21,'M','student','94043','Niagara, Niagara ',5)

To run the whole code and compute everything for yourself open script.m and edit the dataset names in the following two lines:
    dataset=read_dataset('../ml-100k/u3.base',0);
    testset=read_dataset('../ml-100k/u3.test',0);
Now run this command:
    script
