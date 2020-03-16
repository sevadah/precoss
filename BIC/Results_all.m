%% free energy as log evidence
% meaning the bigger the better

% load('freeEnergy.mat');
% ss = sum(freeEnergy);
% 
% % all
% % figure; bar(ss)
% % xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% % xlabel('Model Varaint')
% % ylablel('cumulative free energy')
% % ylabel('cumulative free energy')
% 
% 
% % partial - theta vs removed
% 
% ss = sum(freeEnergy)
% ss(2) = ss(7)
% ss(4) = ss(8)
% ss(6) = ss(9)
% ss(7 : 9) = []
% figure; bar(ss)
% xticklabels({'A', 'Brm', 'C', 'Drm', 'E', 'Frm'})
% xlabel('Model Varaint')
% ylabel('cumulative free energy')

%% log-evidence (if this is what we calculated)

load('log_evid_all_corr.mat')
% ss = sum(log_evid_all(11:end,:))

% % all
% figure; bar(ss)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% ylim([-9000 -5700])
% xlabel('Model Varaint')
% ylabel('log evidence')
% 
% % partial - reduced vs siwtched off
% 
% ss = sum(log_evid_all)
% ss([1 3 5]) = ss(7 : 9)
% ss(7 : 9) = []
% figure; bar(ss)
% xticklabels({'Brm', 'B', 'Drm', 'D', 'Frm', 'F'})
% ylim([-9000 -6000])
% xlabel('Model Varaint')
% ylabel('log evidence')
% 
% partial 

% ss = sum(log_evid_all)
% ss([2 4 6]) = ss(7 : 9)
% ss(7 : 9) = []
% figure; bar(ss)
% % xticklabels({'A', 'Brm', 'C', 'Drm', 'E', 'Frm'})
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F'})
% ylim([-9000 -5700])
% xlabel('model varaint')
% ylabel('cumulative log evidence')

%% max-log-likelihood (if this is what we calcualted)

% % based on sum
% load('log_evid_all_corr.mat')
% ss = sum(log_evid_all)
% 
% 
% % number of parameters without syllable units
% p_base = [26 + 3, 26+1, 26+2, ...
%     26+1, 26+1, 26, ...
%     23+1, 23+1, 23];
% 
% Ns = 13;
% ds = 182;
% 
% AIC = ss - (p_base + Ns);
% BIC = ss - 0.5*(p_base + Ns)*log(Ns*ds);
% 
% figure; title('AIC - based on sum log likelihood')
% bar(AIC)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% ylim([-9000 -5700])
% xlabel('Model Varaint')
% ylabel('AIC')
% 
% figure; title('BIC - based on sum log likelihood')
% bar(BIC)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% ylim([-9000 -5700])
% xlabel('Model Varaint')
% ylabel('BIC')

% based on mean

% load('log_evid_all_corr.mat')
% 
% ss = mean(log_evid_all)
% 
% % number of parameters without syllable units
% p_base = [26 + 3, 26+1, 26+2, ...
%     26+1, 26+1, 26, ...
%     23+1, 23+1, 23];
% 
% Ns = 13;
% ds = 182;
% 
% AIC = ss - (p_base + Ns);
% BIC = ss - 0.5*(p_base + Ns)*log(Ns*ds);
% 
% figure; title('AIC - based on sum log likelihood')
% bar(AIC)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% xlabel('Model Varaint')
% ylabel('AIC')
% 
% figure; title('BIC - based on sum log likelihood')
% bar(BIC)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% xlabel('Model Varaint')
% ylabel('BIC')


%% AIC -
% % when what we have calculated is the log likelihood
% % and AIC and BIC values were calculated per sentences basis
% 
% load('aic_all_mat_corr.mat')
% AIC = sum(aic_all_mat)
% 
% figure; 
% bar(AIC)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% xlabel('Model Varaint')
% ylabel('AIC')
% ylim([-18000 -14000])

%% BIC

% load('bic_all_mat_corr.mat')
% BIC = sum(bic_all_mat)
% 
% figure; 
% bar(BIC)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% xlabel('Model Varaint')
% ylabel('BIC')
% ylim([-45000 -38000])

%% BIC - based on log evidence likelihood


% load('log_evid_all_corr.mat')
% 
% ss = mean(log_evid_all)
% 
% % number of parameters without syllable units
% p_base = [26 + 3, 26+1, 26+2, ...
%     26+1, 26+1, 26, ...
%     23+1, 23+1, 23];
% 
% Ns = 13;
% % ds = 182;
% D = 220;
% 
% % AIC = ss - (p_base + Ns);
% BIC = ss - 0.5*(p_base + Ns)*log(D);
% 
% 
% figure; title('BIC - based on sum log likelihood')
% bar(BIC)
% xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'Brm', 'Drm', 'Frm'})
% xlabel('Model Varaint')
% ylabel('BIC')


