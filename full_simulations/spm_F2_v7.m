function dx = spm_F2_v7(x,v,pE)
	Nsyl = length(x) - 17; % number of syllables
    
    explicit_onsets =  full(v(1,1));

	%% timing/gamma units
	y1 = x(1:8,1);
	y2 = x(9:16,1);

	% parameters for gamma - for reset
	y10 = [2.9694   -0.9939   -3.7408   -4.2104   -4.2352   -4.3895   -5.6266   -1.4123]';
	y20 = [0.9669    0.0179    0.0012    0.0007    0.0007    0.0006    0.0002    0.0117]';

	% speed variable - in here it controls the speed of gamma units 
	speed = x(17, 1);

	%% syllable units
	w = x(18 : 17 + Nsyl, 1);
	ww0 = -1*ones(Nsyl,1);
	
	% dynamics
	w0tr = y2(8); % gamma reset / internal timing
    % w0tr = 0; % no reset
	dw = - w0tr*power(w-ww0,1); 

	Tr = explicit_onsets; % ideal onset detection case
	
    % d_speed = 0; % no preferred rate - no theta-gamma coupling
	d_speed = (1-speed); % preferred fixed rate - endogenous theta-gamma coupling
    % d_speed = (th_speed-speed); % theta driven rate - exogenous theta-gamma coupling

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

	dx(18 : 17 + Nsyl,1) = dw;

end

