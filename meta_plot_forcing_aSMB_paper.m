% plot several experiments

spy = 31556926;

apath = '/Volumes/ISMIP6/Projections/Greenland/Forcing/';

set(0,'DefaultAxesColorOrder', 'default')

figure(1)
hold on; box on
co=get(gca,'colororder');
opa = 0.3;

% T1
legs = {}; n = 0;
leghs = [];

aexp = 'MIROC5-rcp26';
load([apath,'smb_' aexp '.mat'], 'asmb_int','asmb_mean','time')
plot(time,asmb_int,'Color',[co(n+1,:) opa])
leghs(n+1) = plot(time,rmean(asmb_int,10),'Color',co(n+1,:),'Linestyle','-');
legs{n+1} = aexp; n = n+1;

aexp = 'MIROC5-rcp85';
load([apath,'smb_' aexp '.mat'], 'asmb_int','asmb_mean','time')
plot(time,asmb_int,'Color',[co(n+1,:) opa])
leghs(n+1) = plot(time,rmean(asmb_int,10),'Color',co(n+1,:),'Linestyle','-');
legs{n+1} = aexp; n = n+1;

aexp = 'NorESM1-rcp85';
load([apath,'smb_' aexp '.mat'], 'asmb_int','asmb_mean','time')
plot(time,asmb_int,'Color',[co(n+1,:) opa])
leghs(n+1) = plot(time,rmean(asmb_int,10),'Color',co(n+1,:),'Linestyle','-');
legs{n+1} = aexp; n = n+1;

aexp = 'HadGEM2-ES-rcp85';
load([apath,'smb_' aexp '.mat'], 'asmb_int','asmb_mean','time')
plot(time,asmb_int,'Color',[co(n+1,:) opa])
leghs(n+1) = plot(time,rmean(asmb_int,10),'Color',co(n+1,:),'Linestyle','-');
legs{n+1} = aexp; n = n+1;


%%% T2 CMIP5
aexp = 'IPSL-CM5-MR-rcp85';
load([apath,'smb_' aexp '.mat'], 'asmb_int','asmb_mean','time')
%plot(time,asmb_int,'Color',[co(n+1,:) opa])
leghs(n+1) = plot(time,rmean(asmb_int,10),'Color',co(n+1,:),'Linestyle','--','Linewidth',1.5);
legs{n+1} = aexp; n = n+1;

aexp = 'CSIRO-Mk3.6-rcp85';
load([apath,'smb_' aexp '.mat'], 'asmb_int','asmb_mean','time')
%plot(time,asmb_int,'Color',[co(n+1,:) opa])
leghs(n+1) = plot(time,rmean(asmb_int,10),'Color',co(n+1,:),'Linestyle','--','Linewidth',1.5);
legs{n+1} = aexp; n = n+1;

aexp = 'ACCESS1.3-rcp85';
load([apath,'smb_' aexp '.mat'], 'asmb_int','asmb_mean','time')
%plot(time,asmb_int,'Color',[co(n+1,:) opa])
leghs(n+1) = plot(time,rmean(asmb_int,10),'Color',co(n+1,:),'Linestyle','--','Linewidth',1.5);
legs{n+1} = aexp; n = n+1;


%% shade background categories
rectangle('Position',[2000.2 -1795 13.6 2190],'FaceColor',[0.95,0.95,0.95,0.5],'EdgeColor',[0.95,0.95,0.95,0.5])

% General Plotting
plot([2014,2014],[-1800,400],'k:','Linewidth',1)
xlabel('Year')
ylabel('SMB anomaly (Gt yr^{-1})','Interpreter','Tex')
axis([2000 2100 -1800 400])
legend(leghs,legs,'Location','sw')

print('-dpng','-r300','Figures/SMB_anomaly_all_paper_top6')
