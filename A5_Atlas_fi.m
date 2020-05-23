% plot ISMIP6 results

clear

load lithk_A5

% labs names/ models list
load set_default.mat

% load observations
obs=ncload('../Data/BM3_GrIS_nn_e05000m.nc'); 
obsmsk=obs.sftgif;


spy=31556926;

sfvv = @(x) sign(x).*x.^5;
desfvv = @(x) sign(x).*abs(x).^(1/5);

sfsmb= @(x) max(x,0)*2+min(x,0)*1;
dsfsmb= @(x) max(x,0)/2+min(x,0)*1;

mm = ncload('../Data/maxmask1_05000m.nc');
maxmask1 = mm.maxmask1;
maxmask0 = maxmask1;
maxmask0(find(maxmask0==0)) = NaN;

% flag save png 
fbg=1;
fpng=1;
fcls=1;

%vars={'acabf','dlithkdt','hfgeoubed','libmassbffl','libmassbfgr','licalvf','litempbot','litempsnic','lithk','orog','sftgrf','sftflf','sftgif','lithk0','strbasemag','topg','velbase','velmean','velsurf','wvelbase','wvelsurf'};

%vars={'acabf'};
%vars={'lithk'};
%vars={'orog'};%
%vars={'velmean'};
%vars={'sftgif'};
%vars={'sftgrf'};

vars={'acabf','lithk','orog','velmean','sftgif','sftgrf','topg'};


%vars={'acabf','lithk','orog','velmean'};

%vars={'topg','sftgif','sftgrf'};%
%

for k=1:li.n
%
%for k=[19,21]
    %for k=16

    % ice mask nan
    ima=(single(li.historical{k}.lithk>1.5)./single(li.historical{k}.lithk>1.5));
    % ice mask for contour
    imac=single(li.historical{k}.lithk>1.5);
    dat=zeros(size(ima));
    mmask = li.historical{k}.sftgif;
    mmask(mmask<1) = nan;
% lithk
if any(strcmp(vars,'lithk'))
    if isfield(li.historical{k}, 'lithk')
        dat=li.historical{k}.lithk.*ima.*maxmask0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end; 
        hold on
        contour(dat',0:500:3500,'k')
        hold off
        caxis([0 3500])
        load cmap/cmap_lowwhite
        colormap(cmap)
        colorbar off
        title([papgrpmod{k}])
         set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_lithk_', papgrpmod{k}]); end
    if (fcls); close; end
end        
    
% orog
if any(strcmp(vars,'orog'))
    if isfield(li.historical{k}, 'orog')
        dat=li.historical{k}.orog.*maxmask0;
        %dat(find(li.historical{k}.sftgif<0.1))=nan;
        dat(find(li.historical{k}.sftgrf<0.1))=nan;
%        dat=li.historical{k}.orog.*obsmsk;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end;
        hold on
        %contour(dat',0:500:3500,'k')
        contour(dat',500:500:3500,'k')
% contour ice mask
%        contour(imac',[0.5,0.5],'r', 'LineWidth',1)

        hold off
        caxis([0 3500])
        load cmap/cmap_lowwhite
        colormap(cmap)
        colorbar off
        title([papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[m]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title([papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_orog_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% topg
if any(strcmp(vars,'topg'))
    if isfield(li.historical{k}, 'topg')
        dat=li.historical{k}.topg;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([-500 3000])
        load cmap/cmap_topg
        colormap(cmap)
        colorbar off
        title(['topg init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['topg init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_topg_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% ice mask: lithk > 1.
if any(strcmp(vars,'lithk0'))
    if isfield(li.historical{k}, 'lithk')
        dat=li.historical{k}.lithk.*(li.historical{k}.lithk>1.5) > 0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
%        hold on
%        contour(dat','k')
%        hold off
        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['lithk>1 init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk>1 init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_lithk0_', papgrpmod{k}]); end
    if (fcls); close; end
end

% ice mask
if any(strcmp(vars,'sftgif'))
    if isfield(li.historical{k}, 'sftgif')
        dat=li.historical{k}.sftgif.*maxmask0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([0 1])
%        hold on
%        contour(dat','k')
%        hold off
        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['sftgif init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['sftgif init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_sftgif_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% grounded mask
if any(strcmp(vars,'sftgrf'))
    if isfield(li.historical{k}, 'sftgrf')
        dat=li.historical{k}.sftgrf.*maxmask0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([0 1])
%        hold on
%        contour(dat','k')
%        hold off
        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['sftgrf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['sftgrf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_sftgrf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% shelf mask
if any(strcmp(vars,'sftflf'))
    if isfield(li.historical{k}, 'sftflf')
        dat=li.historical{k}.sftflf.*maxmask0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([0 1])
        hold on
%        contour(dat','k')
%        hold off
%        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['sftflf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['sftflf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_sftflf_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% surface velocity
if any(strcmp(vars,'velsurf'))
    if isfield(li.historical{k}, 'velsurf')
        dat=(li.historical{k}.velsurf(:,:)).*maxmask0;
        if (fbg); nanshade_bg_nb(log10(dat*spy+0.01).*ima); else; nanshade_nb(log10(dat*spy+0.01).*ima); end;
%        if (fbg); nanshade_bg(log10(dat*spy+0.01).*ima); else; nanshade(log10(dat*spy+0.01).*ima); end;
        hcb = colorbar;
        colormap('jet')
        caxis([-1,4])
        ticksd = [-1:1:4];
        ticks = 10.^(ticksd);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title([papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['velsurf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_velsurf_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% mean velocity
if any(strcmp(vars,'velmean'))
    if isfield(li.historical{k}, 'velmean')
        dat=(li.historical{k}.velmean(:,:)).*mmask.*maxmask0;
        if (fbg); nanshade_bg_nb(log10(dat*spy+0.01).*ima); else; nanshade_nb(log10(dat*spy+0.01).*ima); end;
        hcb = colorbar;
        colormap('jet')
        caxis([-1,4])
        ticksd = [-1:1:4];
        ticks = 10.^(ticksd);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title([papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['velmean init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_velmean_', papgrpmod{k}]); end
    if (fcls); close; end
end

% basal velocity
if any(strcmp(vars,'velbase'))
    if isfield(li.historical{k}, 'velbase')
        dat=(li.historical{k}.velbase(:,:)).*maxmask0;
        if (fbg); nanshade_bg_nb(log10(dat*spy+0.01).*ima); else; nanshade_nb(log10(dat*spy+0.01).*ima); end;
        hcb = colorbar;
        colormap('jet')
        caxis([-1,4])
        ticksd = [-1:1:4];
        ticks = 10.^(ticksd);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title(['velbase init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['velbase init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_velbase_', papgrpmod{k}]); end
    if (fcls); close; end
end

% vertical surface velocity
if any(strcmp(vars,'wvelsurf'))
    if isfield(li.historical{k}, 'wvelsurf')
        dat=li.historical{k}.wvelsurf(:,:)*spy;
        datd=desfvv(dat);
        if (fbg); nanshade_bg_nb(datd.*ima); else; nanshade_nb(datd.*ima); end;
        load cmap/cmap_polar
        load cmap/cmap_rg
        colormap(cmap)
        hcb = colorbar;
        caxis([desfvv(-1000),desfvv(1000)])
        ticks=[-1000 -100 -10 -1 -0.1 0.1 1 10 100 1000];
        ticksd=desfvv(ticks);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title(['wvelsurf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['wvelsurf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_wvelsurf_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% vertical base velocity
if any(strcmp(vars,'wvelbase'))
    if isfield(li.historical{k}, 'wvelbase')
        dat=li.historical{k}.wvelbase(:,:)*spy;
        datd=desfvv(dat);
        if (fbg); nanshade_bg_nb(datd.*ima); else; nanshade_nb(datd.*ima); end;
        load cmap/cmap_polar
        load cmap/cmap_rg
        colormap(cmap)
        hcb = colorbar;
        caxis([desfvv(-1000),desfvv(1000)])
        ticks=[-1000 -100 -10 -1 -0.1 0.1 1 10 100 1000];
        ticksd=desfvv(ticks);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title(['wvelbase init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['wvelbase init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_wvelbase_', papgrpmod{k}]); end
    if (fcls); close; end
end

% strbasemag
if any(strcmp(vars,'strbasemag'))
    if isfield(li.historical{k}, 'strbasemag')
        dat=li.historical{k}.strbasemag.*ima;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        title(['strbasemag init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        caxis([0,200000])
        colorbar off
        xlabel('[Pa]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['strbasemag init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_strbasemag_', papgrpmod{k}]); end
    if (fcls); close; end
end

% acabf
if any(strcmp(vars,'acabf'))
    if isfield(li.historical{k}, 'acabf')
        if isfield(li.historical{k}, 'sftgrf')
        dat=(li.historical{k}.acabf.*li.historical{k}.sftgrf*spy/910.).*maxmask0;
        else
        dat=li.historical{k}.acabf.*ima*spy/910.;
        end
        datd=sfsmb(dat);
        if (fbg); nanshade_bg_nb(datd.*ima); else; nanshade_nb(datd.*ima); end;
%        if (fbg); nanshade_bg(datd.*ima); else; nanshade(datd.*ima); end;
        load cmap/cmap_rb
        colormap(cmap)
        hcb = colorbar;
        caxis([-8 8])
        ticks=[-8 -6 -4 -2 0 1 2 3 4 ];
        ticksd=sfsmb(ticks);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title([papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[m i.e./yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['acabf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_acabf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% aplacabf
if any(strcmp(vars,'aplacabf'))
    if isfield(li.historical{k}, 'aplacabf')
        if isfield(li.historical{k}, 'sftgrf')
        dat=li.historical{k}.aplacabf.*li.historical{k}.sftgrf*spy/910.;
        else
        dat=li.historical{k}.aplacabf.*ima*spy/910.;
        end
        datd=sfsmb(dat);
        if (fbg); nanshade_bg_nb(datd.*ima); else; nanshade_nb(datd.*ima); end;
        load cmap/cmap_rb
        colormap(cmap)
        hcb = colorbar;
        caxis([-8 8])
        ticks=[-8 -6 -4 -2 0 1 2 3 4 ];
        ticksd=sfsmb(ticks);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title([papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[m i.e./yr]')
%        axis equal
    else
        dat=li.historical{k}.lithk.*ima;
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['aplacabf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_aplacabf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% libmassbf sheet
if any(strcmp(vars,'libmassbfgr'))
    if isfield(li.historical{k}, 'libmassbf')
        dat=li.historical{k}.libmassbf.*li.historical{k}.sftgrf;
        if (fbg); nanshade_bg(dat*spy/910.); else; nanshade(dat*spy/910.); end; 
        title(['libmassbf gr init ', papgrpmod{k}])
        load cmap/cmap_hiwhite
        colormap(cmap)
        ca=caxis;
        caxis([ca(1), 0]);
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m i.e./yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['libmassbf gr init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_libmassbfgr_', papgrpmod{k}]); end
    if (fcls); close; end
end

% libmassbf shelf
if any(strcmp(vars,'libmassbffl'))
    if isfield(li.historical{k}, 'libmassbf')
        dat=li.historical{k}.libmassbf.*li.historical{k}.sftflf;
        if (fbg); nanshade_bg(dat*spy/910.); else; nanshade(dat*spy/910.); end; 
        title(['libmassbf fl init ', papgrpmod{k}])
        load cmap/cmap_hiwhite
        colormap(cmap)
        ca=caxis;
        caxis([ca(1), 0]);
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m i.e./yr]')
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['libmassbf fl init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_libmassbffl_', papgrpmod{k}]); end
    if (fcls); close; end
end


% licalvf
if any(strcmp(vars,'licalvf'))
    if isfield(li.historical{k}, 'licalvf')
        dat=li.historical{k}.licalvf;
        if (fbg); nanshade_bg(dat*spy/910.); else; nanshade(dat*spy/910.); end;
        title(['licalvf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m i.e./yr]')
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['licalvf init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_licalvf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% litempsnic
if any(strcmp(vars,'litempsnic'))
    if isfield(li.historical{k}, 'litempsnic')
%        if isfield(li.historical{k}, 'sftgif')
%            dat=(li.historical{k}.litempsnic-273.15)./li.historical{k}.sftgif;
%        else
            dat=(li.historical{k}.litempsnic-273.15).*ima;
%        end
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        hold on
        contour(dat',[-35:5:5],'k')
        hold off
        caxis([-35 5])
        colorbar off
        title(['litempsnic init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[K]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['litempsnic init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_litempsnic_', papgrpmod{k}]); end
    if (fcls); close; end
end

% litempbot
if any(strcmp(vars,'litempbot'))
    if isfield(li.historical{k}, 'litempbot')
%        if isfield(li.historical{k}, 'sftgif')
%            dat=(li.historical{k}.litempbot-273.15)./li.historical{k}.sftgif;
%        else
            dat=(li.historical{k}.litempbot-273.15).*ima;
%        end
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([-20 5])
        title(['litempbot init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[K]')
        colorbar off
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['litempbot init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_litempbot_', papgrpmod{k}]); end
    if (fcls); close; end
end

% dlithkdt
if any(strcmp(vars,'dlithkdt'))
    if isfield(li.historical{k}, 'dlithkdt')
        dat=li.historical{k}.dlithkdt.*ima;
        if (fbg); nanshade_bg(dat*spy); else; nanshade(dat*spy); end;
        title(['dlithkdt init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['dlithkdt init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_dlithkdt_', papgrpmod{k}]); end
    if (fcls); close; end
end

% hfgeoubed
if any(strcmp(vars,'hfgeoubed'))
    if isfield(li.historical{k}, 'hfgeoubed')
        dat=li.historical{k}.hfgeoubed.*ima;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
        hold on
        contour(dat',[0:0.02:0.16],'k')
        hold off
        caxis([0 0.16])
        title(['hfgeoubed init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[W/m2]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['hfgeoubed init ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_fi/A5_historical_hfgeoubed_', papgrpmod{k}]); end
    if (fcls); close; end
end

end
% end model loop
