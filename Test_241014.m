% Test_241014
clc; clear all; close all;


%%% 위도 고정, 깊이에 따른 수온 시각화
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
lat_idx = find(lat == 38);   
lon_idx = find(lon >= 130.0 & lon <= 132.0);

% 경도에 따른 온도 데이터 추출 (위도 38도 고정, depth index 1~20)
depth_idx = 1:20;  % 깊이 인덱스 1~20 선택
temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx));

% 경도 범위 및 depth index 1~20까지의 깊이 설정
lon_range = lon(lon_idx);       % 경도 범위
depth_range = depth(depth_idx);  % 깊이 인덱스 1~20에 해당하는 깊이

% 깊이와 경도에 따른 온도 분포 시각화 (contourf)
figure;
contourf(lon_range, depth_range, temp_subset', 20, 'LineColor', 'none');  % '20'은 등고선 수
set(gca, 'YDir', 'reverse');  
colorbar; 
xlabel('Longitude (°E)');
ylabel('Depth (m)');
title(['Temperature Contours (Latitude 38°, Depth Index 1-20), Date: ', date_str, ')']);
grid on;



%%% 특정 수심의 유속 나타내기
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

lat_idx = find(lat >= 37.5 & lat <= 38.5);  
lon_idx = find(lon >= 129.5 & lon <= 131.5);
depth_idx = 18; % idx(15) = 50m

temp_for_depth = temp(lon_idx, lat_idx, depth_idx);
u_for_depth = u(lon_idx, lat_idx, depth_idx);
v_for_depth = v(lon_idx, lat_idx, depth_idx);

figure;
pcolor(lon_idx, lat_idx, temp_for_depth');  
shading interp;
colorbar;

hold on;
quiver(lon_idx, lat_idx, u_for_depth', v_for_depth', 'color', 'k', 'autoscale', 'on')

depth_val = depth(depth_idx);
xlabel('Longitude (°E)');
ylabel('Latitude (°N)');
title_str = sprintf('Water Temp at Depth: %.1f m on %s', depth_val, date_str);
title(title_str);


%%% HYCOM자료 SST 시각화
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

hold on;
quiver(lon, lat, u_for_depth', v_for_depth', 'color', 'k', 'autoscale', 'on')

depth_val = depth(depth_idx);
xlabel('Longitude (°E)');
ylabel('Latitude (°N)');
title_str = sprintf('Water Temp at Depth: %.1f m on %s', depth_val, date_str);
title(title_str);

