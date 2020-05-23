% load ISMIP6 results in a structure per exp
% ctrl_proj corrected 2100 sle result

clear

%load numcr_basinR_A5

% Path to archive
%datapath = '../Archive_05';
datapath = '/Volumes/ISMIP6/ismip6-gris-results-processing/Archive_sc/Data/SC_GIC1_OBS0';

% labs names/ models list
load set_default.mat

%igrp = {'AWI','AWI','AWI','BGC','GSFC','ILTS_PIK','ILTS_PIK','IMAU','IMAU','JPL','JPL','LSCE','UCIJPL'}
%imod = {'ISSM1','ISSM2','ISSM3','BISICLES','ISSM','SICOPOLIS2','SICOPOLIS3','IMAUICE1','IMAUICE2','ISSM','ISSMPALEO','GRISLI','ISSM1'};
%igrpmod = {};
%for i=1:length(igrp)
%    igrpmod{i}=[igrp{i},'-' , imod{i}];
%end

vars = {'sle'};

exps = {'ctrl_proj', 'exp05', 'exp06', 'exp07', 'exp08', 'exp09', 'exp10'};

regs = {'no', 'ne', 'se', 'sw', 'cw', 'nw'};

% Load model data
numcr_bas.igrp=strrep(igrp,'_','');
numcr_bas.imod=imod;
numcr_bas.igrpmod=strrep(igrpmod,'_','');
numcr_bas.n=length(igrp);

% all
for m=1:numcr_bas.n;
% update some
%for m=[1];

    numcr_bas.igrpmod(m)

    for n=1:length(exps);
        % exps
        ncfile=[datapath, '/', igrp{m}, '/', imod{m}, '/', exps{n}, '_05', '/scalars_rm_cr_GIS_', igrp{m},'_',imod{m},'_', exps{n}, '.nc'];
        % check file exists
        ncfile
        if exist(ncfile, 'file') == 2
            % read scalar
            in=ncload(ncfile);
            for k=1:length(vars);
                test = eval(['isfield(in,''' vars{k}, '_', regs{1} ''')']);
                if test 
                    for r = 1:length(regs)
                        eval(['numcr_bas.' exps{n} '(m,r)','=single(in.',vars{k}, '_', regs{r},'(end))-single(in.',vars{k}, '_', regs{r},'(1));']);
                    end
                else
                    [vars{k} '  not found in ncfile']
                    eval(['numcr_bas.' exps{n} '(m,:)','= nan;']);
                end
            end % var loop    
        else
            % place dummy instead
            eval(['numcr_bas.' exps{n} '(m,:)','= nan;']);
        end

    end % exp loop
end % model loop

save numcr_basinR_A5 numcr_bas
