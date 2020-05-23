% plot ISMIP6 results

clear

load resc_A5

% Params
kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 

% Select experiment
aexp = 'ctrl_proj';
%aexp = 'exp05';
%aexp = 'exp06';
%aexp = 'exp07';
%aexp = 'exp08';
%aexp = 'exp09';
%aexp = 'exp10';

% observed Mouginot
load /Users/hgoelzer/Documents/IMAU/Projects/ISMIP6/projection-Greenland/init/Validation/Mouginot/Dreg_1972-2018.mat
load /Users/hgoelzer/Documents/IMAU/Projects/ISMIP6/projection-Greenland/init/Validation/Mouginot/Sreg_1972-2018.mat

dD = sum(Dreg);
dS = sum(Sreg);

mtime=1972:2018;
limm19 = (cumsum(dS) - cumsum(dD));
dlimm19 = limm19 - limm19(end-4);

% observed IMBIE
load IMBIE/imbie_gris.txt
itime = imbie_gris(:,1)';
%idM = imbie_gris(:,2)';
%limi = cumsum(idM); 
limi = imbie_gris(:,4)';
dlimi = limi-limi(end-4);

% errors
idMe = imbie_gris(:,3)';
limiecorr = cumsum(idMe); % errors correlated in time!
dlimiecorr = limiecorr-limiecorr(end-4);
limie = imbie_gris(:,5)';
dlimie = limie-limie(end-4);

dlimimax =  dlimi-dlimie;
dlimimin =  dlimi+dlimie;

dlimimaxcorr =  dlimi-dlimiecorr;
dlimimincorr =  dlimi+dlimiecorr;

%scl=kg2mmsl;
scl=1e-12;
ax=[0,100,-5,200];
ylab='Ice mass change (Gt)';

time = 2015:2100;

% Plot
co = get(0,'DefaultAxesColorOrder');
%figure(1)
figure('Position',[440  400 480 320])
hold on; box on

%modsel = 1:resc.n;
% exclude NOISM
%modsel = 1:(resc.n-4);
% exclude UCIJPL-ISSM2
%modsel = [1:18,20:21];
%modsel = [1:19];
%modsel = [18:19];
% all in
modsel = [1:21];

% obs Mouginot
plot(mtime(1:end-4),dlimm19(1:end-4),'LineStyle','-','Color',[0.8,0.8,0.8],'Linewidth',2);
plot(mtime(1:end-4),dlimm19(1:end-4),'LineStyle','-','Color','k','Linewidth',1);
plot(mtime(1:end-4),dlimm19(1:end-4),'LineStyle','--','Color',[1,1,1],'Linewidth',1);

% obs IMBIE
patch([fliplr(itime(1:end-4)),itime(1:end-4)],[fliplr(dlimimincorr(1:end-4)),dlimimaxcorr(1:end-4)],[0.3,0.3,0.3],'edgecolor','none','facealpha',0.15);
patch([fliplr(itime(1:end-4)),itime(1:end-4)],[fliplr(dlimimin(1:end-4)),dlimimax(1:end-4)],[0.3,0.3,0.3],'edgecolor','none','facealpha',0.25);
legobs=plot(itime(1:end-4),dlimi(1:end-4),'LineStyle',':','Color',[0.5,0.5,0.5],'Linewidth',1.5);
%legobs=plot(itime(1:end-4),dlimi(1:end-4),'LineStyle',':','Color',[0.3,0.3,0.3],'Linewidth',2);

% set template to longest record
hmaxl = 0;
for m = modsel;
    hmaxl = max(hmaxl,length(resc.historical{m}.lim));
end
output = nan(22,hmaxl+86);
leglin = [];
avail = [];
for m = modsel;
    % check existance of field
    eval(['check = isfield(resc.' aexp '{m},''sle'');'])
    if (check ==1)
        avail = [avail, m];
        % full signal
        eval(['lim=[0; (resc.' aexp '{m}.lim(1:86))-resc.historical{m}.lim(end)];']);
        leglin(m)=plot([2014, time],lim*scl,'-','Linewidth',1,'Markersize',8,'Color', co(m,:));
        htime = (2014-length(resc.historical{m}.sle)+1):2014;
        %hlim = (resc.historical{m}.limaf);
        hlim = (resc.historical{m}.limaf-resc.historical{m}.limaf(end));
        plot(htime,hlim*scl,'-','Linewidth',1,'Markersize',8, 'Color', co(m,:));

        % make output
        output(m,55:141) = lim*scl;
        output(m,(55+1-length(hlim)):55) = hlim*scl;
    end
end

output(22,56:141) = time;
output(22,1:55) = 1960:2014;
outtime = output(22,:);

% Make up
plot([1960 2100],[0 0],':k','Linewidth',1)
%plot([2092 2092],[0 200],':k','Linewidth',1)
%plot([2093 2093],[0 200],':r','Linewidth',1)
xlabel('Time (yr)');
ylabel(ylab);
ax=axis;
set(gca,'YAxisLocation','right')
%set(gca,'YTick',[0:20:170])
ax=axis;
%axis([2015 2100 ax(3) ax(4)])
%axis([1960 2100 ax(3) ax(4)])
axis([1960 2100 -7000 7000])
%axis([1960 2100 -10000 10000])
hold off

%l=legend([leglin((avail)), legobs], [resc.igrpmod((avail)), 'IMBIE (2019)'],'Location','sw','Fontsize',8);


% save
print('-r300','-dpng', ['Figures/A5_resc_lim_hist_' aexp]);

%%% out of area legend
%axis([0 100 1000 2000])
%set(gcf,'Position',[680   279   478   819])
%%set(gca,'Linewidth',10)
%l=legend(ch.ids(ch.order),'Location','northwest');
%print -r300 -dpng A5_resc_legend

% write out models
outtitles = resc.igrpmod((avail));
outtitles = regexprep(outtitles, '\-', '_');
outtitles{end+1}='time';
ncwrite_multi_1d('Fig4_models.nc', output, outtitles, outtime,'time')

% write out obs Mouginot
outtitles = {'Mouginot_2019', 'time'};
ncwrite_multi_1d('Fig4_obsMouginot.nc', [dlimm19(1:end-4); mtime(1:end-4)], outtitles, mtime(1:end-4),'time')

% write out obs IMBIE
outtitles = {'IMBIE_mean','IMBIE_corr_min','IMBIE_corr_max','IMBIE_min','IMBIE_max', 'time'};

ncwrite_multi_1d('Fig4_obsIMBIE.nc', [dlimi(1:end-4); dlimimincorr(1:end-4); dlimimaxcorr(1:end-4); dlimimin(1:end-4); dlimimax(1:end-4); itime(1:end-4)], outtitles, itime(1:end-4),'time')
