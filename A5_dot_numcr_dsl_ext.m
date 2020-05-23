% plot ISMIP6 results

clear

%load resc_A5
load numcr_A5_ext.mat

modsel = 1:(length(numcr.igrp)-4);

%% All exps
label = 'extall';
exps = {'exp05', 'exp06', 'exp08', 'expa01', 'expa02', 'expa03', 'exp09', 'exp10', 'exp07'};
%expnames = {'M1 med', 'M2 med', 'M3 med', 'M1 high', 'M1 low', 'M1 r26'};
expnames = {'MIROC5 med', 'NorESM-M med', 'HadGEM2-ES med', 'IPSL-CM5A-MR med', 'CSIRO-Mk3.6 med', 'ACCESS1-3 med', 'MIROC5 high', 'MIROC5 low', 'MIROC5 med'};
%xps = 1:length(exps); 
xps = [1:0.9:5.5 6.8  7.7  9]; 


ne = length(exps);
% x positions
%xps = 1:ne; 

kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 
sle2mm=-1000; 

%scl=kg2mmsl;
scl=sle2mm;
ax=[0,100,-5,200];
ylab='Sea-level contribution (mm)';


% Plot
co = get(0,'DefaultAxesColorOrder');
%figure('Position',[73 126 800 500])
figure('Position',[73 126 800 600])
hold on; box on

%% shade background categories
%% RCP8.5
rectangle('Position',[0 -40 6.5 240],'FaceColor',[0.95,1,0.95],'EdgeColor',[0.95,1,0.95])
text(0.6,-10,'RCP8.5','FontSize', 18)
%% ocean sens
rectangle('Position',[6.0 -40 8.5 240],'FaceColor',[1,0.95,0.95],'EdgeColor',[1,0.95,0.95])
text(6.1,-10,'Ocean Sensitivity','FontSize', 18)
%% RCP2.6
rectangle('Position',[8.5 -40 9.5 240],'FaceColor',[0.95,0.95,1],'EdgeColor',[0.95,0.95,1])
text(8.6,-10,'RCP2.6','FontSize', 18)

leglin = [];

for e = 1:ne
    aexp = exps{e};

    for m = modsel;
        % test if field exists
        test = eval(['isfinite(numcr.' aexp '(m))']);
        if(test)
            eval(['leglin(m)=plot(xps(e),(numcr.' aexp '(m)*-1000),''o'',''Linewidth'',2,''Markersize'',8, ''Color'', co(m,:));']);
        end
    end
end

% Make up
plot([0,14], [0,0],'k--','Linewidth',0.5)
hold off

ylabel(ylab);
ax=axis;
set(gca,'YAxisLocation','right')
set(gca,'YTick',[0:20:170])
set(gca,'XTick',[xps])
set(gca,'XTickLabel',expnames,'XTickLabelRotation',90)
set(gca, 'Layer', 'top')
%title([label])
ax=axis;
axis([0.5 max(xps)+0.5 -20 170])

set(gca,'Position',[0.0641    0.2983    0.8466    0.6267])
% Legend
% Anonym
anom = {};
for k = 1:length(numcr.igrpmod(modsel))
    anom{k} = ['ISM ' num2str(k)];
end
%l=legend(leglin(modsel),sc.igrpmod(modsel),'Location','southeast');
%l=legend(leglin(modsel),anom,'Location','northeast');

% save
print('-r300','-dpng', ['Figures/A5_dot_numcr_dsl_' label]);

%%% out of area legend
%axis([0 100 1000 2000])
%set(gcf,'Position',[680   279   478   819])
%%set(gca,'Linewidth',10)
%l=legend(ch.ids(ch.order),'Location','northwest');
%print -r300 -dpng A5_sc_legend

