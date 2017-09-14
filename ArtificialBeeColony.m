% Artificial Bee Colony algorithm by Karaboga
% Project: DAE-855-MID
% Project Title: High temperature thermal contact conductance (TCC) 
% measurement for PT-CT contact
%
% Developer: Akshay Kumar Khandelwal
% Contact: akshay.kr.khandelwal@gmail.com

%% Setup and initialization of the algorithm

% SN -> Number of explored sources = Number of employed bees
% D -> Dimention of the source (finding of TCC, D = 1)
% lim -> Number of corrections of a source
% MCN -> Maximum cycle number
% X(i) -> Matrix to location of necter sources (Value of TCC-Range: 1000 to 8000)

SN = 10;
EBees = SN;
Scout = 1;
D = 1;
lim = 5;
MCN = 10;
X = 1000 + rand( 1, SN)*7000;
NewX = X;

%% Problem Definition
% Test for one time frame and then utilize the loops to run complete
% simualtion
SolNo = 2;
for CheckTime = 0.001:0.001:10
    for cycle = 1:MCN
        % Find fitness parameters for each source by scout
        for i = 1:SN
            [U1, U2] = FDMSol( X(i), CheckTime);
            F(i) = (sum((T1( :, SolNo) - U1).^2))^0.5 + (sum((T2( :, SolNo) - U2).^2))^0.5; %RMS( U1, U2, T1( :, SolNo), T2( :, SolNo)); %find(t==CheckTime)
            fit(i) = 1/(1 + F(i));
        end
        Prob = fit/sum(fit);                    % Probablity for each food source
        SortProb = sort(Prob);

        % Selection of food source by group of bees on the basis of probablity
        GBees = round(Prob*SN);                 % Group of Employed Bees
        while sum(GBees) ~= SN
            if sum(GBees) < SN
                if GBees(Prob == SortProb(end)) < SN
                    GBees(Prob == SortProb(end)) = GBees(Prob == SortProb(end)) + 1;
                else
                    GBees(Prob == SortProb(end - 1)) = GBees(Prob == SortProb(end - 1)) + 1;
                end
            end
            if sum(GBees) > SN
                if GBees(Prob == SortProb(1)) > 0
                    GBees(Prob == SortProb(1)) = GBees(Prob == SortProb(1)) - 1;
                else
                    GBees(Prob == SortProb(2)) = GBees(Prob == SortProb(2)) - 1;
                end
            end
        end

        % Assignment of food sources. As waggle dance can only approximatlely
        % convey the information of the location of food sources, a variation
        % occurs in the location of food source.
        count = 1;
        for i = 1:SN
            for j = 1:GBees(i)
                NewX(count) = X(i) + (rand()-0.5)*abs(( X(i) - X(round((rand()*0.9+0.1)*SN))));
                count = count + 1;
            end
        end

        % Comparision of new food sources with the old ones, the new food sources
        % replaces the old if nector quality is better
        for i = 1:SN
            [U1, U2] = FDMSol( NewX(i), CheckTime);
            NewF(i) = (sum((T1( :, SolNo) - U1).^2))^0.5 + (sum((T2( :, SolNo) - U2).^2))^0.5; %RMS( U1, U2, T1( :, t==CheckTime), T2( :, t==CheckTime));
            if NewF(i) < F(i)
                X(i) = NewX(i);
            end
        end

        % Replacement of worst food source with a new source which scout bee has
        % found out
        for i = 1:Scout
            X( NewF == max(NewF)) = min(X) + rand()*( max(X) - min(X));
        end
    end
    
    % Collect Solutions
    SolTCC(SolNo) = sum(X)/SN;
    SolNo = SolNo + 1;
end

















