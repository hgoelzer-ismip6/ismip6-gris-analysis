% plot ISMIP6 results

clear


kg2mmsl=-1e-12/362.5; 
kg2Gt=1e-12; 

ylab='Ice mass change [Gt]';

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

mtime=1972:2018;
dD = sum(Dreg);
dS = sum(Sreg);

dM = (dS-dD); % mass rate
dSL = (dD-dS); % SL rate

%iref = 47; % 2018
%iref = 44; % 2015
iref = 43; % 2014

% Mass evolution
limm19 = (cumsum(dS) - cumsum(dD));
% relative to reference year
dlimm19 = limm19 - limm19(iref);

% lim evolution until 0 at 2014
%dlim = dlimm19(1:iref);
%dtime=1972:2014;

%dlim = dlimm19(1:end);
%dtime = mtime;


nt = length(dSL);
t = 1:nt;
denom = iref-t;
% calculate average SL rate per year
rate = (dlimm19./denom/362.5);

figure
subplot(3,1,1)
bar(mtime,-(dS-dD)/362.5)
ylabel('SL rate (mm/yr)')
subplot(3,1,2)
bar(mtime,dlimm19)
ylabel('dlim (Gt)')
axis([1971 2019 0 5000])
subplot(3,1,3)
bar(mtime,rate)
axis([1971 2019 0 1])
ylabel('average SL rate (mm/yr)')

% save
print('-r300','-dpng', ['Figures/A5_obs_rate']);
