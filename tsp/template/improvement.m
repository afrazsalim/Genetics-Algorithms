   classdef improvement
    properties
      previousCounter = 0;
      previousDistance = 0;
      result = false;
    end
    methods
     function r = improvementGen(value,distvalue,maxChances)
         resultValue = abs(distvalue-value.previousDistance);
         disp("distance");
         disp(resultValue);
           if (resultValue > 0)
               value.previousDistance = distvalue;
               value.result = true;
               value.previousCounter = 0;
               r = value;
           else
               value.previousCounter = value.previousCounter + 1;
               if(value.previousCounter >= maxChances)
                   value.result = false;
                   r = value;
               else
                   value.result = true;
                   r = value;
               end
           end
                       
     end
    end
   end

  
   