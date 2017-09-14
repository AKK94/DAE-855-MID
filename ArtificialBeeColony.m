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
Scout = 1;
D = 1;
lim = 5;
MCN = 10;
X = 1000 + rand( 1, SN)*7000;

%% Problem Definition
% Test for one time frame and then utilize the loops to run complete
% simualtion
test = 50;

% Find fitness parameters for each source by scout
for i = 1:SN
    [U1, U2] = FDMSol( X(i), test);
    F(i) = RMS( U1, U2, T1( :, t==test), T2( :, t==test));
    fit(i) = 1/(1 + F(i));
end
Prob = fit/sum(fit);                    % Probablity for each food source

% Selection of food source by group of bees on the basis of probablity
