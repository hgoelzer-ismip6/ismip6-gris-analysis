% plot minimum ice mask

clear

load lithk_A5

% masking out ellismere and island
mm = ncload('../Data/maxmask1_05000m.nc');
maxmask0 = mm.maxmask1;

% observed
obs=ncload('../Data/BM3_GrIS_nn_e05000m.nc'); 
obs.mask = double(obs.lithk>1).*maxmask0;

% Zurich
dz=ncload('../Data/ZMask_e05000m.nc'); 
zmask = dz.mask;


ln=li.n-4;

mim = li.historical{1}.lithk*0.0;
mim(find(isnan(mim))) = 0.0;
for i=1:(ln)
    if isfield(li.historical{i}, 'lithk')
    dat = double(li.historical{i}.lithk>1.5).*maxmask0;
    dat(find(isnan(dat))) = 0.0;
    mim = mim + dat;

    else
        disp(['missing ' li.igrpmod{i} ])
    end
end

mim0=real(mim>=(ln));
mimid=oceanid(iceid(mim0));
mimn=mim0./mim0;
save mim0_A5 mim0
save mimid_A5 mimid
save mimn_A5 mimn


shade_nt(mim)
% colormap with too many entries
cmap=colormap(hsv(ln+3));
% remove the first 2
cmap = cmap(3:end,:);
% set 0 to white
cmap(1,:)=[1 1 1];
colormap(cmap)
caxis([-0.5 ln+0.5])
hold on
% observed ice mask
contour(obs.mask',[0.5,0.5],'Color',[0.4,0.4,0.4],'Linewidth',0.5)
% observed zurich mask
contour(zmask',[0.5,0.5],'k','Linewidth',1)
%    contour(dat',0:500:3500,'k')
%hold off
%    caxis([0 3500])
%title(['icemask init A5'])
cb = colorbar;
set(cb,'Ytick',[0:ln])
lt=text(352,-20,'#','Interpreter','Tex','FontSize',14,'VerticalAlignment','middle')

print('-r300','-dpng', 'Figures/A5_fi_init_mimm' );

% zooms:
x=[22,82]+40;
y=[110,220];
plot([x(1) x(2) x(2) x(1) x(1)],[y(1) y(1) y(2), y(2), y(1)],'b')

x=[210,264];
y=[440,540]+20;
plot([x(1) x(2) x(2) x(1) x(1)],[y(1) y(1) y(2), y(2), y(1)],'b')

print('-r300','-dpng', 'Figures/A5_fi_init_mimm_inset' );



%shade_nt(mimid)
%load cmap_mask;
%colormap(cmap)
%hold on
%contour(mimid','k')
%hold off
%%    caxis([0 3500])
%title(['icemask init A5'])
%print('-r300','-dpng', 'Figures/A5_fi_init_mimid' );
%
%shade_nt(mim0)
%load cmap_mask;
%colormap(cmap)
%hold on
%contour(mim0','k')
%hold off
%%    caxis([0 3500])
%title(['icemask init A5'])
%print('-r300','-dpng', 'Figures/A5_fi_init_mim0' );

