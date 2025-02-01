% Test_241015
clc; clear all; close all;

%% HYCOM자료 SST 시각화
clc; clear all; close all;

load('.\HYCOM_data\2007\hycES_2007_08_01_00_Reanalysis.mat');

date = hyc.date;
lat = hyc.lat;
lon = hyc.lon;
depth = hyc.dep;
temp = hyc.temp;
sal = hyc.sal;
u = hyc.u;
v = hyc.v;

date_str = datestr(date, 'yyyy-mm-dd HH:MM:SS');

depth_idx = 1; % idx(1) = 0m

temp_for_depth = temp(:, :, depth_idx);
u_for_depth = u(:, :, depth_idx);
v_for_depth = v(:, :, depth_idx);

figure;
pcolor(lon, lat, temp_for_depth');  
shading interp;
colormap("jet")
colorbar;
% caxis([-2, 20])

hold on;
quiver(lon, lat, u_for_depth', v_for_depth', 'color', 'k', 'autoscale', 'on')

depth_val = depth(depth_idx);
xlabel('Longitude (°E)');
ylabel('Latitude (°N)');
title_str = sprintf('Water Temp at Depth: %.1f m on %s', depth_val, date_str);
title(title_str);



%% 위도 고정, 깊이에 따른 수온
clc; clear all; close all;

load('.\HYCOM_data\2007\hycES_2007_08_10_00_Reanalysis.mat');

date = hyc.date;
lat = hyc.lat;
lon = hyc.lon;
depth = hyc.dep;
temp = hyc.temp;
sal = hyc.sal;
u = hyc.u;
v = hyc.v;

date_str = datestr(date, 'yyyy-mm-dd HH:MM:SS');

% 위도와 경도 인덱스 찾기
[~, lat_idx] = min(abs(lat - 36.8));
lon_idx = find(lon >= 129 & lon <= 130.0);

% 경도에 따른 온도 데이터 추출 (위도 38도 고정, depth index 1~20)
depth_idx = 1:22; 
temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx));

% 경도 범위 및 depth index 1~20까지의 깊이 설정
lon_range = lon(lon_idx);       % 경도 범위
depth_range = depth(depth_idx);  % 깊이 인덱스 1~20에 해당하는 깊이

% 깊이와 경도에 따른 온도 분포 시각화 (contourf)
figure;
contourf(lon_range, depth_range, temp_subset', 20, 'LineColor', 'none');  % '20'은 등고선 수
set(gca, 'YDir', 'reverse');  
colorbar; 

lat_str = num2str(lat(lat_idx));
xlabel('Longitude (°E)');
ylabel('Depth (m)');
title(['Temperature Contours (Latitude: ', lat_str , ' Date: ', date_str, ')']);
grid on;




%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ %%%




%% 위도 고정, 깊이에 따른 y방향 유속(v) 시각화
clc; clear all; close all;

load('.\HYCOM_data\2007\hycES_2007_01_01_00_Reanalysis.mat');

date = hyc.date;
lat = hyc.lat;
lon = hyc.lon;
depth = hyc.dep;
temp = hyc.temp;
sal = hyc.sal;
u = hyc.u;
v = hyc.v;

date_str = datestr(date, 'yyyy-mm-dd HH:MM:SS');

% 위도와 경도 인덱스 찾기
% y방향 유속단면
[~, lat_idx] = min(abs(lat - 38));
lon_idx = find(lon >= 129.5 & lon <= 131.5);

% 경도에 따른 온도 데이터 추출 (위도 고정, depth index 1~20)
depth_idx = 1:20; 
v_subset = squeeze(v(lon_idx, lat_idx, depth_idx));

% 경도 범위 및 depth index 1~20까지의 깊이 설정
lon_range = lon(lon_idx);       % 경도 범위
depth_range = depth(depth_idx);  % 깊이 인덱스 1~20에 해당하는 깊이

% 깊이와 경도에 따른 온도 분포 시각화 (contourf)
figure;
contourf(lon_range, depth_range, v_subset', 20, 'LineColor', 'none');  % '20'은 등고선 수
set(gca, 'YDir', 'reverse');  
colorbar; 

lat_str = num2str(lat(lat_idx));
xlabel('Longitude (°E)');
ylabel('Depth (m)');
title(['Velocity(y-direction) Contours (Latitude: ', lat_str, '°, Depth Index 1-20), Date: ', date_str, ')']);
grid on;




%% 경도 고정, 깊이에 따른 x방향 유속(u) 시각화
clc; clear all; close all;

load('.\HYCOM_data\2007\hycES_2007_01_01_00_Reanalysis.mat');

date = hyc.date;
lat = hyc.lat;
lon = hyc.lon;
depth = hyc.dep;
temp = hyc.temp;
sal = hyc.sal;
u = hyc.u;
v = hyc.v;

date_str = datestr(date, 'yyyy-mm-dd HH:MM:SS');

% 위도와 경도 인덱스 찾기
% x방향 유속 단면
lat_idx = find(lat >= 37 & lat <= 38.5); 
[~, lon_idx] = min(abs(lon - 130.5));

% 위도에 따른 온도 데이터 추출 (경도 고정, depth index 1~20)
depth_idx = 1:20; 
u_subset = squeeze(u(lon_idx, lat_idx, depth_idx));

% 위도 범위 및 depth index 1~20까지의 깊이 설정
lat_range = lat(lat_idx);       % 위도 범위
depth_range = depth(depth_idx);  % 깊이 인덱스 1~20에 해당하는 깊이

% 깊이와 위도에 따른 온도 분포 시각화 (contourf)
figure;
contourf(lat_range, depth_range, u_subset', 20, 'LineColor', 'none');  % '20'은 등고선 수
set(gca, 'YDir', 'reverse');  
colorbar;

lon_str = num2str(lon(lon_idx));
xlabel('Latitude (°N)');
ylabel('Depth (m)');
title(['Velocity(x-direction) Contours (Longitude: ', lon_str, '°, Depth Index 1-20), Date: ', date_str, ')']);
grid on;

