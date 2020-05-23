% Plot 2d ensemble statistics 

clear

load lithk_A5
ln=li.n-4;

aexp = 'exp05';

% masking out ellismere and island
mm = ncload('../Data/maxmask1_05000m.nc');
maxmask0 = mm.maxmask1;
% observed
obs=ncload('../Data/BM3_GrIS_nn_e05000m.nc'); 
%obs.mask = double(obs.lithk>1).*maxmask0;

eval(['mdat = li.' aexp '{1}.dd_lithk*0.0;']);
mdat(find(isnan(mdat))) = 0.0;

mdat3 = zeros([ln, size(mdat)]);

for i=1:ln
    test = eval(['isfield(li.' aexp '{i}, ''dd_lithk'')']);
    if test
        eval(['dat = li.' aexp '{i}.dd_lithk.*maxmask0;']);
        dat(find(isnan(dat))) = 0.0;
        mdat3(i,:,:) = dat;
    else
        disp(['missing ' li.igrpmod{i} ])
    end
end
mdat = mean(mdat3,1);
vdat = var(mdat3,0,1);
sdat = std(mdat3,0,1);

% mean
shade_nt(mdat)
load cmap/cmap_polar1-6.mat
colormap(cmap)
cb = colorbar;
set(cb,'FontSize', 20)
caxis([-250,50])
hold on
contour(obs.sftgif',[0.5,0.5],'k')
hold off
text(352,-20,'m','Interpreter','Tex','FontSize',20)
print('-r300','-dpng', ['Figures/A5_ff_' aexp '_dd_lithk_mean' '_' num2str(ln)] );

% std
shade_nt(sdat)
load cmap/cmap_gradient.mat
colormap(cmap)
cb = colorbar;
set(cb,'FontSize', 20)
caxis([0,200])
hold on
contour(obs.sftgif',[0.5,0.5],'k')
hold off
text(352,-20,'m','Interpreter','Tex','FontSize',20)
print('-r300','-dpng', ['Figures/A5_ff_' aexp '_dd_lithk_std' '_' num2str(ln)] );
