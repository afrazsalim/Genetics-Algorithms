

function SelCh = rankingSelection(SEL_F, Chrom, FitnV, GGAP,S);

% Check parameter consistency
   if nargin < 3, error('Not enough input parameter'); end

   % Identify the population size (Nind)
   [NindCh,Nvar] = size(Chrom);
   [NindF,VarF] = size(FitnV);
   
   if NindCh ~= NindF, error('Chrom and FitnV disagree'); end
   if VarF ~= 1, error('FitnV must be a column vector'); end
  
   if nargin < 5, SUBPOP = 1; end
   if nargin > 4,
      if isempty(SUBPOP), SUBPOP = 1;
      elseif isnan(SUBPOP), SUBPOP = 1;
      elseif length(SUBPOP) ~= 1, error('SUBPOP must be a scalar'); end
   end

   if (NindCh/SUBPOP) ~= fix(NindCh/SUBPOP), error('Chrom and SUBPOP disagree'); end
   Nind = NindCh/SUBPOP;  % Compute number of individuals per subpopulation

   if nargin < 4, GGAP = 1; end
   if nargin > 3,
      if isempty(GGAP), GGAP = 1;
      elseif isnan(GGAP), GGAP = 1;
      elseif length(GGAP) ~= 1, error('GGAP must be a scalar');
      elseif (GGAP < 0), error('GGAP must be a scalar bigger than 0'); end
   end

% Compute number of new individuals (to select)
   NSel=max(floor(Nind*GGAP+.5),2);

% Select individuals from population
   Pop = [];
   Ind = [];
   for k = 1:NindCh,
       Index = 1;
       %Sort the entire Population according to the fitness level.
       for j = 1: size(FitnV) ,
           if FitnV(j) < FitnV(Index)
               Index = j;
           end
       end
       Ind  = [Ind,Index];
       Pop = [Pop; Chrom(Index,:)];
       FitnV(Index) = [];
       Chrom(Index,:) = [];
   end
   SelProb = zeros(NindCh,1);
   S = 1.5;
   for i = 1:NindCh,
       result = ((2-S)/NindCh) + ((2*(i-1)*(S-1))/(NindCh*(NindCh-1)));
       SelProb(i) = result;
   end
   
   
  %call the rws to select individuals now. 
  SelCh=select(SEL_F, Pop, SelProb, GGAP);
 

% End of function
