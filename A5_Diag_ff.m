% make dignostics for ISMIP6 results

clear

% load diagnostics if update
%load diag_ff_A5

% load model data
load lithk_A5

%% area factors
d2=ncload('../Data/af2_ISMIP6_GrIS_05000m.nc'); % 
af2 = double(d2.af2);

% load observations BM3
obs1=ncload('../Data/BM3_GrIS_nn_e05000m.nc'); % 
%obs1.msk1=(obs1.lithk>1.5);
obs1.msk1=double(obs1.sftgrf);
obs1.lithk=double(obs1.lithk);
obs1.orog=double(obs1.orog);

dz=ncload('../Data/ZMask_e05000m.nc'); % 
% nan zmask (zmask same in obs1 and obs2)
zmn=double(dz.mask);
obs1.zmn=zmn;

% largest common ensemble nan mask mimn
load mimn_A5.mat

% maxmask
dmm=ncload('../Data/maxmask1_05000m.nc'); % 
maxmask1 = dmm.maxmask1;

% unit conversion
spy=31556926;

% Load model data
diag_ff.igrp=li.igrp;
diag_ff.imod=li.imod;
diag_ff.igrpmod=li.igrpmod;
diag_ff.n=li.n;

% elevation classes
upper=[500:500:3500];
lower=upper-500;
lc=length(upper);

%%%%%% Model loop

%for m=1:li.n
%
for m=1:li.n-4
%
%for m=1

%%%%%%%%%% General per model 

% own nan ice mask
%iman=double(li.historical{m}.lithk>1.0);
iman = double(li.historical{m}.sftgrf);
iman(iman==0)=NaN;

%%%%%%%%%%%%%%%


% Total ice volume change in ctrl_proj
dmod1 = double(li.historical{m}.lithk).*double(maxmask1).*af2*25000000;
dmodend = double(li.ctrl_proj{m}.lithk).*double(maxmask1).*af2*25000000;

ddat=dmodend-dmod1;
diag_ff.dvol{m}=nansum(nansum((ddat)));;
diag_ff.dvol_a{m}=nansum(nansum(abs(ddat)));

% Total ice area change in ctrl_proj
dmod1 = double(li.historical{m}.sftgif).*double(maxmask1).*af2*25000000;
dmodend = double(li.ctrl_proj{m}.sftgif).*double(maxmask1).*af2*25000000;

ddat=dmodend-dmod1;
diag_ff.darea{m}=nansum(nansum((ddat)));;
diag_ff.darea_a{m}=nansum(nansum(abs(ddat)));


end
% end model loop

save diag_ff_A5 diag_ff;

% 
%end
