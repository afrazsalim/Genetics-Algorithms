function Offspring=cycle_crossOver(Parents);
	cols=size(Parents,2);
	%Offspring=Parents(2,:);
    ParentFirst = Parents(1,:);
    ParentSecond = Parents(2,:);
    randomNumbers = rand(1,cols);
    Offspring = [];
    Contain = zeros(1,cols);
    for i= 1:cols
        if randomNumbers(i) >= 0.5
            for k =1:cols
               result =  Contain(1,ParentFirst(1,k));
               if result == 0
                  Offspring = [Offspring,ParentFirst(1,k)];
                  Contain(1,ParentFirst(1,k))= 1;
                  break;
               end
            end
        else if randomNumbers(i) < 0.5
              for p =1:cols
               result =  Contain(1,ParentSecond(1,p));
                 if result == 0
                     Offspring = [Offspring,ParentSecond(1,p)];
                     Contain(1,ParentSecond(1,p))= 1;
                     break;
                end
            end
            end
        end
    end
      if length(Offspring) ~= length(unique(Offspring))
           warning('something went wrong');
      end
end
