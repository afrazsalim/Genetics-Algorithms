% low level function for TSP mutation
% reciprocal exchange : one subtour is moved
% Representation is an integer specifying which encoding is used
%	1 : adjacency representation
%	2 : path representation
%

function NewChrom = cut(OldChrom,Representation);

NewChrom=OldChrom;

if Representation==1 
	NewChrom=adj2path(NewChrom);
end

length = 3;
start = randi(size(NewChrom,2)-length);
cut = NewChrom(start : start+length); 
NewChrom(start : start+length) = [];
insert = randi(size(NewChrom,2));
if insert==1
    NewChrom = [cut NewChrom(insert: size(NewChrom,2))];
else
    NewChrom = [NewChrom(1:insert-1) cut NewChrom(insert: size(NewChrom,2))];
end

if Representation==1
	NewChrom=path2adj(NewChrom);
end


% End of function
