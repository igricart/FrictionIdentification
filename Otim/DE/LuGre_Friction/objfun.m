%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:         S_MSE= objfun(FVr_temp, S_struct)
% Author:           Ignacio Ricart
% Description:      Implements the LuGre friction parameter identification.
%                   Minimizing the cost function.
% 
% Parameters:       FVr_temp     (I)    Paramter vector
%                   S_Struct     (I)    Contains a variety of parameters.
%                                       For details see Rundeopt.m
% Return value:     S_MSE.I_nc   (O)    Number of constraints
%                   S_MSE.FVr_ca (O)    Constraint values. 0 means the constraints
%                                       are met. Values > 0 measure the distance
%                                       to a particular constraint.
%                   S_MSE.I_no   (O)    Number of objectives.
%                   S_MSE.FVr_oa (O)    Objective function values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S_MSE= objfun(FVr_temp, u, dx)
Fc = FVr_temp(1);
Fs = FVr_temp(2);
Vs = FVr_temp(3);
sigma2 = FVr_temp(4);

%---LuGre Optimization Problem----------------------------------------
fr_ss = (Fc + (Fs-Fc).*exp(-(dx./vs).^2)).*sign(dx) + sigma2.*dx;
error = u - fr_ss;
F_cost = norm(error); 

%----strategy to put everything into a cost function------------
S_MSE.I_nc      = 0;%no constraints
S_MSE.FVr_ca    = 0;%no constraint array
S_MSE.I_no      = 1;%number of objectives (costs)
S_MSE.FVr_oa(1) = F_cost;