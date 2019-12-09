function dx = spm_F2_v1(x,v,pE)
	Nsyl = length(x) - 20; % number of syllables

	%% timing/gamma units
	y1 = x(1:8,1);
	y2 = x(9:16,1);

	% parameters for gamma - for reset
	y10 = [2.9694   -0.9939   -3.7408   -4.2104   -4.2352   -4.3895   -5.6266   -1.4123]';
	y20 = [0.9669    0.0179    0.0012    0.0007    0.0007    0.0006    0.0002    0.0117]';

	% speed variable - in here it controls the speed of gamma units 
	speed = x(17, 1);

	%% theta part
	z1 = x(18,1);
	z2 = x(19,1);

	fs = 1000;
	ff = 5;
	kk = 2*pi*ff/fs;

	% trigger at the phase specified below
	R = sqrt(power(z1,2) + power(z2,2));
    z1n = z1./R;
    z2n = z2./R;
    
    m1n = -1;
    m2n = 0;

    sigT = 0.15;
    trg_th = exp(-(power(z1n-m1n,2)+power(z2n-m2n,2))/(2*sigT^2));

	%% input
	input = x(20,1);
	d_input = 0;

	filt_env = 0.25 + input*0.21;

	%% syllable units
	w = x(21 : 20 + Nsyl, 1);
	ww0 = -1*ones(Nsyl,1);
	
	% dynamics
	w0tr = y2(8); % gamma reset / internal timing
    % w0tr = 0; % no reset
	dw = - w0tr*power(w-ww0,1); 

	%% theta dynamics
    dz1 = -kk*z2*(1+filt_env+z1*(filt_env-1));
    dz2 =  kk*z1*(1+filt_env+z1*(filt_env-1));

	%% gamma units - dynamics
	% trigger that resets gamma
    % beta = 0; % no gamma sequence reset
	beta = 0.5; % gamma sequence is reset by theta triggers
	
	Tr = beta*trg_th; % resulting trigger information to gamma sequence
	
	% speed /rate
    th_speed = 1+filt_env+z1*(filt_env-1); % duration/rate estimation from exogenous theta

    % d_speed = 0; % no preferred rate - no theta-gamma coupling
	% d_speed = (1-speed); % preferred fixed rate - endogenous theta-gamma coupling
    d_speed = (th_speed-speed); % theta driven rate - exogenous theta-gamma coupling

	kappa2 = exp(speed - 1) * 1.05/2; 
	lambda = 0.125;

	dV = 0;
	sV = 0.5;
	bV = 1.5;
	N = length(y1);
	rho2 = genR2(dV, sV, bV, (1:N), N);
	s = 1./(1+exp(-y1));
	s1 = rho2*s;

	shc = (-kappa2.*lambda.*y1 - kappa2.*s1 + kappa2);
	
	rst = - power(y1-y10,1);
	dy1 = shc + rst*Tr;

	sum1 = sum(exp(y1));
	rst2 = - power(y2-y20,1);
	dy2 = (exp(y1) - y2*sum1) + rst2*Tr;

	%% output
	dx(1:8,1) = dy1;
	dx(9:16,1) = dy2;
	dx(17,1) = d_speed;

	dx(18,1) = dz1;
	dx(19,1) = dz2;

	dx(20,1) = d_input;

	dx(21 : 20 + Nsyl,1) = dw;

end

