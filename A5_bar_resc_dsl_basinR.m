% plot ISMIP6 results

clear

load resc_basinR_A5
%load ch_A5.mat

kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 

% Select experiment
%aexp = 'ctrl_proj';
aexp = 'exp05';
%aexp = 'exp06';
%aexp = 'exp07';
%aexp = 'exp08';
%aexp = 'exp09';
%aexp = 'exp10';


%scl=kg2mmsl;
scl=-1000;
ylab='Sea-level contribution [mm]';

regs = {'no', 'ne', 'se', 'sw', 'cw', 'nw'};

% Plot
co = get(0,'DefaultAxesColorOrder');
figure('Position',[440  400 480 320])
hold on; box on

modsel = 1:(resc.n-4);
% exclude BGC
%modsel = [2:resc.n];

spc = length(modsel)+5;

leglin = [];
avail = [];
ens = [];
for m = modsel;
    %    plot(time,(resc.exp05{m}.limnsw(1:86)-resc.hist{m}.limnsw(end))*rescl,'-','Linewidth',1,'Markersize',8)
    % check existance of field
    eval(['check = isfield(resc.' aexp '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % overlay
        eval(['exp = resc.' aexp '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        eval(['ctrl = resc.' 'ctrl_proj' '{m}.sle(:,end)-resc.historical{m}.sle(:,end);']);
        ens = [ens, (exp-ctrl)*scl];
        leglin(m)=bar((1:6)-0.5+(0.8/spc)*m,(exp-ctrl)*scl,(0.8/spc));
    end
end

emean = mean(ens')
estd = std(ens')
rstd = estd./emean*100; % relative std
%bar((1:6)-0.5+(0.8/spc)*(spc-1),emean,(1/spc),'FaceColor',[0.5,0.5,0.5]);
%bar((1:6)-0.5+(0.8/spc)*(spc-1),estd,(1/spc),'FaceColor',[0.8,0.8,0.8]);
for i =1:6
    bplot(ens(i,:)',(i)-0.5+(0.8/spc)*(spc-1),'outliers','width',(2/spc),'linewidth',1);
    text((i)-0.8+(0.8/spc)*(spc+1),-2,[num2str(round(rstd(i))), ' %']);
end
% Make up
title([aexp ' - ctrl_proj'])
xlabel('Basin');
ylabel(ylab);
ax = axis;
%axis([0.5 6.5 ax(3) ax(4)])
axis([0.5 6.5 -5 50])
set(gca,'XTick',[1:6])
set(gca,'XTickLabel',regs)

%l=legend(leglin((avail)),resc.igrpmod((avail)),'Location','nw','Fontsize',6);
%l=legend(leglin((avail)),anom(avail),'Location','northwest');

% save
print('-r300','-dpng', ['Figures/A5_bar_resc_dsl_basinR_' aexp]);
