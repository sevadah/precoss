%% generative model. setting parameters for the generation part

clear M x p

ilevel = 0;

% using default values for correlation and time constant

M(1).E.s = 1;
M(1).E.K = exp(-3);
M(1).E.dt = 1;

%% level 1
ilevel = ilevel + 1;

x1 = zeros(N1,1);

M(ilevel).x = x1; % frequency channels
M(ilevel).f = 'spm_F1_theta';
M(ilevel).g = 'spm_G1_theta';

M(ilevel).V = Vh1;
M(ilevel).W = Wh1;

M(ilevel).pE = I;

%% level 2
ilevel = ilevel + 1;
% gamma units
x2(1 : 8,1)= [2.9694 -0.9939 -3.7408 -4.2104 -4.2352 -4.3895 -5.6266 -1.4123]';
x2(9 : 16,1)= [0.9669 0.0179 0.0012 0.0007 0.0007 0.0006 0.0002 0.0117]';

x2(17,1) = 1; % gamma_speed

x2(18,1) = -1; % theta
x2(19,1) = 0; % theta

x2(20,1) = 0; % input

x2(21 : 20 + Nsyl,1) = -1; % syllable unit

M(ilevel).x = x2;
M(ilevel).f = 'spm_F2_v1';
M(ilevel).g = 'spm_G2_theta';

M(ilevel).V = Vh2;
M(ilevel).W = Wh2;
