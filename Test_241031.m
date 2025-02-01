%%% Test_241008
clc; clear all; close all;

%% 정선 관측 날짜의 SST+유속 (HYCOM 자료) > subplot으로 저장
clc; clear all; close all;

% HYCOM 변수
load('.\HYCOM_data\2007\hycES_2007_02_15_00_Reanalysis.mat');
sst_0215 = hyc.temp(:,:,1);
u_0215 = hyc.u(:,:,1);
v_0215 = hyc.v(:,:,1);
ssh_0215 = hyc.ssh;

load('.\HYCOM_data\2007\hycES_2007_04_15_00_Reanalysis.mat');
sst_0415 = hyc.temp(:,:,1);
u_0415 = hyc.u(:,:,1);
v_0415 = hyc.v(:,:,1);

load('.\HYCOM_data\2007\hycES_2007_06_15_00_Reanalysis.mat');
sst_0615 = hyc.temp(:,:,1);
u_0615 = hyc.u(:,:,1);
v_0615 = hyc.v(:,:,1);

load('.\HYCOM_data\2007\hycES_2007_08_15_00_Reanalysis.mat');
sst_0815 = hyc.temp(:,:,1);
u_0815 = hyc.u(:,:,1);
v_0815 = hyc.v(:,:,1);

load('.\HYCOM_data\2007\hycES_2007_10_15_00_Reanalysis.mat');
sst_1015 = hyc.temp(:,:,1);
u_1015 = hyc.u(:,:,1);
v_1015 = hyc.v(:,:,1);

load('.\HYCOM_data\2007\hycES_2007_12_15_00_Reanalysis.mat');
sst_1215 = hyc.temp(:,:,1);
u_1215 = hyc.u(:,:,1);
v_1215 = hyc.v(:,:,1);

lat = hyc.lat;
lon = hyc.lon;

day_indices = {'2007-02-15', '2007-04-15', '2007-06-15', '2007-08-15', '2007-10-15', '2007-12-15'};

figure;
set(gcf, 'Position', [100, 100, 800, 1000]);
tiledlayout(3, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

step = 3;

% 0215
subplot(3, 2, 1);
pcolor(lon, lat, sst_0215');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       u_0215(1:step:end, 1:step:end)', v_0215(1:step:end, 1:step:end)', ...
       'color', 'k', 'autoscale', 'on');
ylabel('Latitude');
title(day_indices{1});  

% 0415
subplot(3, 2, 2);
pcolor(lon, lat, sst_0415');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       u_0415(1:step:end, 1:step:end)', v_0415(1:step:end, 1:step:end)', ...
       'color', 'k', 'autoscale', 'on');
title(day_indices{2});  

% 0615
subplot(3, 2, 3);
pcolor(lon, lat, sst_0615');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       u_0615(1:step:end, 1:step:end)', v_0615(1:step:end, 1:step:end)', ...
       'color', 'k', 'autoscale', 'on');
ylabel('Latitude');
title(day_indices{3});  

% 0815
subplot(3, 2, 4);
pcolor(lon, lat, sst_0815');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       u_0815(1:step:end, 1:step:end)', v_0815(1:step:end, 1:step:end)', ...
       'color', 'k', 'autoscale', 'on');
title(day_indices{4});  

% 1015
subplot(3, 2, 5);
pcolor(lon, lat, sst_1015');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       u_1015(1:step:end, 1:step:end)', v_1015(1:step:end, 1:step:end)', ...
       'color', 'k', 'autoscale', 'on');
xlabel('Longitude');
ylabel('Latitude');
title(day_indices{5});  

% 1215
subplot(3, 2, 6);
pcolor(lon, lat, sst_1215');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       u_1215(1:step:end, 1:step:end)', v_1215(1:step:end, 1:step:end)', ...
       'color', 'k', 'autoscale', 'on');
xlabel('Longitude');
title(day_indices{6});  

% 공통 컬러바 추가
colormap('jet')
h = colorbar;
h.Position = [0.92, 0.1, 0.02, 0.8];  
h.Label.String = 'HYCOM SST (°C)';

sgtitle(['HYCOM SST with Current']);  % 공통 타이틀

% 파일 저장
saveas(gcf, 'HYCOM_SST_with_current_subplots.png');


%% 정선 관측 날짜의 SST와 유속 확인 > subplot 저장
clc; clear all; close all;

load('OSTIA_SST_daily_2007.mat');
load('coastline_around_Korea.mat');
load('ADT_geovel_daily_2007.mat');

% SST 변수
lons_idx = find(lons >= 127.0 & lons <= 135);
lats_idx = find(lats >= 34.0 & lats <= 40);
lons = lons(lons_idx);
lats = lats(lats_idx);

% ADT 변수
lon_idx = find(lon >= 127.0 & lon <= 135);
lat_idx = find(lat >= 34.0 & lat <= 40);
lon = lon(lon_idx);
lat = lat(lat_idx);

time_indices = [46, 105, 166, 227, 288, 349]; % 정선 관측 날짜 index
day_indices = {'2007-02-15', '2007-04-15', '2007-06-15', '2007-08-15', '2007-10-15', '2007-12-15'};
num_plots = length(time_indices);

figure;
set(gcf, 'Position', [100, 100, 800, 1000]);
tiledlayout(3, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

for i = 1:length(time_indices)
    time_idx = time_indices(i);
    sst_for_time = ssts(lons_idx, lats_idx, time_idx);
    wu10_for_time = ug(lon_idx, lat_idx, time_idx);
    wv10_for_time = vg(lon_idx, lat_idx, time_idx);

    subplot(3, 2, i);
    pcolor(lons, lats, sst_for_time');
    shading interp;
    caxis([0, 25]);

    hold on;
    quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'on')
    plot(cllon, cllat, '.k');
    shading interp;
    
    if mod(i, 2) == 1
        ylabel('Latitude');
    end
    if i > 4
        xlabel('Longitude');
    end
    title(day_indices{i});  
end

% 공통 컬러바 추가
colormap('jet')
h = colorbar;
h.Position = [0.92, 0.1, 0.02, 0.8];  
h.Label.String = 'SST (°C)';

sgtitle(['SST with Current']);  % 공통 타이틀

% 파일 저장
saveas(gcf, 'SST_with_current_subplots.png');  
