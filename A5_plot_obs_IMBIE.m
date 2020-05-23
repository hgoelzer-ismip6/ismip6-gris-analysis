% plot ISMIP6 results

clear

kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 

%iref = 27; % 2018
iref = 24; % 2015
%iref = 23; % 2014

% observed IMBIE
load IMBIE/imbie_gris.txt
itime = imbie_gris(:,1)';
idM = imbie_gris(:,2)';
%limi = cumsum(idM); 
limi = imbie_gris(:,4)';
dlimi = limi-limi(iref);

% errors
idMe = imbie_gris(:,3)';
limiecorr = cumsum(idMe); % errors correlated in time!
dlimiecorr = limiecorr-limiecorr(iref);
limie = imbie_gris(:,5)';
dlimie = limie-limie(iref);

dlimimax =  dlimi-dlimie;
dlimimin =  dlimi+dlimie;

dlimimaxcorr =  dlimi-dlimiecorr;
dlimimincorr =  dlimi+dlimiecorr;


nt = length(idM);
t = 1:nt;
denom = iref-t;
% calculate average SL rate per year
rate = (dlimi./denom/362.5);

figure
subplot(3,1,1)
bar(itime,-(idM)/362.5)
ylabel('SL rate (mm/yr)')
subplot(3,1,2)
bar(itime,dlimi)
ylabel('dlim (Gt)')
axis([1990 2019 0 5000])
subplot(3,1,3)
bar(itime,rate)
axis([1990 2019 0 1])
ylabel('average SL rate (mm/yr)')

% save
print('-r300','-dpng', ['Figures/A5_obs_rate_IMBIE']);
