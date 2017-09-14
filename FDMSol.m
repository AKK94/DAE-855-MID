% Artificial Bee Colony algorithm by Karaboga
% Project: DAE-855-MID
% Project Title: High temperature thermal contact conductance (TCC) 
% measurement for PT-CT contact
%
% Developer: Akshay Kumar Khandelwal
% Contact: akshay.kr.khandelwal@gmail.com

%% A fuction to generate data for the given TCC to be used in conjuncture with ABC
% A value of TCC will be passed to the function and it will calculate
% Temperature distribution according to the TCC provided and thus return
% with values to calculate fitness of the solution.

%% Definition of function
function [U1, U2] = FDMSol(TCC, tn)
%TCC = X(1);
%tn = test;
    %% Initialization
    x1 = 0:0.001:0.030;                 % Nodes for upper specimen
    dx1 = x1(2);                        % Differential element
    x2 = 0:0.001:0.030;                 % Nodes for lower specimen
    dx2 = x2(2);                        % Differential element
    t = 0:0.001:tn;                     % Time nodes
    dt = t(2);                          % Differential time

    % Material properties
    k = 16;                             % Thermal Conductivity
    alpha = 4.09e-6;                    % Thermal Diffusivity

    % CFL condition
    a = alpha*dt/(dx1^2);
    if a > 0.5
        print('CFL Condition failed');
    end

    % Definition of solution matrix and boundary condition
    R1 = zeros( length(x1), length(t)) + 25;
    R2 = zeros( length(x2), length(t)) + 25;
    R1( 1, :) = 300;
    R1( :, 1) = 300;
    R2( end, :) = 25;

    %% Solution by FDM
    for j = 1:length(t)-1
        % For upper specimen
        for i = 2:length(x1)-1
            R1( i, j+1) = a*( R1(i-1, j) - 2*R1( i, j) + R1( i+1, j)) + R1( i, j);
        end

        % For Nodes at interface
        R1( end, j+1) = R1( end - 1, j+1) - (TCC*dx1/k)*(R1( end, j) - R2( 1, j));
        R2( 1, j+1) = (TCC*dx1/k)*(R1( end, j) - R2( 1, j)) + R2( 2, j);

        % For Lower specimen
        for i = 2:length(x2)-1
            R2( i, j+1) = a*( R2(i-1, j) - 2*R2( i, j) + R2( i+1, j)) + R2( i, j);
        end
    end

    %% Return of the final solution
    U1 = R1( :, end);
    U2 = R2( :, end);
end