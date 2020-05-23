clear; close all;
fs = 12;
%fn = 'Helvetica Narrow';
fn = 'default';
fi = 'tex';

lspace = 0.08;
hspace = 0.1;
rspace = 0.03;
bspace = 0.12;
tspace = 0.05;
pw = (1-lspace-rspace-hspace)/2;
ph = 1-bspace-tspace;
lwthick = 1;
ylims = [-35,1];

cols = [0.000,0.447,0.741;
        0.850,0.325,0.098;
        0.929,0.694,0.125;
        0.494,0.184,0.556;
        0.466,0.674,0.188;
        0.301,0.745,0.933;
        0.635,0.078,0.184];

% load projected retreat
%load('~/Google Drive/ismip6/final_projections/projected_retreat.mat');
load('projected_retreat.mat');
t = retreat.time-0.5;
sectorname = {'SE','SW','CE','CW','NE','NW','NO'};

% all greenland
sif = [139.0,17.6,59.3,91.5,22.4,95.2,16.0]; % ice fluxes

figure(); hold on; box on
plot(t,0*t,'--','linewidth',0.5,'color',0.5*[1,1,1]);
% MIROC5 RCP2.6
plot(t,sum(sif'.*retreat.MIROC5.RCP26.med(1:7,:))/sum(sif),'color',cols(1,:),'linewidth',lwthick,'Linestyle','-');
% MIROC5 RCP8.5
patch([t,fliplr(t)],[sum(sif'.*retreat.MIROC5.RCP85.low(1:7,:))/sum(sif),fliplr(sum(sif'.*retreat.MIROC5.RCP85.high(1:7,:))/sum(sif))],cols(2,:),'edgecolor','none','facealpha',0.25);
plot(t,sum(sif'.*retreat.MIROC5.RCP85.med(1:7,:))/sum(sif),'color',cols(2,:),'linewidth',lwthick,'Linestyle','-');
R0 = sum(sif'.*retreat.MIROC5.RCP85.med(1:7,:))/sum(sif);
R(1) = R0(end);
% NorESM RCP8.5
plot(t,sum(sif'.*retreat.NorESM.RCP85.med(1:7,:))/sum(sif),'color',cols(3,:),'linewidth',lwthick,'Linestyle','-');
    R0 = sum(sif'.*retreat.NorESM.RCP85.med(1:7,:))/sum(sif);
R(2) = R0(end);
% HadGEM RCP8.5
plot(t,sum(sif'.*retreat.HadGEM.RCP85.med(1:7,:))/sum(sif),'color',cols(4,:),'linewidth',lwthick,'Linestyle','-');
    R0 = sum(sif'.*retreat.HadGEM.RCP85.med(1:7,:))/sum(sif);
R(3) = R0(end);
% IPSLCM RCP8.5
plot(t,sum(sif'.*retreat.IPSLCM.RCP85.med(1:7,:))/sum(sif),'color',cols(5,:),'linewidth',lwthick,'Linestyle','--');
    R0 = sum(sif'.*retreat.IPSLCM.RCP85.med(1:7,:))/sum(sif);
R(5) = R0(end);
% CSIRO RCP8.5
plot(t,sum(sif'.*retreat.CSIRO.RCP85.med(1:7,:))/sum(sif),'color',cols(6,:),'linewidth',lwthick,'Linestyle','--');
    R0 = sum(sif'.*retreat.CSIRO.RCP85.med(1:7,:))/sum(sif);
R(4) = R0(end);
% ACCESS RCP8.5
plot(t,sum(sif'.*retreat.ACCESS.RCP85.med(1:7,:))/sum(sif),'color',cols(7,:),'linewidth',lwthick,'Linestyle','--');
    R0 = sum(sif'.*retreat.ACCESS.RCP85.med(1:7,:))/sum(sif);
R(6) = R0(end);

xlim([2014 2100]); ylim([-25 1]);
xlabel('Time (yr)');
ylabel('Projected retreat (km)');

titles = {'MIROC5 RCP2.6','MIROC5 RCP8.5','NorESM1-M RCP8.5','HadGEM2-ES RCP8.5',...
          'IPSL-CM5A-MR RCP8.5','CSIRO-Mk3-6-0 RCP8.5','ACCESS1-3 RCP8.5'};

% manual legend
tx = 2018;
ty = -12;
dx = 20;
dy = -1.5;
text(tx+0*dx,ty+0*dy,titles{1},'fontsize',fs,'color',cols(1,:),'fontname',fn,'interpreter',fi);
text(tx+0*dx,ty+1*dy,titles{2},'fontsize',fs,'color',cols(2,:),'fontname',fn,'interpreter',fi);
text(tx+0*dx,ty+2*dy,titles{3},'fontsize',fs,'color',cols(3,:),'fontname',fn,'interpreter',fi);
text(tx+0*dx,ty+3*dy,titles{4},'fontsize',fs,'color',cols(4,:),'fontname',fn,'interpreter',fi);
text(tx+0*dx,ty+4*dy,titles{5},'fontsize',fs,'color',cols(5,:),'fontname',fn,'interpreter',fi);
text(tx+0*dx,ty+5*dy,titles{6},'fontsize',fs,'color',cols(6,:),'fontname',fn,'interpreter',fi);
text(tx+0*dx,ty+6*dy,titles{7},'fontsize',fs,'color',cols(7,:),'fontname',fn,'interpreter',fi);

print('-dpng','-r300',['retreat_GrIS_wide'])
