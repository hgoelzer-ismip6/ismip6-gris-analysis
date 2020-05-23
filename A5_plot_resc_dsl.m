% plot ISMIP6 results

clear

load resc_A5
% labs names/ models list
load set_default.mat

kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 

% Select experiment
aexp = 'exp05';
%aexp = 'exp06';
%aexp = 'exp07';
%aexp = 'exp08';
%aexp = 'exp09';
%aexp = 'exp10';

%aexp = 'exp11';
%aexp = 'exp12';
%aexp = 'exp13';
%aexp = 'exp14';
%aexp = 'exp15';

%aexp = 'exp05_o';
%aexp = 'exp05_a';


%scl=kg2mmsl;
scl=-1000;
ax=[0,100,-5,200];
ylab='Sea-level contribution (mm)';

time = 2015:2100;

% Plot
co = get(0,'DefaultAxesColorOrder');
figure('Position',[440  400 480 320])
hold on; box on

modsel = 1:length(resc.igrp);
% exclude some
%modsel = [1:8,10,11];
%modsel = [9,10];
%modsel = [1:19];
% all in
modsel = [1:length(resc.igrp)-3];


leglin = [];
avail = [];

% NOISM
leglin(22)=plot(time,(resc.exp05{22}.sle(1:86)-resc.exp05{22}.sle(1)-resc.ctrl_proj{22}.sle(1:86)+resc.ctrl_proj{22}.sle(1))*scl,'-','Linewidth',4,'Markersize',8, 'Color', 'k');
leglin(22)=plot(time,(resc.exp05{22}.sle(1:86)-resc.exp05{22}.sle(1)-resc.ctrl_proj{22}.sle(1:86)+resc.ctrl_proj{22}.sle(1))*scl,'--','Linewidth',4,'Markersize',8, 'Color', [0.7,0.7,0.7]);

for m = modsel;
    % check existance of field
    eval(['check = isfield(resc.' aexp '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % relative to year1, remove ctrl_proj 
        eval(['leglin(m)=plot(time,(resc.' aexp '{m}.sle(1:86)-resc.' aexp '{m}.sle(1)-resc.' 'ctrl_proj' '{m}.sle(1:86)+resc.' 'ctrl_proj' '{m}.sle(1))*scl,''-'',''Linewidth'',1,''Markersize'',8, ''Color'', co(m,:));']);

        % relative to hist, remove ctrl_proj
        %eval(['exp1 = (resc.' aexp '{m}.sle(1:86)-resc.historical{m}.sle(end))*scl;']);
        %ctrl = (resc.ctrl_proj{m}.sle(1:86)-resc.historical{m}.sle(end))*scl;
        %leglin(m)=plot(time,exp1-ctrl,'-','Linewidth',1,'Markersize',8, 'Color', co(m,:));
    end
end

% NOISM
ll=leglin(avail);
%set(ll(end),'Color',[0.7,0.7,0.7],'Linestyle','--','Linewidth',2)

% Make up
plot([2015 2100],[0 0],':k','Linewidth',1)
%plot([2092 2092],[0 200],':k','Linewidth',1)
%plot([2093 2093],[0 200],':r','Linewidth',1)
xlabel('Time (yr)');
ylabel(ylab);
ax=axis;
set(gca,'YAxisLocation','right')
set(gca,'YTick',[0:20:170])
ax=axis;
%axis([2015 2100 ax(3) ax(4)])
axis([2015 2100 -15 170])
hold off

%l=legend(leglin((avail)),resc.igrpmod((avail)),'Location','northwest','Fontsize',8);


% save
print('-r300','-dpng', ['Figures/A5_resc_dsl_' aexp]);

%%%%% out of area legend
%axis([0 100 1000 2000])
%l=legend(leglin((avail)),papgrpmod((avail)),'Location','northwest','Fontsize',8);
%print('-r300','-dpng', ['Figures/A5_resc_dsl_' aexp '_leg']);
