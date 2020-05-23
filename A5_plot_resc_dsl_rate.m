% plot ISMIP6 results

clear

load resc_A5

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
ylab='Sea-level rate [mm yr^{-1}]';

time = 2015:2100;

% Plot
co = get(0,'DefaultAxesColorOrder');
figure('Position',[440  400 480 320])
hold on; box on

%modsel = 1:(resc.n)
% exclude some
modsel = 1:(resc.n-4)

leglin = [];
avail = [];
rate_all = zeros([resc.n-4,86]);
for m = modsel;
    % check existance of field
    eval(['check = isfield(resc.' aexp '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % remove ctrl_proj
        %eval(['leglin(m)=plot(time,(resc.' aexp '{m}.sle(1:86)-resc.' aexp '{m}.sle(1)-resc.' 'ctrl_proj' '{m}.sle(1:86)+resc.' 'ctrl_proj' '{m}.sle(1))*scl,''-'',''Linewidth'',1,''Markersize'',8, ''Color'', co(m,:));']);
        % relative to hist and remove ctrl_proj

        eval(['exp1 = (resc.' aexp '{m}.sle(1:86)-resc.historical{m}.sle(end))*scl;']);
        exp1 = [exp1(1); exp1];
        ctrl = (resc.ctrl_proj{m}.sle(1:86)-resc.historical{m}.sle(end))*scl;
        ctrl = [ctrl(1); ctrl];
        %leglin(m)=plot(time,diff(exp1-ctrl),'-','Linewidth',1,'Markersize',8, 'Color', co(m,:));
        rate_sm = rmean(diff(exp1-ctrl),10);
        rate_all(m,:) = rate_sm;
        leglin(m)=plot(time,rate_sm,'-','Linewidth',1,'Markersize',8, 'Color', co(m,:));
    end
end

% NOISM
%ll=leglin(avail);
%set(ll(end),'Color',[0.7,0.7,0.7],'Linestyle','--','Linewidth',2)

% Make up
plot([2015 2100],[0 0],':k','Linewidth',1)
plot([2051 2051],[0 5],':k','Linewidth',1)
plot([2094 2094],[0 5],':r','Linewidth',1)
xlabel('Time [yr]');
ylabel(ylab,'Interpreter','Tex');
ax=axis;
set(gca,'YAxisLocation','right')
%set(gca,'YTick',[0:20:170])
ax=axis;
%axis([2015 2100 ax(3) ax(4)])
axis([2015 2100 -0.5 4])
hold off

%l=legend(leglin((avail)),resc.igrpmod((avail)),'Location','northwest','Fontsize',8);


% save
print('-r300','-dpng', ['Figures/A5_resc_dsl_rate_' aexp]);


% Average rates:
rate_m = mean(rate_all);
[rate_m(41) rate_m(81)]
