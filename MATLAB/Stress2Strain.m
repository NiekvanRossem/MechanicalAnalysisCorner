%%-----------------------------------------------------------------------%%
% filename:         Stress2Strain.m
% author(s):        Niek van Rossem
% Creation date:    29-09-2023
%%-----------------------------------------------------------------------%%

function epsilon = Stress2Strain(sigma, E, nu)
    %% Documentation
    % This function takes an arbitrary stress tensor and calculates the
    % corresponding strain tensor. It uses linear elasticity for the
    % conversion. This means it will only work for isotropic materials. For
    % the material properties keep the units in mind. If your Young's
    % modulus is defined in MPa your stress tensor should be too!
    %
    % INPUTS
    % ======
    % sigma: 3x3 matrix
    %   Stress tensor to be evaluated.
    % E: double
    %   Young's modulus of the chosen material.
    % nu: double
    %   Poisson's ratio of the chosen material.
    %
    % OUTPUTS
    % =======
    % epsilon: 3x3 matrix
    %   Strain tensor belonging to the stress tensor.
    
    %% Function

    % check if stress tensor is symmetric
    if sigma(1,2) ~= sigma(2,1)
        disp('Stress tensor needs to be symmetric! s(1,2) must equal s(2,1).');
    elseif sigma(1,3) ~= sigma(3,1)
        disp('Stress tensor needs to be symmetric! s(1,3) must equal s(3,1).');
    elseif sigma(2,3) ~= sigma(3,2)
        disp('Stress tensor needs to be symmetric! s(2,3) must equal s(3,2).');
    end
    
    % convert to Voight notation
    sigma_v = [
        sigma(1,1); 
        sigma(2,2); 
        sigma(3,3);
        sigma(2,3);
        sigma(1,3);
        sigma(1,2)
        ];

    % linear elasticity matrix
    M = (1/E)*[
        1           -nu         -nu         0           0           0;
        -nu         1           -nu         0           0           0;
        -nu         -nu         1           0           0           0;
        0           0           0           2*(1+nu)    0           0;
        0           0           0           0           2*(1+nu)    0;
        0           0           0           0           0           2*(1+nu)
        ];

    % strain in Voight notation
    eps_v = M*sigma_v;

    % convert to matrix notation
    epsilon = [
        eps_v(1) eps_v(6) eps_v(5);
        eps_v(6) eps_v(2) eps_v(4);
        eps_v(5) eps_v(4) eps_v(3)
        ];
end