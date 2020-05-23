clear;

scenarios = {'MIROC5-rcp26-Rmed',...
        'MIROC5-rcp85-Rmed',...
        'NorESM1-rcp85-Rmed',...
        'HadGEM2-ES-rcp85-Rmed',...
        'MIROC5-rcp85-Rhigh',...
        'MIROC5-rcp85-Rlow'};

expnames = {'exp07',...
            'exp05',...
            'exp06',...
            'exp08',...
            'exp09',...
            'exp10'};

sectors = {'NO','NE','SE','SW','CW','NW'};
labels = {'MIROC5 RCP2.6','MIROC5 RCP8.5','NorESM RCP8.5','HadGEM RCP8.5'};
cols = {'k','m','b','r'};
c7 = [0.635,0.078,0.184];
fn = 'Helvetica Narrow';
fi = 'tex';
fs = 7;


%load ../numcr_basinR_A5.mat
%modsel = [24]
%for i=1:length(scenarios),
%    eval([ 'm = numcr_bas.' expnames{i} ';' ]);
%    for j=1:6,
%        a(i,j) = -mean((m(modsel,j)))*1000; % SLE in mm
%    end
%end
%save attribution_smb a
load attribution_smb


figure(1);
for i=1:size(a,2),
    subplot(4,6,i+12); hold on;
    for j=1:4,
        p(j) = bar(j,a(j,i),'facecolor',cols{j});
    end
    %for j=5:5,
    %   errorbar(2,a(2,i),a(2,i)-a(j+1,i),a(j,i)-a(2,i),'color',c7);
    %end
    title(sectors{i},'fontsize',fs,'fontname',fn,'interpreter',fi);
    xlim([0 5]);
    ylim([0 40]);
    set(gca,'box','on','fontsize',fs,'fontname',fn,'ticklabelinterpreter',fi,'xtick',[]);
    if i==1,
        ylabel({'Integrated SMB' ; 'anomaly (mm SLE)'},'fontsize',fs,'fontname',fn,'interpreter',fi);
    end
%    if i==6,
%        l = legend(p,labels,'fontsize',fs,'fontname',fn,'interpreter',fi,'box','off');
%        set(l,'position',[0.83,0.3,0,0]);
%    end
end
%saveplot(17,10,300,'area_retreat.png');
%close all;

%print('-dpng','-r300','attribibution_smb.png');
