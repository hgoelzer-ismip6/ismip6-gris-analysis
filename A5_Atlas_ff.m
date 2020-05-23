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
maxmask0 = mm.maxmask1;

% flag save png 
fbg=1;
fpng=1;
fcls=1;

%vars={'acabf','dlithkdt','hfgeoubed','libmassbffl','libmassbfgr','licalvf','litempbot','litempsnic','lithk','orog','sftgrf','sftflf','sftgif','lithk0','strbasemag','topg','velbase','velmean','velsurf','wvelbase','wvelsurf'};

%vars = {'d_lithk'};
%vars = {'d_topg'};

%vars = {'dd_lithk'};
%vars={'iacabf'};
%vars={'dyncon'};

%vars = {'dd_lithk','iacabf','dyncon'};

%vars = {'dd_topg'};

%vars={'libmassbffl','libmassbfgr'};
%vars={'dlithkdt'};
%vars={'licalvf'};

%vars={'acabf'};
%vars={'lithk'};
%vars={'orog'};
%vars={'velmean'};
%vars={'sftgif'};
%vars={'sftgrf'};

%aexp = 'ctrl_proj';
%vars = {'d_lithk','d_topg'};
%vars={'acabf','lithk','orog','velmean','sftgif','sftgrf'};
%vars = {'d_lithk','d_topg','dd_lithk','iacabf','dyncon'};
%vars={'velmean'};


%aexp = 'exp05';
%vars = {'d_lithk','d_topg','dd_lithk','iacabf','dyncon'};

aexp = 'ctrl_proj';
vars = {'d_lithk','d_topg'};

for k=1:li.n
%
%for k=[19,21]
    %for k=5

    % ice mask nan
    ima=(single(li.exp05{k}.lithk>1.5)./single(li.exp05{k}.lithk>1.5));
    % ice mask for contour
    imac=single(li.exp05{k}.lithk>1.5);
    dat=zeros(size(ima));

% lithk
if any(strcmp(vars,'lithk'))
    if isfield(li.exp05{k}, 'lithk')
        dat=li.exp05{k}.lithk.*ima;
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
        title(['lithk ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_lithk_', papgrpmod{k}]); end
    if (fcls); close; end
end        
    
% orog
if any(strcmp(vars,'orog'))
    if isfield(li.exp05{k}, 'orog')
        dat=li.exp05{k}.orog.*maxmask0;
        %dat(find(li.exp05{k}.sftgif<0.1))=nan;
        dat(find(li.exp05{k}.sftgrf<0.1))=nan;
%        dat=li.exp05{k}.orog.*obsmsk;
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
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_orog_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% topg
if any(strcmp(vars,'topg'))
    if isfield(li.exp05{k}, 'topg')
        dat=li.exp05{k}.topg;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([-500 3000])
        load cmap/cmap_topg
        colormap(cmap)
        colorbar off
        title(['topg ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['topg ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_topg_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% ice mask: lithk > 1.
if any(strcmp(vars,'lithk0'))
    if isfield(li.exp05{k}, 'lithk')
        dat=li.exp05{k}.lithk.*(li.exp05{k}.lithk>1.5) > 0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
%        hold on
%        contour(dat','k')
%        hold off
        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['lithk>1 ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk>1 ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_lithk0_', papgrpmod{k}]); end
    if (fcls); close; end
end

% ice mask
if any(strcmp(vars,'sftgif'))
    if isfield(li.exp05{k}, 'sftgif')
        dat=li.exp05{k}.sftgif.*maxmask0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([0 1])
%        hold on
%        contour(dat','k')
%        hold off
        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['sftgif ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['sftgif ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_sftgif_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% grounded mask
if any(strcmp(vars,'sftgrf'))
    if isfield(li.exp05{k}, 'sftgrf')
        dat=li.exp05{k}.sftgrf.*maxmask0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([0 1])
%        hold on
%        contour(dat','k')
%        hold off
        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['sftgrf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['sftgrf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_sftgrf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% shelf mask
if any(strcmp(vars,'sftflf'))
    if isfield(li.exp05{k}, 'sftflf')
        dat=li.exp05{k}.sftflf.*maxmask0;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([0 1])
        hold on
%        contour(dat','k')
%        hold off
%        load cmap/cmap_mask
        colormap(cmap)
        colorbar off
        title(['sftflf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['sftflf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_sftflf_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% surface velocity
if any(strcmp(vars,'velsurf'))
    if isfield(li.exp05{k}, 'velsurf')
        dat=(li.exp05{k}.velsurf(:,:).*maxmask0);
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
        title(['velsurf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_velsurf_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% mean velocity
if any(strcmp(vars,'velmean'))
    if isfield(li.exp05{k}, 'velmean')
        dat=(li.exp05{k}.velmean(:,:));
        dat(find(maxmask0<1))=nan;
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
        title(['velmean ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_velmean_', papgrpmod{k}]); end
    if (fcls); close; end
end

% basal velocity
if any(strcmp(vars,'velbase'))
    if isfield(li.exp05{k}, 'velbase')
        dat=(li.exp05{k}.velbase(:,:));
        if (fbg); nanshade_bg_nb(log10(dat*spy+0.01).*ima); else; nanshade_nb(log10(dat*spy+0.01).*ima); end;
        hcb = colorbar;
        colormap('jet')
        caxis([-1,4])
        ticksd = [-1:1:4];
        ticks = 10.^(ticksd);
        set(hcb,'YTick',ticksd)
        set(hcb,'YTickLabel',round(ticks,2))
        colorbar off
        title(['velbase ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['velbase ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_velbase_', papgrpmod{k}]); end
    if (fcls); close; end
end

% vertical surface velocity
if any(strcmp(vars,'wvelsurf'))
    if isfield(li.exp05{k}, 'wvelsurf')
        dat=li.exp05{k}.wvelsurf(:,:)*spy;
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
        title(['wvelsurf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['wvelsurf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_wvelsurf_', papgrpmod{k}]); end
    if (fcls); close; end
end
    
% vertical base velocity
if any(strcmp(vars,'wvelbase'))
    if isfield(li.exp05{k}, 'wvelbase')
        dat=li.exp05{k}.wvelbase(:,:)*spy;
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
        title(['wvelbase ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['wvelbase ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_wvelbase_', papgrpmod{k}]); end
    if (fcls); close; end
end

% strbasemag
if any(strcmp(vars,'strbasemag'))
    if isfield(li.exp05{k}, 'strbasemag')
        dat=li.exp05{k}.strbasemag.*ima;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        title(['strbasemag ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        caxis([0,200000])
        colorbar off
        xlabel('[Pa]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['strbasemag ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_strbasemag_', papgrpmod{k}]); end
    if (fcls); close; end
end

% acabf
if any(strcmp(vars,'acabf'))
    if isfield(li.exp05{k}, 'acabf')
        if isfield(li.exp05{k}, 'sftgrf')
        dat=li.exp05{k}.acabf.*li.exp05{k}.sftgrf*spy/910.;
        else
        dat=li.exp05{k}.acabf.*ima*spy/910.;
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
        title(['acabf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_' aexp '_acabf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% aplacabf
if any(strcmp(vars,'aplacabf'))
    if isfield(li.exp05{k}, 'aplacabf')
        if isfield(li.exp05{k}, 'sftgrf')
        dat=li.exp05{k}.aplacabf.*li.exp05{k}.sftgrf*spy/910.;
        else
        dat=li.exp05{k}.aplacabf.*ima*spy/910.;
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
        dat=li.exp05{k}.lithk.*ima;
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['aplacabf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_aplacabf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% libmassbf sheet
if any(strcmp(vars,'libmassbfgr'))
    if isfield(li.exp05{k}, 'libmassbf')
        dat=li.exp05{k}.libmassbf.*li.exp05{k}.sftgrf;
        if (fbg); nanshade_bg(dat*spy/910.); else; nanshade(dat*spy/910.); end; 
        title(['libmassbf gr ', papgrpmod{k}])
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
        title(['libmassbf gr ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_libmassbfgr_', papgrpmod{k}]); end
    if (fcls); close; end
end

% libmassbf shelf
if any(strcmp(vars,'libmassbffl'))
    if isfield(li.exp05{k}, 'libmassbf')
        dat=li.exp05{k}.libmassbf.*li.exp05{k}.sftflf;
        if (fbg); nanshade_bg(dat*spy/910.); else; nanshade(dat*spy/910.); end; 
        title(['libmassbf fl ', papgrpmod{k}])
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
        title(['libmassbf fl ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_libmassbffl_', papgrpmod{k}]); end
    if (fcls); close; end
end


% licalvf
if any(strcmp(vars,'licalvf'))
    if isfield(li.exp05{k}, 'licalvf')
        dat=li.exp05{k}.licalvf;
        if (fbg); nanshade_bg(dat*spy/910.); else; nanshade(dat*spy/910.); end;
        title(['licalvf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m i.e./yr]')
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['licalvf ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_licalvf_', papgrpmod{k}]); end
    if (fcls); close; end
end

% litempsnic
if any(strcmp(vars,'litempsnic'))
    if isfield(li.exp05{k}, 'litempsnic')
%        if isfield(li.exp05{k}, 'sftgif')
%            dat=(li.exp05{k}.litempsnic-273.15)./li.exp05{k}.sftgif;
%        else
            dat=(li.exp05{k}.litempsnic-273.15).*ima;
%        end
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        hold on
        contour(dat',[-35:5:5],'k')
        hold off
        caxis([-35 5])
        colorbar off
        title(['litempsnic ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[K]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['litempsnic ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_litempsnic_', papgrpmod{k}]); end
    if (fcls); close; end
end

% litempbot
if any(strcmp(vars,'litempbot'))
    if isfield(li.exp05{k}, 'litempbot')
%        if isfield(li.exp05{k}, 'sftgif')
%            dat=(li.exp05{k}.litempbot-273.15)./li.exp05{k}.sftgif;
%        else
            dat=(li.exp05{k}.litempbot-273.15).*ima;
%        end
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end;
        caxis([-20 5])
        title(['litempbot ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[K]')
        colorbar off
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['litempbot ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_litempbot_', papgrpmod{k}]); end
    if (fcls); close; end
end

% dlithkdt
if any(strcmp(vars,'dlithkdt'))
    if isfield(li.exp05{k}, 'dlithkdt')
        dat=li.exp05{k}.dlithkdt.*ima;
        if (fbg); nanshade_bg(dat*spy); else; nanshade(dat*spy); end;
        title(['dlithkdt ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[m/yr]')
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['dlithkdt ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_dlithkdt_', papgrpmod{k}]); end
    if (fcls); close; end
end

% hfgeoubed
if any(strcmp(vars,'hfgeoubed'))
    if isfield(li.exp05{k}, 'hfgeoubed')
        dat=li.exp05{k}.hfgeoubed.*ima;
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
        hold on
        contour(dat',[0:0.02:0.16],'k')
        hold off
        caxis([0 0.16])
        title(['hfgeoubed ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[W/m2]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['hfgeoubed ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_hfgeoubed_', papgrpmod{k}]); end
    if (fcls); close; end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% d_

% d_lithk
if any(strcmp(vars,'d_lithk'))
    test = eval(['isfield(li.' aexp '{k}, ''d_lithk'')']);
    if test
        eval(['dat=li.' aexp '{k}.d_lithk.*ima.*maxmask0;']);
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end; 
        hold on
        %contour(dat',-500:100:50,'k')
        hold off
        load cmap/cmap_polar
        colormap(cmap)
        %%caxis([-500 500])
        caxis([-100 100])

        %load cmap/cmap_polar1-6.mat
        %colormap(cmap)
        %caxis([-250,50])

        colorbar off
        title([papgrpmod{k}])
         set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_' aexp '_d_lithk_', papgrpmod{k}]); end
    if (fcls); close; end
end        

% d_topg
if any(strcmp(vars,'d_topg'))
    test = eval(['isfield(li.' aexp '{k}, ''d_topg'')']);
    if test
        eval(['dat=li.' aexp '{k}.d_topg.*ima;']);
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end; 
        hold on
        %contour(dat',-500:100:50,'k')
        hold off
        load cmap/cmap_polar
        colormap(cmap)
        %%caxis([-500 500])
        caxis([-10 10])
        colorbar off
        title([papgrpmod{k}])
         set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_' aexp '_d_topg_', papgrpmod{k}]); end
    if (fcls); close; end
end        


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dd

% dd_lithk
if any(strcmp(vars,'dd_lithk'))
    test = eval(['isfield(li.' aexp '{k}, ''dd_lithk'')']);
    if test
        eval(['dat=li.' aexp '{k}.dd_lithk.*ima.*maxmask0;']);
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end; 
        hold on
        %contour(dat',-500:100:50,'k')
        hold off
        %load cmap/cmap_polar
        %colormap(cmap)
        %%caxis([-500 500])
        %caxis([-100 100])

        load cmap/cmap_polar1-6.mat
        colormap(cmap)
        caxis([-250,50])

        colorbar off
        title([papgrpmod{k}])
         set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_' aexp '_dd_lithk_', papgrpmod{k}]); end
    if (fcls); close; end
end        

% d_topg
if any(strcmp(vars,'dd_topg'))
    test = eval(['isfield(li.' aexp '{k}, ''dd_topg'')']);
    if test
        eval(['dat=li.' aexp '{k}.dd_topg.*ima;']);
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end; 
        hold on
        %contour(dat',-500:100:50,'k')
        hold off
        load cmap/cmap_polar
        colormap(cmap)
        %%caxis([-500 500])
        caxis([-10 10])
        colorbar off
        title([papgrpmod{k}])
         set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_' aexp '_dd_topg_', papgrpmod{k}]); end
    if (fcls); close; end
end        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% i

% iacabf
if any(strcmp(vars,'iacabf'))
    test = eval(['isfield(li.' aexp '{k}, ''iacabf'')']);
    if test
        eval(['dat=li.' aexp '{k}.iacabf.*ima/1000.*maxmask0;']);
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end; 
        hold on
        %contour(dat',-500:100:50,'k')
        hold off
        %load cmap/cmap_polar
        %colormap(cmap)
        %%caxis([-500 500])
        %caxis([-100 100])

        load cmap/cmap_polar1-6.mat
        colormap(cmap)
        caxis([-250,50])

        colorbar off
        title([papgrpmod{k}])
         set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['lithk ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_' aexp '_iacabf_', papgrpmod{k}]); end
    if (fcls); close; end
end        

% dyncon
if any(strcmp(vars,'dyncon'))
    test = eval(['isfield(li.' aexp '{k}, ''dyncon'')']);
    if test
        eval(['dat=li.' aexp '{k}.dyncon.*ima.*maxmask0;']);
        if (fbg); nanshade_bg_nb(dat); else; nanshade_nb(dat); end; 
%        if (fbg); nanshade_bg(dat); else; nanshade(dat); end; 
        hold on
        %contour(dat',-500:100:50,'k')
        hold off
        load cmap/cmap_polar
        colormap(cmap)
        %%caxis([-500 500])
        %caxis([-100 100])
        caxis([-50 50])

        %load cmap/cmap_polar1-6.mat
        %colormap(cmap)
        %caxis([-250,50])

        colorbar off
        title([papgrpmod{k}])
         set(gca,'XTick',[])
        set(gca,'YTick',[])
%        xlabel('[miss]')
%        axis equal
    else
        if (fbg); shade_bg(zeros(size(dat))); else; shade(zeros(size(dat))); end;
        colormap('white')
        title(['dyncon ', papgrpmod{k}])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        xlabel('[miss]')
    end
    if (fpng); print('-r300','-dpng', ['Figures/Atlas_ff/A5_' aexp '_dyncon_', papgrpmod{k}]); end
    if (fcls); close; end
end        



end
% end model loop
