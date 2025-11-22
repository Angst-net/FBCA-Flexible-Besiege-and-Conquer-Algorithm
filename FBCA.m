%  Flexible Besiege and Conquer Algorithm (FBCA)
%  
%  Source code v1.0
%
%  Main Paper:
%    Guo, Shuxin and Guo, Chenxu and Jiang, Jianhua,
%    FBCA: Flexible Besiege and Conquer Algorithm for Multi-Layer Perceptron Optimization Problems,
%    Biomimetics,
%    VOLUME = {10},
%    YEAR = {2025},
%    NUMBER = {11},
%    ARTICLE-NUMBER = {787},
%    10.3390/biomimetics10110787
%______________________________________________________________________________________________


function [gBestObj,gBestPos,convergence]= FBCA(N,Max_iter,lb,ub,dim,fobj)
display('FBCA is optimizing your problem');

Particle_Number=N;
nSoldiers=10;   % is the number of soldiers in each army. 
nArmies=round(Particle_Number/nSoldiers); % initial number of armies.
D= dim;                           % Dimensionality of the problem
Max_Gen=Max_iter;
fes=Particle_Number;              % is the fes counter.
ub=ub.*ones(1,dim);               % upper bound
lb=lb.*ones(1,dim);               % Low bound
BCB=0.8*ones(1,Max_Gen);          % BCB parameter
armies=zeros(nArmies,D);          % army group
obj_armies=zeros(1,nArmies);      % objective function value for each army
velocity = zeros(nArmies, D);     % Initialize velocities
t=1;                              % t indicates the generation
fireTimes=0;
convergence = ones(1,Max_Gen);    % record the convergence values
armies=initialization(Particle_Number,dim,ub,lb);

for i=1:nArmies 
    obj_armies(i,:)=fobj(armies(i,:)); % the initialized objective values for each army
end

[~,indis]=min(obj_armies);
indis=indis(end);
best=obj_armies(indis);
best_army=armies(indis,:);

while  (t <= Max_Gen)
    for i=1:nArmies % for each army
        soldiers=zeros(nSoldiers,D);
        obj_soldiers=zeros(1,nSoldiers);
        for j=1:nSoldiers
            r=fix(rand*nArmies)+1;
            while(i==r)
                r=fix(rand*nArmies)+1;
            end

            for d=1:D
                if rand<BCB(t)
                    alpha = rand * 2 * pi; 
                    if rand < 0.5 
                        % Gaussian Perturbation Mechanism
                        soldiers(j,d)=best_army(d)+abs(armies(r,d)-armies(i,d))*sin(alpha);
                        soldiers(j,d) = soldiers(j,d) + 0.1 * randn; 
                    else
                        % Spiral Perturbation Mechanism
                        a2=-1+t*((-1)/Max_iter);
                        b=1 + (0.5 * rand * (1 -(t/Max_Gen)^2)); 
                        l=(a2-1)*rand+1;
                        factor = exp(b * l) * cos(2 * pi * l); 
                        soldiers(j,d) =  factor * abs(armies(r,d) - armies(i,d)) + armies(i,d);
                    end
                    % Boundary check
                    if (soldiers(j,d)>ub(j) || soldiers(j,d)<lb(j))
                        soldiers(j,d)=BCB(t)*best_army(d)+(1-BCB(t))*armies(i,d);
                    end
                else
                    beta = rand * 2 * pi;
                    w =  0.9;
                    c1 = 0.2 + (0.1 * rand * (1 -(t/Max_Gen))^(2 *(t/Max_Gen))); % Cognitive coefficient
                    c2 = 2; % Social coefficient
                    r1 = rand;
                    r2 = rand;               
                    if rand < (0.1 + 0.05 * rand * (1 - t/Max_Gen)^((t/Max_Gen)/10))
                        % Cognitive Velocity Update Mechanism
                        velocity(i, d) = w * velocity(i, d) + c1 * r1 * (armies(r, d) - armies(i, d)) + c2 * r2 * (best_army(d) - armies(i, d));
                        soldiers(j, d) = armies(i, d) + velocity(i, d);
                    else
                        soldiers(j,d) = armies(r,d) + cos(beta) * abs(armies(r,d) - armies(i,d));
                    end
                    % Boundary check
                    if (soldiers(j,d)>ub(j) || soldiers(j,d)<lb(j))
                        soldiers(j,d)=lb(j)+(ub(j)-lb(j))*rand; % EQ（4）
                    end
                end
            end
        end

        obj_soldiers=fobj(soldiers); % Evaluate soldiers' objective function
        % The best soldier becomes the general of the army
        [~,indis]=min(obj_soldiers);
        indis=indis(end);
        if(obj_soldiers(indis)<obj_armies(i)) % Soldier can be the leader of the army
            armies(i,:)=soldiers(indis,:);
            obj_armies(i)=obj_soldiers(indis);
        end
        fes=fes+nSoldiers;
    end

    [~,indis]=min(obj_armies);
    indis=indis(end);
    tmp_best=obj_armies(indis); % Temporary best army objective value for the hidden enemy
    tmp_best_army=armies(indis,:); % Temporary best army position

    distance(t) = dist(best_army,tmp_best_army');
    if distance(t)==0
        fireTimes=fireTimes+1;
        if fireTimes>=1
            for k=1:10
                BCB(t+k)=0.2;
            end
            fireTimes=0;
        end
    else
        BCB(t+1)=0.8;
    end

    % Update the best_army
    if(tmp_best<best)
        best=tmp_best;
        best_army=tmp_best_army; % Store current best position
    end
    convergence(t)=best;
    t=t+1;
end
gBestPos = best_army; % Return global best army position
gBestObj =best; %Return global best army objective value
fesNum=fes; % Return the total number of function evaluations
end
