% Artificial Bee Colony algorithm by Karaboga
% Project: DAE-855-MID
% Project Title: High temperature thermal contact conductance (TCC) 
% measurement for PT-CT contact
%
% Developer: Akshay Kumar Khandelwal
% Contact: akshay.kr.khandelwal@gmail.com

%% A fuction to calculate root mean squared error to be used in conjuncture with ABC
% The function shall handle 4 matrices of same dimentions to calculate
% root mean squared error to be used as a optimization function in the ABC

%% Definition of function
function Nector = RMS(U1, U2, R1, R2)
    Nector = (sum((R1 - U1).^2))^0.5 + (sum((R2 - U2).^2))^0.5;
end
    