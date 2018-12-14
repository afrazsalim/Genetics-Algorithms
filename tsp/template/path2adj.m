%
% path2adj(Path)
% function to convert between path and adjacency representation for TSP
% Path and Adj are row vectors
%

function Adj = path2adj(Path);

	Adj=zeros(size(Path));
	for t=1:size(Path,2)-1
		Adj(Path(t))=Path(t+1);
	end
	Adj(Path(size(Path,2)))=Path(1);
	

% End of function

