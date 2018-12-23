% low level function for calculating an offspring
% given 2 parent in the Parents - agrument
% Parents is a matrix with 2 rows, each row
% represent the genocode of the parent
%
% Tim.Volodine@cs.kuleuven.ac.be
% Tim.Pillards@cs.kuleuven.ac.be
%

function Offspring=cross_order_based(Parents);
	cols=size(Parents,2);
	Offspring=Parents(2,:);
    
    disp("cols")
    disp(cols);
    
    positions = sort(randperm(cols, floor(cols/3))); % Create an array with unique numbers to see which positions are taken from the path.
    
    disp("parents")
    disp(Parents)
    
    disp("positions")
    disp(positions)
    
    cities=Parents(1, positions);
    
    disp("cities")
    disp(cities)
    
    mask = ismember(Offspring(1,:), cities) ;
    disp("mask");
    disp(mask);
    k = 1
    for j=1:cols
        if mask(j)
            Offspring(1,j)= cities(k);
            k = k + 1;
        end
    end
    
    
% end function
