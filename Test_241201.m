%%% Test_241201

%% 수심 92.3m contour 내부 에디 특성 정량화
clc; clear all; close all;

% 파일 경로
glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

% 데이터 읽기
temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');       % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');            % 북향 속도 (lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');            % 동향 속도 (lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');               % SSH (lon, lat, time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

% 시간 변환
reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 파라미터 설정
time_idx = 70;  
depth_idx = 22; % 22번째 깊이
levels = -0.1:0.02:0.5;

% 관심 있는 위도 및 경도 범위 설정
lat_range = [37.0, 38.95]; % 관심 위도 범위
lon_range = [129.7, 131.8]; % 관심 경도 범위

% 위도와 경도 인덱스 추출
lat_idx = find(lat >= lat_range(1) & lat <= lat_range(2)); % 위도 인덱스
lon_idx = find(lon >= lon_range(1) & lon <= lon_range(2)); % 경도 인덱스

% 제한된 범위의 데이터 추출
lon_sub = lon(lon_idx); % 경도
lat_sub = lat(lat_idx); % 위도
SSH_sub = zos(lon_idx, lat_idx, time_idx); % 제한된 SSH 데이터
temp_sub = temp(lon_idx, lat_idx, depth_idx, time_idx); % 제한된 temp 데이터
uo_sub = uo(lon_idx, lat_idx, depth_idx, time_idx); % 제한된 uo 데이터
vo_sub = vo(lon_idx, lat_idx, depth_idx, time_idx); % 제한된 vo 데이터

% 유속 계산
velocity_sub = sqrt(uo_sub.^2 + vo_sub.^2); % 유속 = sqrt(uo^2 + vo^2)

% SSH 등고선 플롯
figure;
[c, h] = contourf(lon_sub, lat_sub, SSH_sub', levels); % SSH 등고선
hold on;
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title(sprintf('92.3m max velocity: %s', datestr(dt(time_idx))));

% 특정 등고선 강조
target_level = 0.16; % 원하는 contour level
[c_single, h_single] = contour(lon_sub, lat_sub, SSH_sub', [target_level, target_level], 'k-', 'LineWidth', 2); % 강조 등고선

% 특정 등고선 내부 영역 선택
if ~isempty(c_single)
    idx = find(c_single(1,:) == target_level, 1); % 해당 level의 시작점 인덱스
    num_points = c_single(2, idx); % 경계점 개수
    x_boundary = c_single(1, idx+1:idx+num_points); % 경계의 x 좌표
    y_boundary = c_single(2, idx+1:idx+num_points); % 경계의 y 좌표

    [X, Y] = meshgrid(lon_sub, lat_sub);
    in = inpolygon(X, Y, x_boundary, y_boundary); % 내부 점 마스킹

    velocity_inside = velocity_sub(in'); % 내부 유속 값
    temp_inside = temp_sub(in'); % 내부 온도 값

    mean_velocity = mean(velocity_inside, 'omitnan'); % 유속 평균
    max_velocity = max(velocity_inside, [], 'omitnan'); % 유속 최대값
    mean_temp = mean(temp_inside, 'omitnan'); % 온도 평균

    [max_row_velocity, max_col_velocity] = find(velocity_sub == max_velocity);
    max_lon_velocity = lon_sub(max_row_velocity);
    max_lat_velocity = lat_sub(max_col_velocity);

    fprintf('Contour %.2f 내부 유속 평균: %.2f, 최대값: %.2f (위도: %.2f, 경도: %.2f)\n', ...
            target_level, mean_velocity, max_velocity, max_lat_velocity, max_lon_velocity);
    fprintf('Contour %.2f 내부 temp 평균: %.2f\n', target_level, mean_temp);

    % 최대값 위치 표시
    scatter(max_lon_velocity, max_lat_velocity, 100, 'g', 'filled'); % 유속 최대값
    text(max_lon_velocity, max_lat_velocity, sprintf('Max: %.2f', max_velocity), 'Color', 'green');
end

% 그림 저장
saveas(gcf, sprintf('Velocity_Max_92.3m_%s.png', datestr(dt(time_idx), 'yyyy-mm-dd')));
