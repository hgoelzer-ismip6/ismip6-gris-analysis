% plot asmb forcing

clear

spy=31556926;

% NOISM smb
da = ncload('/Volumes/ISMIP6/Projections/Greenland/NoISM/ismip6-gris-noism/Archive/ISMIP6/NOISM_ag/exp05_05/acabf_GIS_ISMIP6_NOISM_ag_exp05.nc');
dm = ncload('/Volumes/ISMIP6/Projections/Greenland/NoISM/ismip6-gris-noism/Archive/ISMIP6/NOISM_ag/exp05_05/sftgif_GIS_ISMIP6_NOISM_ag_exp05.nc');

asmb = mean(da.acabf(:,:,77:86),3);
mask = dm.sftgif(:,:,end);
scl = spy/1000;

shade_nt(asmb.*mask*scl)

load cmap/cmap_polar1-6.mat
colormap(cmap)
cb = colorbar;
set(cb,'FontSize', 20)
%caxis([-250,50])
caxis([-5,1])
text(280,-20,'m w.e. yr^{-1}','Interpreter','Tex','FontSize',26)
axis equal

print('-r300','-dpng', ['Figures/A5_shade_asmb_m2091-2100_NOISM'] );
