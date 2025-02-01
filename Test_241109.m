%%% Test_241109
clc; clear all; close all;

%% GLORYS 자료 SST with Current > subplot 저장

% 파일 경로 설정
glo_0215 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20070215.nc'; 
glo_0415 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20070415.nc'; 
glo_0615 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20070615.nc'; 
glo_0815 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20070815.nc'; 
glo_1015 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20071015.nc'; 
glo_1215 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20071215.nc';  

% 파일 내용 확인 (변수 목록, 차원 정보 등)
ncdisp(glo_0615);

% 공통변수
depth = ncread(glo_0215, 'depth');
lat = ncread(glo_0215, 'latitude');
lon = ncread(glo_0215, 'longitude');

% 0215
sal_0215 = ncread(glo_0215, 'so');   % salinity
temp_0215 = ncread(glo_0215, 'thetao');   % potential temperature
sst_0215 = temp_0215(:,:,1);     % sea surface temperature
uo_0215 = ncread(glo_0215, 'uo');    % eastward velocity
vo_0215 = ncread(glo_0215, 'vo');    % northward velocity
zos_0215 = ncread(glo_0215, 'zos');  % % sea surface height

% 0415
sal_0415 = ncread(glo_0415, 'so');
temp_0415 = ncread(glo_0415, 'thetao');
sst_0415 = temp_0415(:,:,1);
uo_0415 = ncread(glo_0415, 'uo');
vo_0415 = ncread(glo_0415, 'vo');
zos_0415 = ncread(glo_0415, 'zos');

% 0615
sal_0615 = ncread(glo_0615, 'so');
temp_0615 = ncread(glo_0615, 'thetao');
sst_0615 = temp_0615(:,:,1);
uo_0615 = ncread(glo_0615, 'uo');
vo_0615 = ncread(glo_0615, 'vo');
zos_0615 = ncread(glo_0615, 'zos');

% 0815
sal_0815 = ncread(glo_0815, 'so');
temp_0815 = ncread(glo_0815, 'thetao');
sst_0815 = temp_0815(:,:,1);
uo_0815 = ncread(glo_0815, 'uo');
vo_0815 = ncread(glo_0815, 'vo');
zos_0815 = ncread(glo_0815, 'zos');

% 1015
sal_1015 = ncread(glo_1015, 'so');
temp_1015 = ncread(glo_1015, 'thetao');
sst_1015 = temp_1015(:,:,1);
uo_1015 = ncread(glo_1015, 'uo');
vo_1015 = ncread(glo_1015, 'vo');
zos_1015 = ncread(glo_1015, 'zos');

% 1215
sal_1215 = ncread(glo_1215, 'so');
temp_1215 = ncread(glo_1215, 'thetao');
sst_1215 = temp_1215(:,:,1);
uo_1215 = ncread(glo_1215, 'uo');
vo_1215 = ncread(glo_1215, 'vo');
zos_1215 = ncread(glo_1215, 'zos');

% 시각화
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
       uo_0215(1:step:end, 1:step:end, 1)', vo_0215(1:step:end, 1:step:end, 1)', ...
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
       uo_0415(1:step:end, 1:step:end, 1)', vo_0415(1:step:end, 1:step:end, 1)', ...
       'color', 'k', 'autoscale', 'on');
title(day_indices{2});  

% 0615
subplot(3, 2, 3);
pcolor(lon, lat, sst_0615');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       uo_0615(1:step:end, 1:step:end, 1)', vo_0615(1:step:end, 1:step:end, 1)', ...
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
       uo_0815(1:step:end, 1:step:end, 1)', vo_0815(1:step:end, 1:step:end, 1)', ...
       'color', 'k', 'autoscale', 'on');
title(day_indices{4});  

% 1015
subplot(3, 2, 5);
pcolor(lon, lat, sst_1015');
shading interp;
caxis([0, 25]);

hold on;
quiver(lon(1:step:end, 1:step:end), lat(1:step:end, 1:step:end), ...
       uo_1015(1:step:end, 1:step:end, 1)', vo_1015(1:step:end, 1:step:end, 1)', ...
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
       uo_1215(1:step:end, 1:step:end, 1)', vo_1215(1:step:end, 1:step:end, 1)', ...
       'color', 'k', 'autoscale', 'on');
xlabel('Longitude');
title(day_indices{6});  

% 공통 컬러바 
colormap('jet')
h = colorbar;
h.Position = [0.92, 0.1, 0.02, 0.8];  
h.Label.String = 'GLORYS SST (°C)';

sgtitle(['GLORYS SST with Current']); 

% 파일 저장
saveas(gcf, 'GLORYS_SST_with_current_subplots.png');  

%% GLORYS 자료 Line별 {Temp} > subplot 저장 (GLORYS_Temp_Line_NUM_subplot)
clc; clear all; close all;

% 정선자료
load('CTD_bimonthly_2007.mat')
ctd_103_lat = ctd{5}.lat;
ctd_103_lon = ctd{5}.lon;
ctd_104_lat = ctd{6}.lat;
ctd_104_lon = ctd{6}.lon;
ctd_105_lat = ctd{7}.lat;
ctd_105_lon = ctd{7}.lon;
ctd_106_lat = ctd{8}.lat;
ctd_106_lon = ctd{8}.lon;

% GLORYS 자료 
glo_0415 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20070415.nc'; 
glo_0615 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20070615.nc'; 
glo_0815 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20070815.nc'; 
glo_1015 = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_20071015.nc'; 

depth = ncread(glo_0415, 'depth');
lat = ncread(glo_0415, 'latitude');
lon = ncread(glo_0415, 'longitude');

% 0415 data
sal_0415 = ncread(glo_0415, 'so');
temp_0415 = ncread(glo_0415, 'thetao');
% uo_0415 = ncread(glo_0415, 'uo');
% vo_0415 = ncread(glo_0415, 'vo');
% zos_0415 = ncread(glo_0415, 'zos');

% 0615 data
sal_0615 = ncread(glo_0615, 'so');
temp_0615 = ncread(glo_0615, 'thetao');
% uo_0615 = ncread(glo_0615, 'uo');
% vo_0615 = ncread(glo_0615, 'vo');
% zos_0615 = ncread(glo_0615, 'zos');

% 0815 data
sal_0815 = ncread(glo_0815, 'so');
temp_0815 = ncread(glo_0815, 'thetao');
% uo_0815 = ncread(glo_0815, 'uo');
% vo_0815 = ncread(glo_0815, 'vo');
% zos_0815 = ncread(glo_0815, 'zos');

% 1015 data
sal_1015 = ncread(glo_1015, 'so');
temp_1015 = ncread(glo_1015, 'thetao');
% uo_1015 = ncread(glo_1015, 'uo');
% vo_1015 = ncread(glo_1015, 'vo');
% zos_1015 = ncread(glo_1015, 'zos');

% lon&lat indexing
[~, lat_103_idx] = min(abs(lat - ctd_103_lat(1)));
[~, lat_104_idx] = min(abs(lat - ctd_104_lat(1)));
[~, lat_105_idx] = min(abs(lat - ctd_105_lat(1)));
[~, lat_106_idx] = min(abs(lat - ctd_106_lat(1)));

lon_103_idx = find(lon >= min(ctd_103_lon) & lon <= max(ctd_103_lon));
lon_104_idx = find(lon >= min(ctd_104_lon) & lon <= max(ctd_104_lon));
lon_105_idx = find(lon >= min(ctd_105_lon) & lon <= max(ctd_105_lon));
lon_106_idx = find(lon >= min(ctd_106_lon) & lon <= max(ctd_106_lon));

lon_103_range = lon(lon_103_idx);
lon_104_range = lon(lon_104_idx);
lon_105_range = lon(lon_105_idx);
lon_106_range = lon(lon_106_idx);

depth_idx = 1:32; 
depth_range = depth(depth_idx);

dates = {temp_0415, temp_0615, temp_0815, temp_1015};
day_indices = {'2007-04-15', '2007-06-15', '2007-08-15', '2007-10-15'};
lat_idxs = [lat_103_idx, lat_104_idx, lat_105_idx, lat_106_idx];
lon_idxs = {lon_103_idx, lon_104_idx, lon_105_idx, lon_106_idx};
lines = {'103', '104', '105', '106'};

for j = 1:length(lines)
    figure('Position', [100, 100, 800, 1000]);
    sgtitle(['GLORYS Temp / Line : ', lines{j}]); 
    
    for i = 1:length(dates)
        temp_subset = squeeze(dates{i}(lon_idxs{j}, lat_idxs(j), depth_idx));
        
        subplot(2, 2, i); % 3x2 레이아웃으로 서브플롯 구성
        contourf(lon(lon_idxs{j}), depth_range, temp_subset', 20, 'LineColor', 'none');
        set(gca, 'YDir', 'reverse');
        colormap("jet");
        caxis([0, 25]);
        
        xlabel('Longitude (°E)');
        ylabel('Depth (m)');
        title([day_indices{i}]);
        grid on;
    end
    
    h = colorbar;
    h.Position = [0.93 0.11 0.02 0.815]; 

    filename = ['GLORYS_Temp_Line_', lines{j}, '_Subplots.png'];
    saveas(gcf, filename);
    close(gcf);
end

%% HYCOM 자료 Line별 {Temp} > subplot 저장 (HYCOM_Temp_Line_NUM_subplot)
clc; clear all; close all;

% 정선자료
load('CTD_bimonthly_2007.mat')
ctd_103_lat = ctd{5}.lat;
ctd_103_lon = ctd{5}.lon;
ctd_104_lat = ctd{6}.lat;
ctd_104_lon = ctd{6}.lon;
ctd_105_lat = ctd{7}.lat;
ctd_105_lon = ctd{7}.lon;
ctd_106_lat = ctd{8}.lat;
ctd_106_lon = ctd{8}.lon;

% HYCOM 자료 
load('.\HYCOM_data\2007\hycES_2007_04_15_00_Reanalysis.mat');
date_0415 = hyc.date;
temp_0415 = hyc.temp;
date_0415_str = datestr(date_0415, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_06_15_00_Reanalysis.mat');
date_0615 = hyc.date;
temp_0615 = hyc.temp;
date_0615_str = datestr(date_0615, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_08_15_00_Reanalysis.mat');
date_0815 = hyc.date;
temp_0815 = hyc.temp;
date_0815_str = datestr(date_0815, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_10_15_00_Reanalysis.mat');
date_1015 = hyc.date;
temp_1015 = hyc.temp;
date_1015_str = datestr(date_1015, 'yyyy-mm-dd');

lat = hyc.lat;
lon = hyc.lon;
depth = hyc.dep;

% lon&lat indexing
[~, lat_103_idx] = min(abs(lat - ctd_103_lat(1)));
[~, lat_104_idx] = min(abs(lat - ctd_104_lat(1)));
[~, lat_105_idx] = min(abs(lat - ctd_105_lat(1)));
[~, lat_106_idx] = min(abs(lat - ctd_106_lat(1)));

lon_103_idx = find(lon >= min(ctd_103_lon) & lon <= max(ctd_103_lon));
lon_104_idx = find(lon >= min(ctd_104_lon) & lon <= max(ctd_104_lon));
lon_105_idx = find(lon >= min(ctd_105_lon) & lon <= max(ctd_105_lon));
lon_106_idx = find(lon >= min(ctd_106_lon) & lon <= max(ctd_106_lon));

lon_103_range = lon(lon_103_idx);
lon_104_range = lon(lon_104_idx);
lon_105_range = lon(lon_105_idx);
lon_106_range = lon(lon_106_idx);

depth_idx = 1:29; 
depth_range = depth(depth_idx);

dates = {temp_0415, temp_0615, temp_0815, temp_1015};
date_strs = {date_0415_str, date_0615_str, date_0815_str, date_1015_str};

% 위치 배열
lat_idxs = [lat_103_idx, lat_104_idx, lat_105_idx, lat_106_idx];
lon_idxs = {lon_103_idx, lon_104_idx, lon_105_idx, lon_106_idx};
lines = {'103', '104', '105', '106'};

for j = 1:length(lines)
    figure('Position', [100, 100, 800, 1000]); 
    sgtitle(['HYCOM Temp / Line : ', lines{j}]); 
    
    for i = 1:length(dates)
        temp_subset = squeeze(dates{i}(lon_idxs{j}, lat_idxs(j), depth_idx));
        
        subplot(2, 2, i); 
        contourf(lon(lon_idxs{j}), depth_range, temp_subset', 20, 'LineColor', 'none');
        set(gca, 'YDir', 'reverse');
        colormap("jet");
        caxis([0, 25]);
        
        xlabel('Longitude (°E)');
        ylabel('Depth (m)');
        title([date_strs{i}]);
        grid on;
    end

    h = colorbar;
    h.Position = [0.93 0.11 0.02 0.815];

    filename = ['HYCOM_Temp_Line_', lines{j}, '_Subplots.png'];
    saveas(gcf, filename);
    close(gcf);
end

%% CTD 자료 Line별 {Temp} > subplot 저장 (CTD_Temp_Line_NUM_subplot)
clc; clear all; close all;

load('CTD_bimonthly_2007.mat')

% 103 LINE
ctd_103_lat = ctd{5}.lat;
ctd_103_lon = ctd{5}.lon;
ctd_103_temp = ctd{5}.temp;
% ctd_103_sal = ctd{5}.sal;
% ctd_103_pden = ctd{5}.pden;
% ctd_103_statn = ctd{5}.statn;
% ctd_103_DO = ctd{5}.DO;
ctd_103_line = num2str(ctd{5}.line);

% 104 LINE
ctd_104_lat = ctd{6}.lat;
ctd_104_lon = ctd{6}.lon;
ctd_104_temp = ctd{6}.temp;
% ctd_104_sal = ctd{6}.sal;
% ctd_104_pden = ctd{6}.pden;
% ctd_104_statn = ctd{6}.statn;
% ctd_104_DO = ctd{6}.DO;
ctd_104_line = num2str(ctd{6}.line);

% 105 LINE
ctd_105_lat = ctd{7}.lat;
ctd_105_lon = ctd{7}.lon;
ctd_105_temp = ctd{7}.temp;
% ctd_105_sal = ctd{7}.sal;
% ctd_105_pden = ctd{7}.pden;
% ctd_105_statn = ctd{7}.statn;
% ctd_105_DO = ctd{7}.DO;
ctd_105_line = num2str(ctd{7}.line);

% 106 LINE
ctd_106_lat = ctd{8}.lat;
ctd_106_lon = ctd{8}.lon;
ctd_106_temp = ctd{8}.temp;
% ctd_106_sal = ctd{8}.sal;
% ctd_106_pden = ctd{8}.pden;
% ctd_106_statn = ctd{8}.statn;
% ctd_106_DO = ctd{8}.DO;
ctd_106_line = num2str(ctd{8}.line);

times = times(2:5,:);

% 시각화
figure('Position', [100, 100, 800, 1000]);
sgtitle(['CTD Temp / Line : 103']); %

for i = 1:size(times,1)
    selected_date = datetime(times(i, :));
    date_str = datestr(selected_date, 'yyyy-mm-dd');

    ctd_103_temp_day = ctd_103_temp(1:15,:,i); %%
    subplot(2, 2, i);
    
    h = contourf(ctd_103_lon, depth(1:15), ctd_103_temp_day, 20, 'LineColor', 'none'); %%
    set(gca, 'YDir', 'reverse');
    colormap("jet"); 
    caxis([0, 25]);

    xlabel('Longitude (°E)');
    ylabel('Depth (m)');
    title([date_str]);
    grid on;

    h = colorbar;
    h.Position = [0.93 0.11 0.02 0.815];

end

set(gcf, 'Position', [100, 100, 800, 1000]);

saveas(gcf, 'CTD_Temp_Line_103_Subplots.png'); % 


