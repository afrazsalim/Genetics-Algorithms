% OBJFUN1.M      (OBJective function for De Jong's FUNction 1)
%
% This function implements the De Jong function 1.
%
% Syntax:  ObjVal = objfun1(Chrom,switch_)
%
% Input parameters:
%    Chrom     - Matrix containing the chromosomes of the current
%                population. Each row corresponds to one individual's
%                string representation.
%                if Chrom == [], then special values will be returned
%    switch_    - if Chrom == [] and
%                switch_ == 1 (or []) return boundaries
%                switch_ == 2 return title
%                switch_ == 3 return value of global minimum
%
% Output parameters:
%    ObjVal    - Column vector containing the objective values of the
%                individuals in the current population.
%                if called with Chrom == [], then ObjVal contains
%                switch_ == 1, matrix with the boundaries of the function
%                switch_ == 2, text for the title of the graphic output
%                switch_ == 3, value of global minimum
%                

% Author:     Hartmut Pohlheim
% History:    26.11.93     file created
%             27.11.93     text of title and switch_ added
%             30.11.93     show Dim in figure title
%             16.12.93     switch_ == 3, return value of global minimum
%             01.03.94     name changed in obj*

function ObjVal = objfun1(Chrom,switch_);

% Dimension of objective function
   Dim = 20;
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if switch_ == 2
         ObjVal = ['DE JONG function 1-' int2str(Dim)];
      % return value of global minimum
      elseif switch_ == 3
         ObjVal = 0;
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = 100*[-5.12; 5.12];
         ObjVal = ObjVal(1:2,ones(Dim,1));
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      % function 1, sum of xi^2 for i = 1:Dim (Dim=30)
      % n = Dim, -5.12 <= xi <= 5.12
      % global minimum at (xi)=(0) ; fmin=0
      ObjVal = sum((Chrom .* Chrom)')';
      % ObjVal = diag(Chrom * Chrom');  % both lines produce the same
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

