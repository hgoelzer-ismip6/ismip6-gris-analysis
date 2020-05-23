% plot ISMIP6 results

clear

load resc_basinR_A5
%load ch_A5.mat

kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 

% colors
c1=[0.7,0,0.7];
c2=[0,0,0.7];
c3=[0.7,0,0];


%scl=kg2mmsl;
scl=-1000;
ylab='Sea-level contribution (mm)';

regs = {'NO', 'NE', 'SE', 'SW', 'CW', 'NW'};

% Plot
co = get(0,'DefaultAxesColorOrder');
figure('Position',[440  400 600 400])
set(gcf, 'DefaultAxesFontSize', 20)
set(gcf, 'DefaultLineLineWidth', 2)
hold on; box on

modsel = 1:resc.n;
% exclude noism
modsel = 1:(resc.n-4);

spc = 1.2;

leglin = [];
avail = [];
ens05 = [];
ens06 = [];
ens08 = [];
for m = modsel;
    %    plot(time,(resc.exp05{m}.limnsw(1:86)-resc.hist{m}.limnsw(end))*rescl,'-','Linewidth',1,'Markersize',8)
    % check existance of field
    eval(['check = isfield(resc.' 'exp05' '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % overlay
        eval(['exp = resc.' 'exp05' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        eval(['ctrl = resc.' 'ctrl_proj' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        ens05 = [ens05, (exp-ctrl)*scl];
    end
    eval(['check = isfield(resc.' 'exp06' '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % overlay
        eval(['exp = resc.' 'exp06' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        eval(['ctrl = resc.' 'ctrl_proj' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        ens06 = [ens06, (exp-ctrl)*scl];
    end
    eval(['check = isfield(resc.' 'exp08' '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % overlay
        eval(['exp = resc.' 'exp08' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        eval(['ctrl = resc.' 'ctrl_proj' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        ens08 = [ens08, (exp-ctrl)*scl];
    end
end

%% shade background categories
% 
rectangle('Position',[0 -40 1.5 150],'FaceColor',[0.95,0.95,0.95],'EdgeColor',[0.95,0.95,0.95])
%% 
rectangle('Position',[1.5 -40 2.5 150],'FaceColor','w','EdgeColor','w')
%% 
rectangle('Position',[2.5 -40 3.5 150],'FaceColor',[0.95,0.95,0.95],'EdgeColor',[0.95,0.95,0.95])
%% 
rectangle('Position',[3.5 -40 4.5 150],'FaceColor','w','EdgeColor','w')
%% 
rectangle('Position',[4.5 -40 5.5 150],'FaceColor',[0.95,0.95,0.95],'EdgeColor',[0.95,0.95,0.95])
%% 
rectangle('Position',[5.5 -40 6.5 150],'FaceColor','w','EdgeColor','w')

% zero line
plot([0,7],[0,0],'k--','LineWidth',1)

%bar((1:6),emean,(1/spc),'FaceColor',[0.5,0.5,0.5]);
%bar((1:6),estd,(1/spc),'FaceColor',[0.8,0.8,0.8]);
for i =1:6
    bplot(ens05(i,:)',i-0.3,'outliers','width',0.2,'linewidth',1,'color', c1);
    text(i-0.3,48,'M','HorizontalAlignment','center','color', c1,'FontSize',14)
    bplot(ens06(i,:)',i,'outliers','width',0.2,'linewidth',1,'color', c2);
    text(i-0,48,'N','HorizontalAlignment','center','color', c2,'FontSize',14)
    bplot(ens08(i,:)',i+0.3,'outliers','width',0.2,'linewidth',1,'color', c3);
    text(i+0.3,48,'H','HorizontalAlignment','center','color', c3,'FontSize',14)
end
% Make up
%title(['exp - ctrl_proj'])
xlabel('Basin');
ylabel(ylab);
ax = axis;
%axis([0.5 6.5 ax(3) ax(4)])
axis([0.5 6.5 -5 50])
set(gca,'XTick',[1:6])
set(gca,'XTickLabel',regs)

% Anonym
anom = {};
for k = 1:length(resc.igrpmod(modsel))
    anom{k} = ['ISM ' num2str(k)];
end

%l=legend(leglin((avail)),resc.igrpmod((avail)),'Location','sw','Fontsize',6);
%l=legend(leglin((avail)),resc.igrpmod((avail)),'Location','nw','Fontsize',6);
%l=legend(leglin((avail)),anom(avail),'Location','northwest');

% save
print('-r300','-dpng', ['Figures/A5_box_resc_mean_dsl_basinR_comp']);
