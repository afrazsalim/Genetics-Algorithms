function run_ga_path(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3)
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP}


        tic % Timer function to evaluate performance

        maxChances = 1000;
        GGAP = 1 - ELITIST;
        mean_fits=zeros(1,MAXGEN+1);
        worst=zeros(1,MAXGEN+1);
        Dist=zeros(NVAR,NVAR);
        for i=1:size(x,1)
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        % initialize population
        Chrom=zeros(NIND,NVAR);
        for row=1:NIND
        	%Chrom(row,:)=path2adj(randperm(NVAR));
            Chrom(row,:)=randperm(NVAR);  % CHROM now contains n paths of NVAR length 
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        ObjV = tspfun_path(Chrom,Dist);
        best=zeros(1,MAXGEN);
        %Create a new StopingCriteria's class
        impObject = improvement;
        %imp.previousCounter = 0;
        % generational loop
        while (gen<MAXGEN)
            sObjV=sort(ObjV);
          	best(gen+1)=min(ObjV);
        	minimum=best(gen+1);
            impObject = improvementGen(impObject,minimum,maxChances);
            if(impObject.result == 0)
                disp("breaking the main loop");
                disp(gen);
                break;
            end
            %disp("generation");
            %disp(gen);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum)
                    break;
                end
            end
            
            visualizeTSP(x,y,0,Chrom(t,:), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);

            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end          
        	%assign fitness values to entire population
        	FitnV=ranking(ObjV);
        	%select individuals for breeding
        	SelCh=select('sus', Chrom, FitnV, GGAP);
            
        	%To DO : Implement RECOMBINATION and MUTATION
            SelCh = recombin('xalt_edges',SelCh,PR_CROSS);
            SelCh=mutateTSP_path('inversion',SelCh,PR_MUT);
            
            %evaluate offspring, call objective function
        	ObjVSel = tspfun(SelCh,Dist);
            %reinsert offspring into population
        	[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        	%increment generation counter
        	gen=gen+1;            
        end
        
        toc  % end of timer function
        
end




%%function output = improvementInGen(value) 
 
        %%output = true;
        
        
        %%end