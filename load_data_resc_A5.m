% load ISMIP6 results in a structure per exp

clear

%load resc_A5

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

vars = {'sle','limaf','lim','smb','iarea'};

%exps = {'historical', 'ctrl_proj', 'exp05'};
exps = {'historical', 'ctrl_proj', 'exp05', 'exp06', 'exp07', 'exp08', 'exp09', 'exp10'};


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

    for n=1:length(exps);
        % exps
        
        %../Archive_05/AWI/ISSM1/hist_05/rescalars_GIS_AWI_ISSM1_hist.nc
        ncfile=[datapath, '/', igrp{m}, '/', imod{m}, '/', exps{n}, '_05', '/scalars_mm_GIS_', igrp{m},'_',imod{m},'_', exps{n}, '.nc'];
        % check file exists
        ncfile
        if exist(ncfile, 'file') == 2
            % read scalar
            in=ncload(ncfile);
            for k=1:length(vars);
                test = eval(['isfield(in,''' vars{k} ''')']);
                if test 
                    %                ['resc.' exps{n} '{m}.',vars{k},'=single(in.',vars{k},'(:));']
                    eval(['resc.' exps{n} '{m}.',vars{k},'=single(in.',vars{k},'(:));']);
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

save resc_A5 resc

