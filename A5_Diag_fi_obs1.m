% make dignostics for ISMIP6 results

clear

% load diagnostics if update
%load diag_fi_A5

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

% Velocity
dv=ncload('../Data/greenland_vel_mosaic_velsur_v1_nn_e05000m.nc'); % 
obs1.velsurf = dv.velsurf;

% Brice
abl=ncload('../Data/abl_obs_e05000m.nc');
acc=ncload('../Data/acc_obs_e05000m.nc');

% largest common ensemble nan mask mimn
load mimn_A5.mat

% maxmask
dmm=ncload('../Data/maxmask1_05000m.nc'); % 

% unit conversion
spy=31556926;

% Load model data
diag.igrp=li.igrp;
diag.imod=li.imod;
diag.igrpmod=li.igrpmod;
diag.n=li.n;

% elevation classes
upper=[500:500:3500];
lower=upper-500;
lc=length(upper);

%%%%%% Model loop

for m=1:li.n
%
%for m=1:li.n-3
%
%for m=1

%%%%%%%%%% General per model 

% own nan ice mask
%iman=double(li.historical{m}.lithk>1.0);
iman = double(li.historical{m}.sftgrf);
iman(iman==0)=NaN;

%%%%%%%%%%%%%%%


% Total ice volume
dmod = nansum(nansum(double(li.historical{m}.lithk).*iman.*af2))*25000000;
diag.vol{m}=dmod;

dobs = nansum(nansum(double(obs1.lithk).*double(obs1.msk1).*af2))*25000000;
diag.vol_obs=dobs;
dobs=nansum(nansum(obs1.lithk.*obs1.msk1.*obs1.zmn.*af2))*25000000;
diag.zvol_obs=dobs;

ddat=dmod-dobs;
diag.ae_dvol{m}=abs(ddat);
diag.se_dvol{m}=ddat;


% Total ice area
dmod=nansum(nansum(iman.*af2))*25000000;
diag.area{m}=dmod;

dobs=nansum(nansum(double(obs1.msk1).*af2))*25000000;
diag.area_obs=dobs;
dobs=nansum(nansum(obs1.msk1.*obs1.zmn.*af2))*25000000;
diag.zarea_obs=dobs;

%ddat=dmod-dobs;
%diag.ae_darea{m}=abs(ddat);
%diag.se_darea{m}=ddat;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Thickness
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RMS thickness
dmod=li.historical{m}.lithk;
% make NaNs zero to evaluate same area for all models
dmod(not(isfinite(dmod)))=0;

dobs=obs1.lithk;
ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_lithk{m}=rms;

% RMS thickness subsampled
dmod=li.historical{m}.lithk;
% make NaNs zero to evaluate same area for all models
dmod(not(isfinite(dmod)))=0;

dobs=obs1.lithk;
ddat=dmod-dobs;

% output container (offsetsx*offsetsy)
rms_ss_all=zeros(9*9,1);
k=0;
% subsample with chaning offset
for ii=1:9
    for jj=1:9
        k=k+1;
        ddat_ss=ddat((ii*5):50:end,(jj*5):50:end);
        rms=sqrt((nanmean((ddat_ss(:).^2))));
        rms_ss_all(k) = rms;
    end
end
diag.rms_lithk_ssm{m} = median(rms_ss_all,1);


% RMS thickness on Zmask
dmod=li.historical{m}.lithk;
% make NaNs zero to evaluate same area for all models
dmod(not(isfinite(dmod)))=0;

% mask observations to nan zmask
dobs=obs1.lithk.*obs1.zmn;
ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_lithk_zm{m}=rms;


% RMS thickness on model icemask; you say ice, I say how high
% only where ice in model
dmod=li.historical{m}.lithk.*iman;

dobs=obs1.lithk;
ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_lithk_im{m}=rms;

% RMS thickness on model ensemble mask
% only where ice in all models
dmod=li.historical{m}.lithk.*mimn;
dobs=obs1.lithk;
ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_lithk_mm{m}=rms;


%% RMS thickness in elevation classes
for lci=1:lc
% RMS thickness elevation class xx - yy
    dmod=li.historical{m}.lithk;
% make NaNs zero to evaluate same area for all models
    dmod(not(isfinite(dmod)))=0;

    mask1=double(obs1.orog<upper(lci) & obs1.orog>lower(lci));
    mask1(mask1==0)=NaN;
    dobs=obs1.lithk.*mask1;
    ddat=dmod-dobs;
%    shade(ddat)
    rms=sqrt((nanmean((ddat(:).^2))));
%    diag.rms_lithk_1500{m}=rms;
    eval(['diag.rms_lithk_' num2str(upper(lci)) '{m}=rms;']);
    
end


% RMS surface elevation on model icemask; you say ice, I say how high
% only where ice in model
dmod=li.historical{m}.orog.*iman;

dobs=obs1.orog;
ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_orog_im{m}=rms;


% RMS surface elevation on model ensemble mask
% only where ice in all models
dmod=li.historical{m}.orog.*mimn;
dobs=obs1.orog.*(obs1.orog>1.5);
ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_orog_mm{m}=rms;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Velocity 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RMS velocity magnitude on model icemask
dmod=(li.historical{m}.velmean).*iman;
dobs=(obs1.velsurf/spy);

ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_velsurf_im{m}=rms;

% RMS of log(velocity magnitude m/yr) on model ensemble mask
tiny=1e-25;
dmod=log(li.historical{m}.velmean+tiny).*mimn;
dobs=log(obs1.velsurf/spy+tiny);

ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_velsurf_mm{m} = rms;

% RMS of log(velocity magnitude) subsampled
% output container (offsetsx*offsetsy)
rms_ss_all=zeros(9*9,1);
k=0;
% subsample with chaning offset
for ii=1:9
    for jj=1:9
        k=k+1;
        ddat_ss=ddat((ii*5):50:end,(jj*5):50:end);
        rms=sqrt((nanmean((ddat_ss(:).^2))));
        rms_ss_all(k) = rms;
    end
end
diag.rms_velsurf_mm_ssm{m} = median(rms_ss_all,1);


%% RMS log(velocity magnitude) elevation class
for lci=1:lc
    dmod=log(li.historical{m}.velmean*spy+tiny).*mimn;
    
    mask1=double(obs1.orog<upper(lci) & obs1.orog>lower(lci));
    mask1(mask1==0)=NaN;
    dobs=log(obs1.velsurf+tiny).*mask1;
    
    ddat=dmod-dobs;
    rms=sqrt((nanmean((ddat(:).^2))));
    eval(['diag.rms_velsurf_mm_' num2str(upper(lci)) '{m}=rms;']);
end


%% RMS of (velocity magnitude) on model ensemble mask
dmod=(li.historical{m}.velmean).*mimn;
dobs=obs1.velsurf/spy;

ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_velsurf_lin_mm{m} = rms;

%% RMS of (velocity magnitude) subsampled
% output container (offsetsx*offsetsy)
rms_ss_all=zeros(9*9,1);
k=0;
% subsample with chaning offset
for ii=1:9
    for jj=1:9
        k=k+1;
        ddat_ss=ddat((ii*5):50:end,(jj*5):50:end);
        rms=sqrt((nanmean((ddat_ss(:).^2))));
        rms_ss_all(k) = rms;
    end
end
diag.rms_velsurf_lin_mm_ssm{m} = median(rms_ss_all,1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SMB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% partitioning SMB 
dmod=(li.historical{m}.acabf).*iman;
diag.part{m}=nansum(nansum(dmod.*af2))*5000*5000*spy*1e-12;
diag.partp{m}=nansum(nansum(dmod.*af2.*(dmod>0)))*5000*5000*spy*1e-12;
diag.partn{m}=nansum(nansum(dmod.*af2.*(dmod<0)))*5000*5000*spy*1e-12;


% RMS SMB abl
iman = double(li.historical{m}.sftgrf);
iman(iman==0)=NaN;
dmod=(li.historical{m}.acabf)./iman;
dobs=(abl.smb/spy*1000);

ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_abl_im{m}=rms;


% output container (offsetsx*offsetsy)
rms_ss_all=zeros(5*5,1);
k=0;
% compare with chaning offset
for ii=-2:2
    for jj=-2:2
        k=k+1;
        dobs_ss=dobs((3-ii):1:(end-2-ii),(3-jj):1:(end-2-jj));
        dmod_ss=dmod(3:1:end-2,3:1:end-2);
        ddat_ss=dmod_ss-dobs_ss;
        rms=sqrt((nanmean((ddat_ss(:).^2))));
        rms_ss_all(k) = rms;
    end
end
diag.rms_abl_ssm{m} = median(rms_ss_all,1);



% RMS SMB acc
dmod=(li.historical{m}.acabf)./iman;
dobs=(acc.smb/spy*1000);

ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_acc_im{m}=rms;


% RMS SMB (acc and abl combined)
dmod=(li.historical{m}.acabf)./iman;
dobs=(acc.smb/spy*1000);
dobs(isfinite(abl.smb))=abl.smb(isfinite(abl.smb))/spy*1000;

ddat=dmod-dobs;
rms=sqrt((nanmean((ddat(:).^2))));
diag.rms_smb_im{m}=rms;

end
% end model loop

save diag_fi_A5 diag;

% 
%end
