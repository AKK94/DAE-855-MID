% Artificial Bee Colony algorithm by Karaboga
% Project: DAE-855-MID
% Project Title: High temperature thermal contact conductance (TCC) 
% measurement for PT-CT contact
%
% Developer: Akshay Kumar Khandelwal
% Contact: akshay.kr.khandelwal@gmail.com

%% This is the main file to invoke ABC algorithm to find TCC for the given data
% Few parameters can also be added to the system to make it realistic.

% Initialization of the problem set
FDMGeneratedData;

tic;
% Set time at which algorithm estimates TCC
count = 1;
for i = 1:10:100;
    CheckTime = i;
    % Invoke the function to estimate TCC
    SolTCC(count) = ArtificialBeeColony(T1( :, t==CheckTime), T2( :, t==CheckTime), CheckTime);
    count = count + 1;
end
toc;