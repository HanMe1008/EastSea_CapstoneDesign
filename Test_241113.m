%%% Test_241113

%% 에디중심찾기 (GLORYS 자료)
% 관심 영역 내에서 zos 최대값 찾고, 최대값과 값이 같은 index를 반환 후 해당 index들의 위도와 경도를 평균하여 따로
% 위도와 경도를 저장
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward(lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward(lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % SSH(lon, lat time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

time_idx = 60:91; 

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
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
plot(center_lon, center_lat, '-o', 'MarkerFaceColor', 'r', 'LineWidth', 2);
hold on;

% 날짜 레이블 추가
for t_idx = 1:length(time_idx)
    % 텍스트 위치는 중심 위도, 경도에 날짜를 표시
    text(center_lon(t_idx), center_lat(t_idx), char(dates{t_idx}), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 8);
end

xlabel('longitude (°E)');
ylabel('latitude (°N)');
title('max SSH (GLORYS)');
grid on;


%% GLORYS_V
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward(lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward(lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % SSH(lon, lat time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

time_idx = 1:214; 

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 vo 시각화
for t_idx = 1:length(time_idx)
    % 각 시간의 중심 위도 및 경도에 대한 인덱스 찾기
    [~, lat_idx] = min(abs(lat - center_lat(t_idx)));
    lon_idx = find(lon >= center_lon(t_idx)-1 & lon <= center_lon(t_idx)+1);
    
    % depth 범위 설정 (1:30)
    depth_idx = 1:30;
    
    % 속도 벡터(vo) 데이터 추출
    vo_subset = squeeze(vo(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lon_range = lon(lon_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lon_range, depth_range, vo_subset', 20, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colorbar;
    caxis([-0.3, 0.3]);

    % 타이틀에 날짜 형식 (년월일)
    date_str = datestr(dates{t_idx}, 'yyyymmdd');  % 형식 변경: yyyy-mm-dd -> yyyymmdd
    title(['GLORYS V (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Depth (m)');
    grid on;

    % 범례
    lat_str = ['Latitude: ', num2str(lat(lat_idx)), '°'];
    legend(lat_str, 'Location', 'southeast', 'FontSize', 10);

    saveas(gcf, ['GLORYS_V_', date_str, '.png']);
    
    close;
end

%% GLORYS_U
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward(lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward(lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % SSH(lon, lat time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

time_idx = 1:214; 

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 uo 시각화
for t_idx = 1:length(time_idx)
    % 각 시간의 중심 위도 및 경도에 대한 인덱스 찾기
    [~, lon_idx] = min(abs(lon - center_lon(t_idx)));
    lat_idx = find(lat >= center_lat(t_idx)-1 & lat <= center_lat(t_idx)+1);
    
    % depth 범위 설정 (1:30)
    depth_idx = 1:30;
    
    % 속도 벡터(uo) 데이터 추출
    uo_subset = squeeze(uo(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lat_range = lat(lat_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lat_range, depth_range, uo_subset', 20, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colorbar;
    caxis([-0.3, 0.3]);

    % 타이틀에 날짜 형식 (년월일)
    date_str = datestr(dates{t_idx}, 'yyyymmdd'); 
    title(['GLORYS U (', date_str, ')']);
    xlabel('Latitude (°N)');
    ylabel('Depth (m)');
    grid on;

    % 범례
    lon_str = ['Longitude: ', num2str(lon(lon_idx)), '°'];
    legend(lon_str, 'Location', 'southeast', 'FontSize', 10);

    saveas(gcf, ['GLORYS_U_', date_str, '.png']);
    
    close;
end

%% GLORYS_Temp_fixed_lon
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward(lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward(lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % SSH(lon, lat time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

time_idx = 51:91;
levels = 0:1:30;

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 temp 시각화
for t_idx = 1:length(time_idx)
    [~, lon_idx] = min(abs(lon - center_lon(t_idx)));
    lat_idx = find(lat >= center_lat(t_idx)-1 & lat <= center_lat(t_idx)+1);
    
    % depth 범위 설정 
    depth_idx = 1:31;
    
    % 데이터 추출
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    sal_subset = squeeze(sal(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lat_range = lat(lat_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lat_range, depth_range, temp_subset', levels, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colorbar;
    colormap('jet');
    caxis([0, 25]);

    % 등고선추가
    hold on; 
    temp_contour_1 = contour(lat_range, depth_range, temp_subset', [10 10], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_1, 'Color', 'k', 'FontSize', 10);
    temp_contour_2 = contour(lat_range, depth_range, temp_subset', [5 5], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_2, 'Color', 'k', 'FontSize', 10);
    salt_contour_1 =contour(lat_range, depth_range, sal_subset', [34.3 34.3], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_1, 'Color', 'k', 'FontSize', 10); 
    salt_contour_2 =contour(lat_range, depth_range, sal_subset', [34.0 34.0], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_2, 'Color', 'k', 'FontSize', 10);
    hold off;

    % 타이틀에 날짜 형식 (년월일)
    date_str = datestr(dates{t_idx}, 'yyyymmdd'); 
    title(['GLORYS Temp  (', date_str, ')']);
    xlabel('Latitude (°N)');
    ylabel('Depth (m)');
    grid on;

    % 범례
    lon_str = ['Longitude: ', num2str(lon(lon_idx)), '°'];
    legend(lon_str, 'Location', 'southeast', 'FontSize', 10);

    saveas(gcf, ['GLORYS_Temp_', date_str, '_fixed_lon.png']);
    
    close;
end

%% GLORYS_Salt_fixed_lon
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward(lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward(lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % SSH(lon, lat time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

time_idx = 51:91;
levels = 25:0.02:40;

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 sal 시각화
for t_idx = 1:length(time_idx)
    [~, lon_idx] = min(abs(lon - center_lon(t_idx)));
    lat_idx = find(lat >= center_lat(t_idx)-1 & lat <= center_lat(t_idx)+1);
    
    % depth 범위 설정 
    depth_idx = 1:30;
    
    % 데이터 추출
    sal_subset = squeeze(sal(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lat_range = lat(lat_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lat_range, depth_range, sal_subset', levels, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colorbar;
    colormap('jet');
    caxis([33.80, 34.55]);

    % 등고선추가
    hold on; 
    temp_contour_1 = contour(lat_range, depth_range, temp_subset', [10 10], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_1, 'Color', 'k', 'FontSize', 10);
    temp_contour_2 = contour(lat_range, depth_range, temp_subset', [5 5], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_2, 'Color', 'k', 'FontSize', 10);
    salt_contour_1 =contour(lat_range, depth_range, sal_subset', [34.3 34.3], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_1, 'Color', 'k', 'FontSize', 10); 
    salt_contour_2 =contour(lat_range, depth_range, sal_subset', [34.0 34.0], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_2, 'Color', 'k', 'FontSize', 10);
    hold off;

    % 타이틀에 날짜 형식 (년월일)
    date_str = datestr(dates{t_idx}, 'yyyymmdd'); 
    title(['GLORYS Salt  (', date_str, ')']);
    xlabel('Latitude (°N)');
    ylabel('Depth (m)');
    grid on;

    % 범례
    lon_str = ['Longitude: ', num2str(lon(lon_idx)), '°'];
    legend(lon_str, 'Location', 'southeast', 'FontSize', 10);

    saveas(gcf, ['GLORYS_Salt_', date_str, '_fixed_lon.png']);
    
    close;
end


%% GLORYS_Temp_fixed_lat
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward(lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward(lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % SSH(lon, lat time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

time_idx = 51:91;
levels = 0:1:30;

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 temp 시각화
for t_idx = 1:length(time_idx)
    [~, lat_idx] = min(abs(lat - center_lat(t_idx)));
    lon_idx = find(lon >= center_lon(t_idx)-1 & lon <= center_lon(t_idx)+1);
    
    % depth 범위 설정
    depth_idx = 1:31;
    
    % 데이터 추출
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    sal_subset = squeeze(sal(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lon_range = lon(lon_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lon_range, depth_range, temp_subset', levels, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colorbar;
    colormap('jet');
    caxis([0, 25]);

    % 등고선추가
    hold on; 
    temp_contour_1 = contour(lon_range, depth_range, temp_subset', [10 10], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_1, 'Color', 'k', 'FontSize', 10);
    temp_contour_2 = contour(lon_range, depth_range, temp_subset', [5 5], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_2, 'Color', 'k', 'FontSize', 10);
    salt_contour_1 = contour(lon_range, depth_range, sal_subset', [34.3 34.3], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_1, 'Color', 'k', 'FontSize', 10); 
    salt_contour_2 = contour(lon_range, depth_range, sal_subset', [34.0 34.0], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_2, 'Color', 'k', 'FontSize', 10);
    hold off;

    % 타이틀에 날짜 형식 (년월일)
    date_str = datestr(dates{t_idx}, 'yyyymmdd'); 
    title(['GLORYS Temp  (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Depth (m)');
    grid on;

    % 범례
    lat_str = ['Latitude: ', num2str(lat(lat_idx)), '°'];
    legend(lat_str, 'Location', 'southeast', 'FontSize', 10);

    saveas(gcf, ['GLORYS_Temp_', date_str, '_fixed_lat.png']);
    
    close;
end



%% GLORYS_Salt_fixed_lat
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');   % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');    % eastward(lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');    % northward(lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');   % SSH(lon, lat time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 관심 영역 설정
lat_min = 37.6; lat_max = 39.0;
lon_min = 130.0; lon_max = 132.0;

% 관심 영역 내의 인덱스 찾기
lat_idx = find(lat >= lat_min & lat <= lat_max);
lon_idx = find(lon >= lon_min & lon <= lon_max);

time_idx = 51:91;
levels = 25:0.02:40;

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 sal 시각화
for t_idx = 1:length(time_idx)
    [~, lat_idx] = min(abs(lat - center_lat(t_idx)));
    lon_idx = find(lon >= center_lon(t_idx)-1 & lon <= center_lon(t_idx)+1);
    
    % depth 범위 설정
    depth_idx = 1:30;
    
    % sal 데이터 추출
    sal_subset = squeeze(sal(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lon_range = lon(lon_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lon_range, depth_range, sal_subset', levels, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colorbar;
    colormap('jet');
    caxis([33.80, 34.55]);

    % 등고선추가
    hold on; 
    temp_contour_1 = contour(lon_range, depth_range, temp_subset', [10 10], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_1, 'Color', 'k', 'FontSize', 10);
    temp_contour_2 = contour(lon_range, depth_range, temp_subset', [5 5], 'LineColor', 'r', 'LineWidth', 0.5);
    clabel(temp_contour_2, 'Color', 'k', 'FontSize', 10);
    salt_contour_1 = contour(lon_range, depth_range, sal_subset', [34.3 34.3], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_1, 'Color', 'k', 'FontSize', 10); 
    salt_contour_2 = contour(lon_range, depth_range, sal_subset', [34.0 34.0], 'LineColor', "k", 'LineWidth', 0.5);
    clabel(salt_contour_2, 'Color', 'k', 'FontSize', 10);
    hold off;

    % 타이틀에 날짜 형식 (년월일)
    date_str = datestr(dates{t_idx}, 'yyyymmdd'); 
    title(['GLORYS Salt  (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Depth (m)');
    grid on;

    % 범례
    lat_str = ['Latitude: ', num2str(lat(lat_idx)), '°'];
    legend(lat_str, 'Location', 'southeast', 'FontSize', 10);

    saveas(gcf, ['GLORYS_Salt_', date_str, '_fixed_lat.png']);
    
    close;
end