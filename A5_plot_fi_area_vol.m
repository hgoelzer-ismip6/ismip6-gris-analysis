% plot ISMIP6 results

startup

clear

load diag_fi_A5.mat
% labs names/ models list
load set_default.mat

colors=get(0,'DefaultAxesColorOrder');

% Plot
figure

hold on; box on
% Observations
lb=plot(diag.area_obs*1e-12,diag.vol_obs*1e-15,'d','Color',[0.8,0.8,0.8],'MarkerSize',14);

% Cmasked
%lc=plot(diag.carea*1e-12,diag.cvol_o1*1e-15,'d','Color',[0.4,0.4,0.4],'MarkerSize',14);

% Zmasked
lz=plot(diag.zarea_obs*1e-12,diag.zvol_obs*1e-15,'d','Color','k','MarkerSize',14);

lls = zeros(1,diag.n-4);
% Models
%for m=[1,2,3,4,5,6,12,14,15,17,18,19,20,21,22,26,27,30,31,32,35];
for m=1:(diag.n-4);
    %    k = ch.order(m);
    lls(m) = plot(diag.area{m}*1e-12,diag.vol{m}*1e-15,'Marker','o','Linewidth',2,'MarkerSize',8,'Color',colors(m,:));
end

hold off

% Make up
% 1,710,000 km2
% 2,900,000 km3
xlabel('Area (10^{6} km^2)','Interpreter','tex','FontSize',22);
ylabel('Volume (10^{6} km^3)','Interpreter','tex','FontSize',22);

ax=axis;
%axis([1.6 2.1 2.8 3.5]) % initMIP margins
axis([1.6 2.0 2.70 3.25])

legend([lz,lb],{'Rastner 2012', 'Morlighem 2017'},'Location','northwest')

% save
print('-r300','-dpng',['Figures/A5_fi_diag_area_vol']);


%%% out of plot legend
%axis([100,101,100,101])
%legend(lls,papgrpmod{1:diag.n-4},'FontSize',10)
%print('-r300','-dpng',['Figures/A5_fi_diag_area_vol_legend']);
