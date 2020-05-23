% load ISMIP6 results in a structure per exp
% ctrl_proj corrected 2100 sle result

clear

%load numcr_A5_ext

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

vars = {'sle'};

%exps = {'ctrl_proj', 'exp05', 'exp06', 'exp07', 'exp08', 'exp09', 'exp10'};
exps = {'ctrl_proj', 'exp05', 'exp06', 'exp07', 'exp08', 'exp09', 'exp10', 'expa01', 'expa02', 'expa03', 'expb01', 'expb02', 'expb03', 'expb04', 'expb05'};

% Load model data
numcr.igrp=strrep(igrp,'_','');
numcr.imod=imod;
numcr.igrpmod=strrep(igrpmod,'_','');
numcr.n=length(igrp);

% all
for m=1:numcr.n;
% update some
%for m=[1];

    numcr.igrpmod(m)

    for n=1:length(exps);
        % exps
        
        ncfile=[datapath, '/', igrp{m}, '/', imod{m}, '/', exps{n}, '_05', '/scalars_mm_cr_GIS_', igrp{m},'_',imod{m},'_', exps{n}, '.nc'];
        % check file exists
        ncfile
        if exist(ncfile, 'file') == 2
            % read scalar
            in=ncload(ncfile);
            for k=1:length(vars);
                test = eval(['isfield(in,''' vars{k} ''')']);
                if test 
                    eval(['numcr.' exps{n} '(m)','=single(in.',vars{k},'(end))-single(in.',vars{k},'(1));']);
                else
                    [vars{k} '  not found in ncfile']
                end
            end % var loop    
        else
            % place dummy instead
            eval(['numcr.' exps{n} '(m)','= nan;']);
        end
        
    end % exp loop
end % model loop

save numcr_A5_ext numcr

