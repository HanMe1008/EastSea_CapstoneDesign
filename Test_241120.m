%%% Test_241120

%% GLORYS SSH > gif
clc; clear all; close all;

% 파일명
glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

% 데이터 읽기
zos = ncread(glo_ssh, 'zos');              % SSH (lon, lat, time)
time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');

% 시간 변환
reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 분석할 시간 범위
time_idx = 31:92; 
selected_time = dt(time_idx);

% GIF 설정
gif_filename = 'GLORYS_SSH_Jul_to_Aug.gif';
levels = -0.1:0.02:0.5; % contour levels

% 플롯 루프
for t_idx = 1:length(time_idx)
    % 현재 시간의 SSH 데이터
    SSH = squeeze(zos(:, :, time_idx(t_idx)));

    % 플롯 생성
    figure('Visible', 'off');
    contourf(lon, lat, SSH', levels); 
    colorbar;
    caxis([-0.1, 0.5]);

    % 타이틀과 레이블
    title(['GLORYS SSH (', datestr(selected_time(t_idx), 'yyyy-mm-dd'), ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % GIF로 저장
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);

    if t_idx == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.2);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2);
    end

    close;
end


%% GLORYS SSH > 개별저장
clc; clear all; close all;

glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');       % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');           % northward velocity (lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');           % eastward velocity (lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');              % SSH (lon, lat, time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

time_idx = 1:length(time);
depth_idx = 1; 
levels = -0.1:0.02:0.5;

for t_idx = 1:length(time_idx)

    % SSH 데이터 추출
    SSH = squeeze(zos(:, :, time_idx(t_idx)));

    figure;
    [c, h]=contourf(lon, lat, SSH', levels); 
    colorbar;
    caxis([-0.1, 0.5]);

    % 날짜 형식 설정
    date_str = datestr(dt(time_idx(t_idx)), 'yyyymmdd'); % yyyymmdd 형식
    title(['GLORYS SSH (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 그래프 저장
    saveas(gcf, ['GLORYS_SSH_', date_str, '_contourf.png']);
    close;
end


%% GLORYS_U with contour
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
    
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:)); 
    
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); 
    max_lon_all{t_idx} = lon(lon_idx(row)); 

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

u_levels = -0.6:0.01:0.6;

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 uo 시각화
for t_idx = 1:length(time_idx)
    % 각 시간의 중심 위도 및 경도에 대한 인덱스 찾기
    [~, lon_idx] = min(abs(lon - center_lon(t_idx)));
    lat_idx = find(lat >= center_lat(t_idx)-1 & lat <= center_lat(t_idx)+1);
    
    % depth 범위 설정
    depth_idx = 1:30;
    
    % 데이터 추출
    uo_subset = squeeze(uo(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    sal_subset = squeeze(sal(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lat_range = lat(lat_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lat_range, depth_range, uo_subset', u_levels, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colormap('jet')
    colorbar;
    caxis([-0.5, 0.5]);

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

%% GLORYS_V with contour
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
    
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:)); 
    
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); 
    max_lon_all{t_idx} = lon(lon_idx(row)); 

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

v_levels = -0.6:0.01:0.6;

% 전체 시간 범위에서 모든 center_lat, center_lon에 대한 vo 시각화
for t_idx = 1:length(time_idx)
    % 각 시간의 중심 위도 및 경도에 대한 인덱스 찾기
    [~, lat_idx] = min(abs(lat - center_lat(t_idx)));
    lon_idx = find(lon >= center_lon(t_idx)-1 & lon <= center_lon(t_idx)+1);
    
    % depth 범위 설정 (1:30)
    depth_idx = 1:30;
    
    % 데이터 추출
    vo_subset = squeeze(vo(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));
    sal_subset = squeeze(sal(lon_idx, lat_idx, depth_idx, time_idx(t_idx)));

    lon_range = lon(lon_idx);
    depth_range = depth(depth_idx);

    % 시각화
    figure;
    contourf(lon_range, depth_range, vo_subset', v_levels, 'LineColor', 'none');
    set(gca, 'Ydir', 'reverse');
    colormap('jet')
    colorbar;
    caxis([-0.5, 0.5]);

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



