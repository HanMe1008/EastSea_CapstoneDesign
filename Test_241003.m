% Test_241003
clc; clear all; close all;

load('SST_daily_2007.mat')  % 표층 수온 자료
load('ADT_geovel_daily_2007.mat')   % ADT 자료(표층 유속)
% load('CTD_bimonthly_2007.mat')  % 해양 표층-500m 수온, 염분 자료
load('ESROB_daily_2007.mat')    % Mooring 자료
load('Wind_surf_daily_2007.mat')    % 표층 바람자료
load('Radiation_surf_daily_2007.mat')   % 표층 복사량자료


%%% 표층 수온 자료
time_idx = 166;
sst_for_time = ssts(:, :, time_idx);

figure;
pcolor(lons, lats, sst_for_time');  
% MATLAB은 pcolor 함수에서 첫 번째 차원을 y축(위도)으로, 두 번째 차원을 x축(경도)으로 처리
% sst_for_time'로 전치 연산을 하면, 원래 (경도, 위도) 구조였던 데이터가 (위도, 경도)로 바뀌어 MATLAB의 그래프 함수가 데이터를 올바르게 해석
shading interp;
colormap("jet")
colorbar;

xlabel('Longitude');
ylabel('Latitude');
title('SST')


%%% ADT 자료(표층 유속)
time_idx = 166;
ug_for_time = ug(:, :, time_idx);
vg_for_time = vg(:, :, time_idx);
adt_for_time = adt(:, :, time_idx);

figure;
pcolor(lon, lat, adt_for_time');
shading interp;
colorbar;
hold on;
quiver(lon, lat, ug_for_time', vg_for_time', 'color', 'k', 'autoscale', 'on')
xlabel('Longitude');
ylabel('Latitude');
title('ADT')


%%% 수온, 염분 자료 (표층-500m)
% 구조체 자료 어떻게 다뤄야하는지


%%% Mooring 자료 
dates = datetime(timest(:, 1), timest(:, 2), timest(:, 3), ...
                 timest(:, 4), timest(:, 5), timest(:, 6));
dates.Format = "MMM";

figure('Position', [100, 100, 1000, 300]);
plot(dates, zBP)
title('zBP')

figure('Position', [100, 100, 1000, 300]);
plot(dates, zTemp)
title('zTemp')

% zSpd?
zSpd = sqrt(wur.^2+wvr.*2);
zSpd = real(zSpd);
figure('Position', [100, 100, 1000, 300]);
plot(dates, zSpd)
title('zSpd')

% zWD?

figure('Position', [100, 100, 1000, 300]);
hold on;
plot(dates, temp(:,1));
plot(dates, temp(:,2));
plot(dates, temp(:,3));
plot(dates, temp(:,4));
plot(dates, temp(:,5));
hold off;
title('temp')

figure('Position', [100, 100, 1000, 300]);
hold on;
plot(dates, sal(:,1));
plot(dates, sal(:,2));
plot(dates, sal(:,3));
plot(dates, sal(:,4));
plot(dates, sal(:,5));
hold off;
title('sal')

figure('Position', [100, 100, 1000, 300]);
hold on;
for i = 1:size(ur, 2)
    plot(dates, ur(:, i));
end
hold off;

figure('Position', [100, 100, 1000, 300]);
hold on;
for i = 1:size(vr, 2)
    plot(dates, vr(:, i));
end
hold off;


%%% 표층 바람자료
time_idx = 200;
wu10_for_time = wu10(:, :, time_idx);
wv10_for_time = wv10(:, :, time_idx);
tair_for_time = tair(:, :, time_idx);

figure;
pcolor(lon, lat, tair_for_time')
shading interp;
colorbar;
hold on;
quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'AutoScale','on')


%%% 표층 복사량자료
time_idx = 220;
radl_for_time = radl(:, :, time_idx);
rads_for_time = rads(:, :, time_idx);
total_rad = radl_for_time + rads_for_time;

figure;
pcolor(lon, lat, rads_for_time');
shading interp;
colorbar;


