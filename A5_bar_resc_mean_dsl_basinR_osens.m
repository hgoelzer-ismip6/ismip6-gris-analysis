% plot ISMIP6 results

clear

load resc_basinR_A5

% colors
c1=[0.0,0.7,0.7];
c2=[0.0,0.0,0.7];
c3=[0.0,0.7,0.0];

scl=-1000;
ylab='Sea-level contribution (mm)';

regs = {'NO', 'NE', 'SE', 'SW', 'CW', 'NW'};

% Plot
co = get(0,'DefaultAxesColorOrder');
figure('Position',[440  400 480 320])
hold on; box on

%modsel = 1:resc.n;
% exclude open and noism
modsel = [1:16,18,20];

spc = 1.2;

leglin = [];
avail = [];
ens05 = [];
ens09 = [];
ens10 = [];
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
        eval(['exp = resc.' 'exp09' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        eval(['ctrl = resc.' 'ctrl_proj' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        ens09 = [ens09, (exp-ctrl)*scl];
    end
    eval(['check = isfield(resc.' 'exp08' '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % overlay
        eval(['exp = resc.' 'exp10' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        eval(['ctrl = resc.' 'ctrl_proj' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        ens10 = [ens10, (exp-ctrl)*scl];
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

for i =1:6
    bar(i-0.3,mean(ens10(i,:))',0.2,'linewidth',1,'FaceColor', c3);
    text(i-0.3,1,'l','HorizontalAlignment','center','color', 'w')
    bar(i,mean(ens05(i,:)'),0.2,'linewidth',1,'FaceColor', c1);
    text(i-0,1,'m','HorizontalAlignment','center','color', 'w')
    bar(i+0.3,mean(ens09(i,:)'),0.2,'linewidth',1,'FaceColor', c2);
    text(i+0.3,1,'h','HorizontalAlignment','center','color', 'w')
end
% Make up
%title(['exp - ctrl_proj'])
xlabel('Basin');
ylabel(ylab);
ax = axis;
%axis([0.5 6.5 ax(3) ax(4)])
axis([0.5 6.5 0 30])
set(gca,'XTick',[1:6])
set(gca,'XTickLabel',regs)

% save
print('-r300','-dpng', ['Figures/A5_bar_resc_mean_dsl_basinR_osens']);


disp('mean spread') 
mean(sum(ens09)-sum(ens10))

