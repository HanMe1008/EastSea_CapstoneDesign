% Test_241013
clc; clear all; close all;


%%% ADT 자료(표층 유속) (GIF 저장) (컬러바 수정)
clc; clear all; close all;

load('ADT_geovel_daily_2007.mat')

time_range = 1:365;

% 울릉도 위치
lon_marker = 130.86;
lat_marker = 37.5;

% GIF 파일 이름
gif_filename = 'ADT_animation_colorbar.gif';

% 프레임 해상도 설정
frame_width = 800; 
frame_height = 600; 

for i = 1:length(time_range)
    time_idx = time_range(i);
    adt_for_time = adt(:, :, time_idx);
    wu10_for_time = ug(:, :, time_idx);
    wv10_for_time = vg(:, :, time_idx);

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, adt_for_time'); % 데이터 시각화
    shading interp; % 인터폴레이션 적용
    colorbar;
    
    % colorbar 범위 설정
    caxis([0, 1.0]); 

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


%%% HYCOM 자료
clc; clear all; close all;

file = 'data_2007_1.nc4';

% 각 변수 읽기
salinity = ncread(file, 'salinity');
time = ncread(file, 'time');
depth = ncread(file, 'depth');
lat = ncread(file, 'lat');
lon = ncread(file, 'lon');
water_temp = ncread(file, 'water_temp');
water_u = ncread(file, 'water_u');
water_v = ncread(file, 'water_v');

% 변수 확인
disp('Salinity data:');
disp(size(salinity));

disp('Time data:');
disp(size(time));

disp('Depth data:');
disp(size(depth));

disp('Latitude data:');
disp(size(lat));

disp('Longitude data:');
disp(size(lon));

disp('Water temperature data:');
disp(size(water_temp));

disp('Eastward water velocity data:');
disp(size(water_u));

disp('Northward water velocity data:');
disp(size(water_v));

% 시간 데이터 읽기 (기존의 time 변수를 그대로 사용)
time_data = ncread(file, 'time');

% 기준 시간 설정 (NetCDF 파일의 'units' 속성에서 읽어옴)
base_time = datetime(2000, 1, 1, 0, 0, 0);

% time 변수를 시간으로 변환 (hours since 2000-01-01 00:00:00)
time_converted = base_time + hours(time_data);

% 변환된 시간 출력
disp(time_converted);


%%% 시각화연습
clc; clear all; close all;

file = 'data_2007_1.nc4';

% 각 변수 읽기
salinity = ncread(file, 'salinity');
time = ncread(file, 'time');
depth = ncread(file, 'depth');
lat = ncread(file, 'lat');
lon = ncread(file, 'lon');
water_temp = ncread(file, 'water_temp');
water_u = ncread(file, 'water_u');
water_v = ncread(file, 'water_v');

 %  depth, time 선택
depth_idx = 18
time_idx = 1
salinity_slice = salinity(:, :, depth_idx, time_idx);
water_temp_slice = water_temp(:, :, depth_idx, time_idx); 

% 경도와 위도를 격자 형태로 만듦
[LonGrid, LatGrid] = meshgrid(lon, lat);

% 시각화
figure;
contourf(LonGrid, LatGrid, water_temp_slice', 20, 'LineColor', 'none');
% contourf(LonGrid, LatGrid, salinity_slice', 20, 'LineColor', 'none');
colorbar;

% 제목설정
time_val = time(time_idx);  % 선택한 time 값
depth_val = depth(depth_idx);  % 선택한 depth 값
base_time = datetime(2000, 1, 1, 0, 0, 0);  % 기준 시간 설정
actual_time = base_time + hours(time_val);  % 실제 시간 계산
title_str = sprintf('Water Temp at Depth: %.1f m on %s', depth_val, datestr(actual_time, 'yyyy-mm-dd HH:MM:SS'));
title(title_str);

xlabel('Longitude');
ylabel('Latitude');
colormap jet;  % 색상 지도 설정


%%% ADT 자료(표층 유속)
time_idx = 213;
ug_for_time = ug(:, :, time_idx);
vg_for_time = vg(:, :, time_idx);
adt_for_time = adt(:, :, time_idx);

figure;
pcolor(lon, lat, adt_for_time');
shading interp;
colorbar;
caxis([0, 1.0]);
hold on;
quiver(lon, lat, ug_for_time', vg_for_time', 'color', 'k', 'autoscale', 'on')
xlabel('Longitude');
ylabel('Latitude');
title('ADT at time index : ', time_idx)


%%% 표층 수온 자료
clc; clear all; close all;

load('SST_daily_2007.mat')  % 표층 수온 자료
time_idx = 213;
sst_for_time = ssts(:, :, time_idx);

figure;
pcolor(lons, lats, sst_for_time');  
shading interp;
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('SST at time_idx : 222')


