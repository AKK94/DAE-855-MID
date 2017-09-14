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
function Nector = RMS(U1, U2, T1, T2)
    Nector = (sum((T1 - U1).^2))^0.5 + (sum((T2 - U2).^2))^0.5;
end
    