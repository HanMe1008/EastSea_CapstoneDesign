%%% Test_241124

%% 에디 중심 이동 동선 
clc; clear all; close all;

% 데이터 파일 로드
glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

% 변수 읽기
temp = ncread(glo_temp_and_sal, 'thetao');  % temperature (lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % salinity (lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward velocity (lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward velocity (lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % Sea Surface Height (SSH) (lon, lat, time)

% 시간, 위도, 경도, 깊이 데이터 읽기
time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

% 시간 변환 (UNIX 시간)
reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정 (위도 37.6~39.0N, 경도 130.0~132.0E)
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

% 관심 시간 범위 설정 
time_idx = 60:61; 

% 각 시간마다 최대 SSH 값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 SSH 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % 최대 SSH 값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    % 날짜 저장
    dates{t_idx} = dt(t); 
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 시각화: 각 시간에 대해 최대값이 나타나는 위도와 경도의 중심을 선으로 이어서 그리기
figure;
hold on;
plot(lon(lon_idx), lat(lat_idx));

% 실선은 먼저 그리기
for t_idx = 1:length(time_idx)
    if t_idx < length(time_idx)
        % 이전 시간까지의 이동을 실선으로
        plot(center_lon(1:t_idx), center_lat(1:t_idx), 'b-', 'LineWidth', 2);  % 실선
    end
end


% 날짜 레이블 추가: 마지막 3개의 날짜에만 텍스트 표시
for t_idx = length(time_idx)-1:length(time_idx)
    % 텍스트 위치는 중심 위도, 경도에 날짜를 표시
    text(center_lon(t_idx), center_lat(t_idx), char(dates{t_idx}), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 8);
end

% 붉은 점선은 마지막 두 시간만 연결하기
plot(center_lon(end-1:end), center_lat(end-1:end), 'r--o', 'LineWidth', 2);  % 붉은 점선 한 줄만

% 그래프 설정
xlabel('Longitude (°E)');
ylabel('Latitude (°N)');
title('Max SSH (GLORYS) - Temporal Movement of Center');
grid on;

% 그림 저장 (파일 이름 지정)
saveas(gcf, 'movement_center_plot_0.png');  % PNG 파일로 저장