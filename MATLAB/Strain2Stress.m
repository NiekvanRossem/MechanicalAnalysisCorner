%%-----------------------------------------------------------------------%%
% filename:         Strain2Stress.m
% author(s):        Niek van Rossem
% Creation date:    20-09-2024
%%-----------------------------------------------------------------------%%

function sigma = Strain2Stress(epsilon, E, nu)
    %% Documentation
    % This function takes an arbitrary strain tensor and calculates the
    % corresponding stress tensor. It uses linear elasticity for the
    % conversion. This means it will only work for isotropic materials. For
    % the material properties keep the units in mind. If your Young's
    % modulus is defined in MPa your stress tensor will be too!
    %
    % INPUTS
    % ======
    % epsilon: 3x3 matrix
    %   Strain tensor to be evaluated.
    % E: double
    %   Young's modulus of the chosen material.
    % nu: double
    %   Poisson's ratio of the chosen material.
    %
    % OUTPUTS
    % =======
    % sigma: 3x3 matrix
    %   Stress tensor belonging to the stress tensor.
    
    %% Function

    % check if strain tensor is symmetric
    if epsilon(1,2) ~= epsilon(2,1)
        disp('Stress tensor needs to be symmetric! s(1,2) must equal s(2,1).');
    elseif epsilon(1,3) ~= epsilon(3,1)
        disp('Stress tensor needs to be symmetric! s(1,3) must equal s(3,1).');
    elseif epsilon(2,3) ~= epsilon(3,2)
        disp('Stress tensor needs to be symmetric! s(2,3) must equal s(3,2).');
    end
    
    % convert to Voight notation
    epsilon_v = [
        epsilon(1,1); 
        epsilon(2,2); 
        epsilon(3,3);
        epsilon(2,3);
        epsilon(1,3);
        epsilon(1,2)
        ];

    % linear elasticity matrix
    M = E/((1 - nu)*(1 - 2*nu))*[
        1-nu        nu          nu          0           0           0;
        nu          1-nu        nu          0           0           0;
        nu          nu          1-nu        0           0           0;
        0           0           0           (1-2*nu)/2  0           0;
        0           0           0           0           (1-2*nu)/2  0;
        0           0           0           0           0           (1-2*nu)/2
        ];

    % strain in Voight notation
    sigma_v = M*epsilon_v;

    % convert to matrix notation
    sigma = [
        sigma_v(1) sigma_v(6) sigma_v(5);
        sigma_v(6) sigma_v(2) sigma_v(4);
        sigma_v(5) sigma_v(4) sigma_v(3)
        ];

end