% plot ISMIP6 results

clear

load resc_A5_ext

cols = [0.000,0.447,0.741;
        0.850,0.325,0.098;
        0.929,0.694,0.125;
        0.494,0.184,0.556;
        0.466,0.674,0.188;
        0.301,0.745,0.933;
        0.635,0.078,0.184];


kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 


%scl=kg2mmsl;
scl=-1000;
ax=[0,100,-5,200];
ylab='Sea-level contribution (mm)';

time = 2015:2100;

% Plot
co = get(0,'DefaultAxesColorOrder');
figure
set(gcf,'Position',[440  400 480 320]);
sfh1 = subplot(1,2,1);

hold on; box on

%modsel = 1:(resc.n);
% exclude NOISM
modsel = 1:(resc.n-4);

leglin = [];
avail = [];

ne = length(modsel);

ens05 = zeros([ne,length(time)]);
ens06 = zeros([ne,length(time)]);
ens07 = zeros([ne,length(time)]);
ens08 = zeros([ne,length(time)]);
ensa1 = zeros([ne,length(time)]);
ensa2 = zeros([ne,length(time)]);
ensa3 = zeros([ne,length(time)]);

k = 0;
for m = modsel;
    k = k+1;
    % remove ctrl_proj
    ens07(k,:) = (resc.exp07{m}.sle(1:86)-resc.exp07{m}.sle(1)-resc.ctrl_proj{m}.sle(1:86)+resc.ctrl_proj{m}.sle(1))*scl;
    ens05(k,:) = (resc.exp05{m}.sle(1:86)-resc.exp05{m}.sle(1)-resc.ctrl_proj{m}.sle(1:86)+resc.ctrl_proj{m}.sle(1))*scl;
    ens06(k,:) = (resc.exp06{m}.sle(1:86)-resc.exp06{m}.sle(1)-resc.ctrl_proj{m}.sle(1:86)+resc.ctrl_proj{m}.sle(1))*scl;
    ens08(k,:) = (resc.exp08{m}.sle(1:86)-resc.exp08{m}.sle(1)-resc.ctrl_proj{m}.sle(1:86)+resc.ctrl_proj{m}.sle(1))*scl;

    if (isfield(resc.expa01{m}, 'sle'))
        ensa1(k,:) = (resc.expa01{m}.sle(1:86)-resc.expa01{m}.sle(1)-resc.ctrl_proj{m}.sle(1:86)+resc.ctrl_proj{m}.sle(1))*scl;
    else
        ensa1(k,:) = nan;
    end
    if (isfield(resc.expa02{m}, 'sle'))
    ensa2(k,:) = (resc.expa02{m}.sle(1:86)-resc.expa02{m}.sle(1)-resc.ctrl_proj{m}.sle(1:86)+resc.ctrl_proj{m}.sle(1))*scl;
    else
        ensa2(k,:) = nan;
    end
    if (isfield(resc.expa03{m}, 'sle'))
    ensa3(k,:) = (resc.expa03{m}.sle(1:86)-resc.expa03{m}.sle(1)-resc.ctrl_proj{m}.sle(1:86)+resc.ctrl_proj{m}.sle(1))*scl;
    else
        ensa3(k,:) = nan;
    end
    % relative to hist and remove ctrl_proj
    
    %eval(['exp1 = (resc.' aexp '{m}.sle(1:86)-resc.historical{m}.sle(end))*scl;']);
    %ctrl = (resc.ctrl_proj{m}.sle(1:86)-resc.historical{m}.sle(end))*scl;
    %leglin(m)=plot(time,exp1-ctrl,'-','Linewidth',1,'Markersize',8, 'Color', co(m,:));
end

mens07 = nanmean(ens07(:,:));
mens05 = nanmean(ens05(:,:));
mens06 = nanmean(ens06(:,:));
mens08 = nanmean(ens08(:,:));
mensa1 = nanmean(ensa1(:,:));
mensa2 = nanmean(ensa2(:,:));
mensa3 = nanmean(ensa3(:,:));

sens07 = nanstd(ens07(:,:));
sens05 = nanstd(ens05(:,:));
sens06 = nanstd(ens06(:,:));
sens08 = nanstd(ens08(:,:));
sensa1 = nanstd(ensa1(:,:));
sensa2 = nanstd(ensa2(:,:));
sensa3 = nanstd(ensa3(:,:));

max07 = nanmax(ens07(:,:));
max05 = nanmax(ens05(:,:));
max06 = nanmax(ens06(:,:));
max08 = nanmax(ens08(:,:));
maxa1 = nanmax(ensa1(:,:));
maxa2 = nanmax(ensa2(:,:));
maxa3 = nanmax(ensa3(:,:));

min07 = nanmin(ens07(:,:));
min05 = nanmin(ens05(:,:));
min06 = nanmin(ens06(:,:));
min08 = nanmin(ens08(:,:));
mina1 = nanmin(ensa1(:,:));
mina2 = nanmin(ensa2(:,:));
mina3 = nanmin(ensa3(:,:));


% std
%patch([time,fliplr(time)],[mens07-sens07,fliplr(mens07+sens07)],cols(1,:),'edgecolor','none','facealpha',0.25);
%patch([time,fliplr(time)],[mens05-sens05,fliplr(mens05+sens05)],cols(2,:),'edgecolor','none','facealpha',0.25);
%patch([time,fliplr(time)],[mens06-sens06,fliplr(mens06+sens06)],cols(3,:),'edgecolor','none','facealpha',0.25);
%patch([time,fliplr(time)],[mens08-sens08,fliplr(mens08+sens08)],cols(4,:),'edgecolor','none','facealpha',0.25);

% spread
patch([time,fliplr(time)],[min07,fliplr(max07)],cols(1,:),'edgecolor','none','facealpha',0.25);
patch([time,fliplr(time)],[min05,fliplr(max05)],cols(2,:),'edgecolor','none','facealpha',0.25);
%patch([time,fliplr(time)],[min06,fliplr(max06)],cols(3,:),'edgecolor','none','facealpha',0.25);
%patch([time,fliplr(time)],[min08,fliplr(max08)],cols(4,:),'edgecolor','none','facealpha',0.25);

% lines
l7 = plot(time,mens07, '-','Linewidth',2,'Markersize',8, 'Color',cols(1,:));
l5 = plot(time,mens05, '-','Linewidth',2,'Markersize',8, 'Color',cols(2,:));
l6 = plot(time,mens06, '-','Linewidth',2,'Markersize',8, 'Color',cols(3,:));
l8 = plot(time,mens08, '-','Linewidth',2,'Markersize',8, 'Color',cols(4,:));
a1 = plot(time,mensa1, '-','Linewidth',2,'Markersize',8, 'Color',cols(5,:), 'LineStyle','--');
a2 = plot(time,mensa2, '-','Linewidth',2,'Markersize',8, 'Color',cols(6,:), 'LineStyle','--');
a3 = plot(time,mensa3, '-','Linewidth',2,'Markersize',8, 'Color',cols(7,:), 'LineStyle','--');

% NOISM
%plot(time,ens05(20,:), '--','Linewidth',1,'Markersize',8, 'Color','k')

% Make up
plot([2015 2100],[0 0],':k','Linewidth',1)
%plot([2092 2092],[0 200],':k','Linewidth',1)
%plot([2093 2093],[0 200],':r','Linewidth',1)
xlabel('Time (yr)');
ll = ylabel(ylab);
set(gca,'YAxisLocation','left')
set(gca,'YTick',[0:20:170])
ax=axis;
%axis([2015 2100 ax(3) ax(4)])
axis([2015 2100 -15 170])
hold off

titles = {'MIROC5 RCP2.6','MIROC5 RCP8.5','NorESM1-M RCP8.5','HadGEM2-ES RCP8.5',...
          'CSIRO-Mk3-6-0 RCP8.5','IPSL-CM5A-MR RCP8.5','ACCESS1-3 RCP8.5'};

l=legend([l5,l8,l6,l7,a1,a2,a3],titles{[2,4,3,1,6,5,7]},'Location','northwest','Fontsize',12);

sfh2 = subplot(1,2,2);
hold on
plot([1,1], [min07(end); max07(end)], 'LineWidth',5, 'Color',[cols(1,:),0.4])
plot([1,1], [min05(end); max05(end)], 'LineWidth',5, 'Color',[cols(2,:),0.4])
plot([2,2], [min06(end); max06(end)], 'LineWidth',5, 'Color',[cols(3,:),0.4])
plot([3,3], [min08(end); max08(end)], 'LineWidth',5, 'Color',[cols(4,:),0.4])
plot([4,4], [mina1(end); maxa1(end)], 'LineWidth',5, 'Color',[cols(5,:),0.4])
plot([4,4], [mina2(end); maxa2(end)], 'LineWidth',5, 'Color',[cols(6,:),0.4])
plot([5,5], [mina3(end); maxa3(end)], 'LineWidth',5, 'Color',[cols(7,:),0.4])
box off
axis off
ylabel(ylab);
ax=axis;
set(gca,'YAxisLocation','right')
set(gca,'YTick',[0:20:170])
ax=axis;
axis([1 5 -15 170])

% mean plot without bars: [0.1300    0.1481    0.7538    0.7769]
sfh1.Position = [0.1300    0.1481    0.7538    0.7769];
sfh2.Position = [0.9    0.1481    0.0708    0.7769];

%ll.Position = [2.11e+03 77.5001 -1.0000]

%xt=get(gca,'YTickLabel')

% save
print('-r300','-dpng', ['Figures/A5_resc_dsl_mean_bars_ext']);

% write out, replace spaces by underscore
outtitles = regexprep(titles, '\s+', '_');
outtitles = regexprep(outtitles, '\.', '');
outtitles = regexprep(outtitles, '\-', '_');
outtitles{end+1}='time';
ncwrite_multi_1d('Fig7a_means.nc', [mens05;mens06;mens07;mens08;mensa1;mensa2;mensa3;time], outtitles, time,'time')
ncwrite_multi_1d('Fig7a_mins.nc', [min05;min06;min07;min08;mina1;mina2;mina3;time], outtitles, time,'time')
ncwrite_multi_1d('Fig7a_maxs.nc', [max05;max06;max07;max08;maxa1;maxa2;maxa3;time], outtitles, time,'time')

