% ISMIP6 result stats

clear

load numcr_A5_ext

% characteristics
index      = 1: numcr.n;
m_std      = [1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 1 0 0 0 0 0];
m_opn      = [0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0];
m_noi      = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1];
m_ocs      = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 1 0 0 0 0 0];

m_mod = m_std+m_opn; % = ~(m_noi)

% general mask to consider models
m_mask     = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

% select models
%ms = 1:(numcr.n-4);
sel_all = index(find(m_mask==1));
sel_mod = index(find((m_mask.*m_mod)==1));
sel_std = index(find((m_mask.*m_std)==1));
sel_opn = index(find((m_mask.*m_opn)==1));
sel_noi = index(find((m_mask.*m_noi)==1));
sel_ocs = index(find((m_mask.*m_ocs)==1));

%DS: In terms of providing a headline number in the abstract (i.e. RCP8.5 SLR is X cm +/- dX), how do we get X and dX? I guess just by the mean of all projections across all ice sheet models and the 3 core forcings? And then dX is 2 standard deviations? This would account for both ice sheet model uncertainty and forcing uncertainty (although the latter only from 3 CMIP models).
%TE: I would give the ensemble mean and 2 s.d. range. I would average over all of them and then just be clear in the text / a nearby table what you are averaging over.

% Params
scl = 1000; % m to mm 

% All 5 RCP8.5
ens = [numcr.exp05(sel_mod), numcr.exp06(sel_mod), numcr.exp08(sel_mod), numcr.exp09(sel_mod), numcr.exp10(sel_mod), numcr.expa01(sel_mod), numcr.expa02(sel_mod), numcr.expa03(sel_mod)];
ens_m = -nanmean(ens)*scl;
ens_s = nanstd(ens)*scl;
ens_n = sum(isfinite(ens));

% GCM spread
ens_gcm = [numcr.exp05(sel_mod), numcr.exp06(sel_mod), numcr.exp08(sel_mod), numcr.expa01(sel_mod), numcr.expa02(sel_mod), numcr.expa03(sel_mod)];
ens_gcm_m = -nanmean(ens_gcm)*scl;
ens_gcm_s = nanstd(ens_gcm)*scl;
ens_gcm_n = sum(isfinite(ens_gcm));
% ocean spread
ens_ogr = [numcr.exp05(sel_mod), numcr.exp09(sel_mod), numcr.exp10(sel_mod)];
ens_ogr_m = -nanmean(ens_ogr)*scl;
ens_ogr_s = nanstd(ens_ogr)*scl;
ens_ogr_n = sum(isfinite(ens_ogr));

% exp means
exp05_m = double(-nanmean(numcr.exp05(sel_mod))*scl);
exp06_m = double(-nanmean(numcr.exp06(sel_mod))*scl);
exp07_m = double(-nanmean(numcr.exp07(sel_mod))*scl); % rcp26
exp08_m = double(-nanmean(numcr.exp08(sel_mod))*scl);
exp09_m = double(-nanmean(numcr.exp09(sel_mod))*scl);
exp10_m = double(-nanmean(numcr.exp10(sel_mod))*scl);
expa01_m= double(-nanmean(numcr.expa01(sel_mod))*scl);
expa02_m= double(-nanmean(numcr.expa02(sel_mod))*scl);
expa03_m= double(-nanmean(numcr.expa03(sel_mod))*scl);

exp05_s = double(nanstd(numcr.exp05(sel_mod))*scl);
exp06_s = double(nanstd(numcr.exp06(sel_mod))*scl);
exp07_s = double(nanstd(numcr.exp07(sel_mod))*scl); % rcp26
exp08_s = double(nanstd(numcr.exp08(sel_mod))*scl);
exp09_s = double(nanstd(numcr.exp09(sel_mod))*scl);
exp10_s = double(nanstd(numcr.exp10(sel_mod))*scl);
expa01_s= double(nanstd(numcr.expa01(sel_mod))*scl);
expa02_s= double(nanstd(numcr.expa02(sel_mod))*scl);
expa03_s= double(nanstd(numcr.expa03(sel_mod))*scl);

exp05_n = sum(isfinite(numcr.exp05(sel_mod)));
exp06_n = sum(isfinite(numcr.exp06(sel_mod)));
exp07_n = sum(isfinite(numcr.exp07(sel_mod)));
exp08_n = sum(isfinite(numcr.exp08(sel_mod)));
exp09_n = sum(isfinite(numcr.exp09(sel_mod)));
exp10_n = sum(isfinite(numcr.exp10(sel_mod)));
expa01_n= sum(isfinite(numcr.expa01(sel_mod)));
expa02_n= sum(isfinite(numcr.expa02(sel_mod)));
expa03_n= sum(isfinite(numcr.expa03(sel_mod)));

minMIROC85 = min(numcr.exp05(1:21)'*-1000);
maxMIROC85 = max(numcr.exp05(1:21)'*-1000);

% All RCP85
disp(['- For RCP8.5 the ensemble mean +- 2 s.d. (' num2str(ens_n) ' ensemble members) sea-level contribution is ' num2str(round(ens_m,0)) ' +- ' num2str(round(2*ens_s,0)) ' mm !'])
disp(' ')

% All RCPs6
disp(['- For RCP2.6 the ISM ensemble mean +- 2 s.d. (' num2str(exp07_n) ' ensemble members) sea-level contribution is ' num2str(round(exp07_m,0)) ' +- ' num2str(round(2*exp07_s,0)) ' mm !'])



disp(['- The [mean, 2*s.d., N, sd/mean] for the experiments:'])
disp('core, ext: 05,06,07,08,09,10,  a01,a02,a03')

disp([round(exp05_m), round(2*exp05_s), exp05_n, round(exp05_s/exp05_m*100,0)])
disp([round(exp06_m), round(2*exp06_s), exp06_n, round(exp06_s/exp06_m*100,0)])
disp([round(exp07_m), round(2*exp07_s), exp07_n, round(exp07_s/exp07_m*100,0)])
disp([round(exp08_m), round(2*exp08_s), exp08_n, round(exp08_s/exp08_m*100,0)])
disp([round(exp09_m), round(2*exp09_s), exp09_n, round(exp09_s/exp09_m*100,0)])
disp([round(exp10_m), round(2*exp10_s), exp10_n, round(exp10_s/exp10_m*100,0)])
disp([round(expa01_m), round(2*expa01_s), expa01_n, round(expa01_s/expa01_m*100,0)])
disp([round(expa02_m), round(2*expa02_s), expa02_n, round(expa02_s/expa02_m*100,0)])
disp([round(expa03_m), round(2*expa03_s), expa03_n, round(expa03_s/expa03_m*100,0)])

disp('### min,max MIROC5 RCP8.5')
disp([round(minMIROC85), round(maxMIROC85)])

disp('### RCP8.5: 05,06,08,09,10,  a01,a02,a03')
disp([round(ens_m), round(2*ens_s), ens_n, round(ens_s/ens_m*100,0)])

disp('### RCP2.6: 07')
disp([round(exp07_m), round(2*exp07_s), exp07_n, round(exp07_s/exp07_m*100,0)])

disp('### GCM: 05,06,08,a01,a02,a03')

disp([round(ens_gcm_m), round(2*ens_gcm_s), ens_gcm_n, round(ens_gcm_s/ens_gcm_m*100,0)])

disp('### Ocean: 05,09,10')
disp([round(ens_ogr_m), round(2*ens_ogr_s), ens_ogr_n, round(ens_ogr_s/ens_ogr_m*100,0)])

%•	(s.d./mean) as a % for all results for (a) –> approx. variation due to ISM 
%	ditto for (abc) – due to GCM
%	ditto for (aef) – due to melt



%disp(['- For RCP8.5 the SLR uncertainty from forcing of 3 GCMs is ' num2str(round(gcm_s,0)) ' mm compared to ' num2str(round(ism_s,0)) ' mm from the ice sheet models and to ' num2str(round(ogr_s,0)) ' mm from ocean forcing! '])
%

%%% GCM mean spread
disp('### [GCM mean spread]')
gcm_min = min([exp05_m exp06_m exp08_m expa01_m expa02_m expa03_m ]);
gcm_max = max([exp05_m exp06_m exp08_m expa01_m expa02_m expa03_m ]);
disp([gcm_min,gcm_max,gcm_max-gcm_min])

disp('### GCM mean 2sigma')
disp(2*std([exp05_m exp06_m exp08_m expa01_m expa02_m expa03_m ]));

%%% Ocean sens
disp('### ocean sens spread')
osens  = (nanmean(numcr.exp09(sel_mod))*-scl) - (nanmean(numcr.exp10(sel_mod))*-scl);
disp([nanmean(numcr.exp09(sel_mod))*-scl, nanmean(numcr.exp10(sel_mod))*-scl, osens, sum(isfinite(numcr.exp09(sel_mod)))])
disp('### [ocean sens 2sigma]')
disp(2*std([exp05_m exp09_m exp10_m]));

disp('### ocean sens totals')
disp([nanmean(numcr.exp10(sel_mod))*-scl, nanmean(numcr.exp05(sel_mod))*-scl, nanmean(numcr.exp09(sel_mod))*-scl, sum(isfinite(numcr.exp09(sel_mod)))])


%[mean(numcr.exp09(sel_ocs))*-scl, mean(numcr.exp10(sel_ocs))*-scl]
%osens  = (mean(numcr.exp09(sel_ocs))*-scl) - (mean(numcr.exp10(sel_ocs))*-scl)

%%%% open vs standard
disp('### ensemble open vs standard:')
disp([nanmean(numcr.exp05(sel_opn))*-scl, nanmean(numcr.exp05(sel_std))*-scl, -nanmean(numcr.exp05(sel_opn))*-scl+nanmean(numcr.exp05(sel_std))*-scl])
disp([nanmean(numcr.exp06(sel_opn))*-scl, nanmean(numcr.exp06(sel_std))*-scl, -nanmean(numcr.exp06(sel_opn))*-scl+nanmean(numcr.exp06(sel_std))*-scl])
disp([nanmean(numcr.exp08(sel_opn))*-scl, nanmean(numcr.exp08(sel_std))*-scl, -nanmean(numcr.exp08(sel_opn))*-scl+nanmean(numcr.exp08(sel_std))*-scl])

disp([nanmean(numcr.expa01(sel_opn))*-scl, nanmean(numcr.expa01(sel_std))*-scl, -nanmean(numcr.expa01(sel_opn))*-scl+nanmean(numcr.expa01(sel_std))*-scl])
disp([nanmean(numcr.expa02(sel_opn))*-scl, nanmean(numcr.expa02(sel_std))*-scl, -nanmean(numcr.expa02(sel_opn))*-scl+nanmean(numcr.expa02(sel_std))*-scl])
disp([nanmean(numcr.expa03(sel_opn))*-scl, nanmean(numcr.expa03(sel_std))*-scl, -nanmean(numcr.expa03(sel_opn))*-scl+nanmean(numcr.expa03(sel_std))*-scl])


disp('### PISM open vs standard:')
disp([numcr.exp05(17)*-scl, numcr.exp05(16)*-scl, -numcr.exp05(17)*-scl+numcr.exp05(16)*-scl])
disp([numcr.exp06(17)*-scl, numcr.exp06(16)*-scl, -numcr.exp06(17)*-scl+numcr.exp06(16)*-scl])
disp([numcr.exp08(17)*-scl, numcr.exp08(16)*-scl, -numcr.exp08(17)*-scl+numcr.exp08(16)*-scl])

disp([numcr.expa01(17)*-scl, numcr.expa01(16)*-scl, -numcr.expa01(17)*-scl+numcr.expa01(16)*-scl])
disp([numcr.expa02(17)*-scl, numcr.expa02(16)*-scl, -numcr.expa02(17)*-scl+numcr.expa02(16)*-scl])
disp('### ISSM open vs standard:')
disp([numcr.exp05(19)*-scl, numcr.exp05(18)*-scl, -numcr.exp05(19)*-scl+numcr.exp05(18)*-scl])


disp('### average ensemble open vs standard:')
disp(mean([-nanmean(numcr.exp05(sel_opn))*-scl+nanmean(numcr.exp05(sel_std))*-scl, -nanmean(numcr.exp06(sel_opn))*-scl+nanmean(numcr.exp06(sel_std))*-scl, -nanmean(numcr.exp08(sel_opn))*-scl+nanmean(numcr.exp08(sel_std))*-scl, -nanmean(numcr.expa01(sel_opn))*-scl+nanmean(numcr.expa01(sel_std))*-scl, -nanmean(numcr.expa02(sel_opn))*-scl+nanmean(numcr.expa02(sel_std))*-scl, -nanmean(numcr.expa03(sel_opn))*-scl+nanmean(numcr.expa03(sel_std))*-scl ]))

