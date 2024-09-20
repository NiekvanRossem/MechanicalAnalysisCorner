%%-----------------------------------------------------------------------%%
% filename:         VonMises.m
% author(s):        Niek van Rossem
% Creation date:    20-09-2024
%%-----------------------------------------------------------------------%%

function sigma_e = VonMises(sigma)
    %% Documentation
    % This function takes an arbitrary stress tensor and calculates the
    % corresponding Von Mises stress.
    %
    % INPUTS
    % ======
    % sigma: 3x3 matrix
    %   Stress tensor to be evaluated.
    %
    % OUTPUTS
    % =======
    % sigma_e: double
    %   Equivalent Von Mises stress.
    
    %% Function

    % calculate hydrostatic stress
    sigma_m = trace(sigma);

    % calculate deviatoric stress tensor
    sigma_prime = sigma - (1/3)*sigma_m*eye(3);

    % calculate Von Mises stress
    sigma_e = sqrt((3/2)*sum(sum(sigma_prima.*sigma_prime)));

end

