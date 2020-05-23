% load ISMIP6 results in a structure per exp

clear

%load sc_A5
% 

% Path to archive
%datapath = '../Archive_05';
datapath = '/Volumes/ISMIP6/ismip6-gris-results-processing/Archive_sc/Data/SC_GIC1_OBS0';

% labs names/ models list
load set_default_ext.mat

%igrp = {'AWI','AWI','AWI','BGC','GSFC','ILTS_PIK','ILTS_PIK','IMAU','IMAU','JPL','JPL','LSCE','UCIJPL'}
%imod = {'ISSM1','ISSM2','ISSM3','BISICLES','ISSM','SICOPOLIS2','SICOPOLIS3','IMAUICE1','IMAUICE2','ISSM','ISSMPALEO','GRISLI','ISSM1'};
%igrpmod = {};
%for i=1:length(igrp)
%    igrpmod{i}=[igrp{i},'-' , imod{i}];
%end

vars = {'sle','smb'};

%exps = {'historical', 'ctrl_proj', 'exp05'};
%exps = {'historical', 'ctrl_proj', 'exp05', 'exp06', 'exp07', 'exp08', 'exp09', 'exp10'};
exps = {'historical', 'ctrl_proj', 'exp05', 'exp06', 'exp07', 'exp08', 'exp09', 'exp10', 'expa01', 'expa02', 'expa03', 'expb01', 'expb02', 'expb03', 'expb04', 'expb05'};

regs = {'no', 'ne', 'se', 'sw', 'cw', 'nw'};

% Load model data
resc.igrp=strrep(igrp,'_','');
resc.imod=imod;
resc.igrpmod=strrep(igrpmod,'_','');
resc.n=length(igrp);

% all
for m=1:resc.n;
% update some
%for m=[1];

    resc.igrpmod(m)

    for n = 1:length(exps);
        
        % exps
        %../Archive_05/AWI/ISSM1/hist_05/rescalars_GIS_AWI_ISSM1_hist.nc
        ncfile=[datapath, '/', igrp{m}, '/', imod{m}, '/', exps{n}, '_05', '/scalars_rm_GIS_', igrp{m},'_',imod{m},'_', exps{n}, '.nc'];
        % check file exists
        ncfile
        if exist(ncfile, 'file') == 2
            in=ncload(ncfile);
            for k = 1:length(vars);
                test = eval(['isfield(in,''' vars{k}, '_', regs{1} ''')']);
                if test 
                    % read scalar
                    %                ['resc.' exps{n} '{m}.',vars{k},'=single(in.',vars{k},'(:));']
                    reclen = length(in.time);
                    eval([vars{k} ' = zeros(length(regs),reclen);']);
                    for r = 1:length(regs)
                        eval([vars{k} '(r,:) = single(in.',vars{k}, '_', regs{r}, '(1:reclen));']);
                        eval(['resc.' exps{n} '{m}.', vars{k}, ' = ' vars{k} ';']);
                    end
                else
                    [vars{k} '  not found in ncfile']
                end
            end % var loop    
        end
        
        % grab time
        %['resc.' exps{n} '{m}.time = in.time'];
        %eval(['resc.' exps{n} '{m}.time = in.time;']);

    end % exp loop
end % model loop

save resc_basinR_A5_ext resc

