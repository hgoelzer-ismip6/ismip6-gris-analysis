% Update the entire archive (5 min)

clear

tic
% Define ensemble
define_set
define_set_ext

% 2D data
load_data_lithk_A5
load_data_d_lithk_A5
load_data_dd_lithk_A5
load_data_i_lithk_A5

% scalars
load_data_resc_A5
load_data_resc_basinR_A5

%load_data_rescGIC0_basinR_A5
% Extensions
load_data_resc_A5_ext
load_data_resc_basinR_A5_ext

% SL numbers
load_data_numcr_A5
load_data_numcr_basinR_A5

% Extensions
load_data_numcr_A5_ext
load_data_numcr_basinR_A5_ext

% Extract Diag
A5_Diag_fi_obs1

% Numbers for uncertainty part
A5_stats_ext
toc
