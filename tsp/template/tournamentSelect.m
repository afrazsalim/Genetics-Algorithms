 %numberOfCandidates: How many candidates take part in competition.
function SelCh = tournamentSelect(Chrom, FitnV, GGAP,SUBPOP,numberOfCandidates);

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
  SelCh = [];
  currentIndex = 1;
  [ m,n] = size(FitnV);
   for irun = 1:NSel,
       %Generate random number between 0-Nind
       r = randi(m,1,numberOfCandidates);
       currentIndex = r(1);
       for j = 1:numberOfCandidates-1,
         if FitnV(r(j)) > FitnV(r(j+1))
             currentIndex = r(j);
         else
             currentIndex = r(j+1);
         end
       end
       SelCh=[SelCh;Chrom(currentIndex,:)];
   end
 

% End of function
