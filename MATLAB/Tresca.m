%%-----------------------------------------------------------------------%%
% filename:         Tresca.m
% author(s):        Niek van Rossem
% Creation date:    20-09-2024
%%-----------------------------------------------------------------------%%

function sigma_e = Tresca(sigma)
    %% Documentation
    % This function takes an arbitrary stress tensor and calculates the
    % corresponding Tresca stress.
    %
    % INPUTS
    % ======
    % sigma: 3x3 matrix
    %   Stress tensor to be evaluated.
    %
    % OUTPUTS
    % =======
    % sigma_e: double
    %   Equivalent Tresca stress.
    
    %% Function

    % check if stress tensor is symmetric
    if sigma(1,2) ~= sigma(2,1)
        disp('Stress tensor needs to be symmetric! s(1,2) must equal s(2,1).');
    elseif sigma(1,3) ~= sigma(3,1)
        disp('Stress tensor needs to be symmetric! s(1,3) must equal s(3,1).');
    elseif sigma(2,3) ~= sigma(3,2)
        disp('Stress tensor needs to be symmetric! s(2,3) must equal s(3,2).');
    end

    % calculate invariants
    S_I     = trace(sigma);
    S_II    = 0.5*(trace(sigma))^2 - 0.5*trace(sigma*sigma);
    S_III   = det(sigma);

    % calculate Tresca stress
    sigma_e = max([S_III, S_II, S_III]);
end

