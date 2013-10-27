function dataset=read_dataset(filename,numLimit);
% Reads from file named filename and stores user id | item id | rating | timestamp
% into a matrix dataset.
% 
%
% Akarshan Sarkar, Oct 2013

fid=fopen(filename,'r');
n = linecount(fid);
fclose(fid);

if( (numLimit <= 0) | (numLimit > n) )
  numLimit = n; % take all data
end
dataset=zeros(4,numLimit);
[dataset(1,:),dataset(2,:),dataset(3,:),dataset(4,:)] = textread(filename,'%u %u %u %u',numLimit);


%%%%%%%%%%%%%%%%%%
%%
%% Counts number of lines in the file
%%
%%%%%%%%%%%%%%%%%%%%%
function n = linecount(fid)
n = 0;
tline = fgetl(fid);
while ischar(tline)
  tline = fgetl(fid);
  n = n+1;
end