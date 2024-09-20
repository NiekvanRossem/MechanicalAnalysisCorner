%%-----------------------------------------------------------------------%%
% filename:         Tresca.m
% author(s):        Niek van Rossem
% Creation date:    20-09-2024
%%-----------------------------------------------------------------------%%

function E = GreenLagrange(U)
    
    % calculate right Cauchy-Green deformation tensor
    C = U*U';

    % calculate Green-Lagrange strain
    E = 0.5*(C - eye(3));

end

