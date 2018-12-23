%
% ObjVal = tspfun(Phen, Dist)
% Implementation of the TSP fitness function
%	Phen contains the phenocode of the matrix coded in path
%	representation
%	Dist is the matrix with precalculated distances between each pair of cities
%	ObjVal is a vector with the fitness values for each candidate tour (=each row of Phen)
%

function ObjVal = tspfun_path(Phen, Dist)
    disp(size(Phen,1));
    ObjVal=zeros(size(Phen,1),1);
    disp(ObjVal);
    disp(size(ObjVal));
    for k = 1 : size(Phen,1) 
        ObjVal(k,1)=Dist(Phen(k,1),Phen(k,end)); % Add distance from last element back to first
        for t=1:(size(Phen,2)-1)
            ObjVal(k,1)=ObjVal(k,1)+Dist(Phen(k,t),Phen(k,t+1));  % Calculate distance for every part of the path
        end
    end
    disp(ObjVal);
    disp(size(ObjVal));



% End of function

