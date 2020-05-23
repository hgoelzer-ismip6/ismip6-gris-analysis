% load ISMIP6 results in a structure per exp

clear

load lithk_A5

ares = '05';
step = 1;

% Path to archive
datapath=(['../../ismip6-gris-results-processing/Archive_2d/Data']);

% labs names/ models list
load set_default.mat

%% labs names/ models list
%igrp = {'AWI','AWI','AWI','BGC','GSFC','ILTS_PIK','ILTS_PIK','IMAU','IMAU','JPL','JPL','LSCE','UCIJPL'}
%imod = {'ISSM1','ISSM2','ISSM3','BISICLES','ISSM','SICOPOLIS2','SICOPOLIS3','IMAUICE1','IMAUICE2','ISSM','ISSMPALEO','GRISLI','ISSM1'};
%igrpmod={};
%for i=1:length(igrp)
%    igrpmod{i}=[igrp{i},'-' , imod{i}];
%end

vars={'lithk','orog','topg','sftgif','sftgrf','sftflf'};

%aexps = {'exp05'};
%aexps = {'ctrl_proj}'
exps = {'ctrl_proj', 'exp05'};

% Load model data
li.igrp=strrep(igrp,'_','');
li.imod=imod;
li.igrpmod=strrep(igrpmod,'_','');
li.n=length(igrp);

% all
for m=1:li.n;
% update some
%for m=[11];
%for m=[18,19];
%for m=[22,23];

    for n=1:length(exps);

    % aexp
    for k=1:length(vars);
        ncfile=[datapath,'/',igrp{m},'/',imod{m},'/' exps{n} '_' ares '/', 'dd_', vars{k}, '_2100' '_GIS_', igrp{m},'_',imod{m},'_', exps{n}, '.nc'];
        % check file exists
        if exist(ncfile, 'file') == 2
            ncfile
            in=ncload(ncfile);
            eval(['li.' exps{n} '{m}.', 'dd_', vars{k},'=single(in.',vars{k},'(:,:));']);
        else
            %eval(['li.' exps{n} '{m}.', 'dd_', vars{k},'=single(zeros(337,577));']);
            eval(['li.' exps{n} '{m}.', 'dd_', vars{k},'=[];']);
        end
    end

    end

end

save lithk_A5 li

