% Test_241021
clc; clear all; close all;


%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


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

% 위도, 경도, 수심 인덱스
[~, lat_idx] = min(abs(lat - 38));
lon_idx = find(lon >= 129.5 & lon <= 131.5);
depth_idx = 1:20; 

% 경도에 따른 온도 데이터
v_subset = squeeze(v(lon_idx, lat_idx, depth_idx));

% 경도 범위, 수심 범위 설정
lon_range = lon(lon_idx);       
depth_range = depth(depth_idx); 

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


%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


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

% 위도, 경도, 수심 인덱스
lat_idx = find(lat >= 37 & lat <= 38.5); 
[~, lon_idx] = min(abs(lon - 130.5));
depth_idx = 1:20; 

% 위도에 따른 온도 데이터
u_subset = squeeze(u(lon_idx, lat_idx, depth_idx));

% 위도 범위, 수심 범위 설정
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


%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


%% 위도 고정, 깊이에 따른 수온
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
[~, lat_idx] = min(abs(lat - 38));
lon_idx = find(lon >= 129.5 & lon <= 131.5);

% 경도에 따른 온도 데이터 추출 (위도 38도 고정, depth index 1~20)
depth_idx = 1:20; 
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
title(['Temperature Contours (Latitude: ', lat_str , ', Date: ', date_str, ')']);
grid on;


%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


%% 경도 고정, 깊이에 따른 수온
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
lat_idx = find(lat >= 37 & lat <= 38.5); 
[~, lon_idx] = min(abs(lon - 130.5));

% 경도에 따른 온도 데이터 추출
depth_idx = 1:20; 
temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx));

% 위도 범위 및 depth index 1~20까지의 깊이 설정
lat_range = lat(lat_idx);       
depth_range = depth(depth_idx);  

% 깊이와 경도에 따른 온도 분포 시각화 (contourf)
figure;
contourf(lat_range, depth_range, temp_subset', 20, 'LineColor', 'none');  % '20'은 등고선 수
set(gca, 'YDir', 'reverse');  
colorbar; 

lon_str = num2str(lon(lon_idx));
xlabel('Latitude (°N)');
ylabel('Depth (m)');
title(['Temperature Contours (Longitude: ', lon_str , ', Date: ', date_str, ')']);
grid on;


%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


%% ADT 자료(표층 유속), 해역 자르기 (GIF 저장)
clc; clear all; close all;

load('ADT_geovel_daily_2007.mat')

time_range = 1:365;

% 울릉도 위치
lon_marker = 130.86;
lat_marker = 37.5;

% GIF 파일 이름
gif_filename = 'ADT_animation_east_sea.gif';

% 프레임 해상도 설정
frame_width = 800; 
frame_height = 600; 

lon_idx = find(lon >= 127.0 & lon <= 135);
lat_idx = find(lat >= 34.0 & lat <= 40);

lon = lon(lon_idx);
lat = lat(lat_idx);

for i = 1:length(time_range)
    time_idx = time_range(i);
    adt_for_time = adt(lon_idx, lat_idx, time_idx);
    wu10_for_time = ug(lon_idx, lat_idx, time_idx);
    wv10_for_time = vg(lon_idx, lat_idx, time_idx);

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, adt_for_time'); % 데이터 시각화
    shading interp; % 인터폴레이션 적용
    colorbar;
    
    % colorbar 범위 설정
    caxis([0, 1.2]); 

    hold on;
    quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'on')
    plot(lon_marker, lat_marker, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none'); 

    xlabel('Longitude');
    ylabel('Latitude');
    title(['ADT at time\_idx = ', num2str(time_idx)]);
    
    % 프레임을 캡처하고 GIF에 추가
    frame = getframe(gcf); % 현재 그림의 프레임을 캡처
    im = frame2im(frame); % 프레임을 이미지로 변환

    % 이미지를 256 색상으로 줄여서 GIF로 저장
    [imind, cm] = rgb2ind(im, 256); % RGB 이미지를 인덱스 이미지로 변환
    if i == 1
        % GIF 파일 생성 (첫 프레임)
        imwrite(imind, cm, gif_filename, 'gif', 'LoopCount', inf, 'DelayTime', 0.2); % DelayTime 조정
    else
        % GIF 파일에 추가 (다음 프레임)
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2); % DelayTime 조정
    end
    
    close; 
end



