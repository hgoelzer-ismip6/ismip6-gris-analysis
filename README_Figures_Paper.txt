% Figures for paper ISMIP6-Greenland
Goelzer, H., Nowicki, S., Payne, A., Larour, E., Seroussi, H., Lipscomb, W. H., Gregory, J., Abe-Ouchi, A., Shepherd, A., Simon, E., Agosta, C., Alexander, P., Aschwanden, A., Barthel, A., Calov, R., Chambers, C., Choi, Y., Cuzzone, J., Dumas, C., Edwards, T., Felikson, D., Fettweis, X., Golledge, N. R., Greve, R., Humbert, A., Huybrechts, P., Le clec'h, S., Lee, V., Leguy, G., Little, C., Lowry, D. P., Morlighem, M., Nias, I., Quiquet, A., Rückamp, M., Schlegel, N.-J., Slater, D., Smith, R., Straneo, F., Tarasov, L., van de Wal, R., and van den Broeke, M.: The future sea-level contribution of the Greenland ice sheet: a multi-model ensemble study of ISMIP6, The Cryosphere Discuss., https://doi.org/10.5194/tc-2019-319, in review, 2020.

% Define ensemble
define_set
--> set_default.mat

% 2D data
load_data_lithk_A5
load_data_d_lithk_A5
load_data_dd_lithk_A5
load_data_i_lithk_A5
--> lithk_A5.mat

% scalars
load_data_resc_A5
load_data_resc_basinR_A5
--> resc_A5.mat
--> resc_basinR_A5.mat
%load_data_rescGIC0_basinR_A5
% Extensions
load_data_resc_A5_ext
load_data_resc_basinR_A5_ext
--> resc_A5_ext.mat
--> resc_basinR_A5_ext.mat

% SL numbers
load_data_numcr_A5
load_data_numcr_basinR_A5
--> numcr_A5.mat
--> numcr_basinR_A5.mat
% Extensions
load_data_numcr_A5_ext
load_data_numcr_basinR_A5_ext
--> numcr_A5_ext.mat
--> numcr_basinR_A5_ext.mat

% Extract Diag
A5_Diag_fi_obs1

% Numbers for uncertainty part
A5_stats_ext


%%%%%%%%%% Or all in one
update_Archive.m





% F01, V30
% time series forcing
meta_plot_forcing_aSMB_paper.m
--> SMB_anomaly_all_paper.png
% smb anomly
A5_shade_asmb.m
--> A5_shade_asmb_exp05.png
% ocean forcing
Donald/retreatplot
-->retreat_GrIS_wide.png
% Combine  


% F02, V30
% Shade ice mask
% Also extracts common model mask mimn_A5.mat
A5_fi_icemasks.m
--> A5_fi_init_mimm_inset.png, A5_fi_init_mimm.png


% F03, V30
% Scatter area/vol
(A5_Diag_fi_obs1.m)
A5_plot_fi_area_vol.m
--> A5_fi_diag_area_vol.png


% F04, V30
% Plot historical ice mass
A5_plot_resc_lim_hist.m
--> A5_resc_lim_hist_ctrl_proj.png


% F05, V30
% Plot error bars
A5_bar_fi_lithk.m
--> A5_bar_fi_diag_lithk_ssm.png
A5_bar_fi_vel.m
--> A5_bar_fi_diag_velsurf_ssm.png
A5_bar_fi_logvel.m
--> A5_bar_fi_diag_logvelsurf_ssm.png
A5_bar_ff_dvol_a.m
--> A5_bar_ff_diag_dvol_a.png

% F06, V30
% Shade dd thickness change 
A5_ff_dd_lithk.m
--> A5_ff_exp05_dd_lithk_mean_21.png, A5_ff_exp05_dd_lithk_std_21.png


% F07, V30
% Plot sea-level projection
A5_plot_resc_dsl.m
--> A5_resc_sl_exp05.png
A5_plot_resc_dsl_mean_bars.m
--> A5_resc_dsl_mean_bars.png
A5_plot_resc_dsl_mean_bars_ext.m
--> A5_resc_dsl_mean_bars_ext.png

% F08, V30
% ensemble statistics
A5_box_resc_mean_dsl_basinR_comp.m
--> A5_box_resc_mean_dsl_basinR_comp.png

% f09, V30
% ocean sens
A5_bar_resc_mean_dsl_basinR_osens.m
--> A5_bar_resc_mean_dsl_basinR_osens.png

% F10, V30
% Attribution 
./Attribution
% [Attribution/attrib_plot_msk.m]
% Attribution/attrib_plot_smb.m
% Attribution/attrib_plot_ogr.m
% Attribution/attrib_plot_sle.m

--> attribution.png

% F11, V30
% dynamic residual
A5_ff_dyncon.m
--> A5_shade_dyncon_mean_exp05.png, A5_shade_dyncon_std_exp05.png

% F12, V30
% Summary
A5_dot_numcr_dsl_ext.m
--> A5_dot_numcr_dsl_extall.png


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Supplement

% S01, V30
% Bars basin 
A5_bar_resc_dsl_basinR.m
--> A5_bar_resc_dsl_basinR_exp05.png
+ Manual basin inset Preview copy-paste


% S02-S09, V30
% Atlas shade vars={'acabf','lithk','orog','velmean','sftgif','sftgrf','topg'};
A5_Atlas_fi.m
--> A5_historical_acabf_AWI-ISSM1.png
--> A5_historical_orog_AWI-ISSM1.png
--> A5_historical_velmean_AWI-ISSM1.png

A5_Atlas_ff.m
aexp = 'exp05';
vars = {'d_lithk','d_topg','dd_lithk','iacabf','dyncon'};
%aexp = 'ctrl_proj';
%vars = {'d_lithk','d_topg'};

--> A5_exp05_dd_lithk_AWI-ISSM1.png
--> A5_exp05_dyncon_AWI-ISSM1.png
--> A5_ctrl_proj_d_lithk_AWI-ISSM1.png
--> A5_exp05_iacabf_AWI-ISSM1.png

+ move to subfolder
+ PS ContactSheet


%%%%%%%%%%%%%%%%%%% Numbers

A5_stats_ext

%% first 3 columns in table 5
load diag_fi_A5.mat
% area
[diag.area{:}]'
% vol
[diag.vol{:}]'

% SLE ctrl_proj
load resc_A5.mat
res_ctr= zeros(1,22);
for i=1:22; res_ctr(i) = ((resc.ctrl_proj{i}.sle(end)-resc.ctrl_proj{i}.sle(1))*-1000); end
res_ctr'
 
% SLE
load numcr_A5.mat
numcr.exp05'*-1000


A5_plot_resc_dsl_rate.m
The average rate of change across the ensemble is 0.9 mm yr-1 and 2.4 mm yr-1 over the period 2051-2060 and 2091-2100, respectively.


% Imbie rates
A5_plot_obs_IMBIE.m
% Mouginot rates for observed SL rate 0.4 - 0.8 mm
A5_plot_obs.m


% ctrl_proj range
res_ctr= zeros(1,21);
res_e05= zeros(1,21);
for i=1:21; res_e05(i)=(resc.exp05{i}.sle(end)-resc.exp05{i}.sle(1))*-1000; end
for i=1:21; res_ctr(i)=(resc.ctrl_proj{i}.sle(end)-resc.ctrl_proj{i}.sle(1))*-1000; end
minmax(res_ctr)
minmax(res_e05)

