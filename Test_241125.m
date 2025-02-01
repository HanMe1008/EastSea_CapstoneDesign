%%% Test_241125

%% 월평균 유속
clc; clear all; close all;

glo = 'cmems_mod_glo_phy_my_0.083deg_P1M-m_1732438387565.nc';

% 변수 읽기
temp = ncread(glo, 'thetao');  % temperature (lon, lat, depth, time)
sal = ncread(glo, 'so');   % salinity (lon, lat, depth, time)
vo = ncread(glo, 'vo');    % eastward velocity (lon, lat, depth, time)
uo = ncread(glo, 'uo');    % northward velocity (lon, lat, depth, time)
zos = ncread(glo, 'zos');   % Sea Surface Height (SSH) (lon, lat, time)

% 시간, 위도, 경도, 깊이 데이터 읽기
time = ncread(glo, 'time');
lon = ncread(glo, 'longitude');
lat = ncread(glo, 'latitude');
depth = ncread(glo, 'depth');

% 시간 변환 (UNIX 시간)
reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

depth_idx = 1;
time_idx = 1:7;
levels = -0.1:0.02:0.5;

vo_time = vo(:, :, depth_idx, time_idx);
uo_time = uo(:, :, depth_idx, time_idx);
zos_time = zos(:, :, time_idx);
sal_time = sal(:, :, depth_idx, time_idx);
temp_time = temp(:, :, depth_idx, time_idx);

% 샘플링 간격 설정
sampling_interval = 3; % 벡터를 5칸마다 표시

for t_idx = 1:length(time_idx)

    % SSH 데이터 추출
    SSH = squeeze(zos(:, :, time_idx(t_idx)));
    vo_time = squeeze(vo(:, :, depth_idx, time_idx(t_idx)));
    uo_time = squeeze(uo(:, :, depth_idx, time_idx(t_idx)));

    % 샘플링된 데이터 추출
    sampled_lon = lon(1:sampling_interval:end);
    sampled_lat = lat(1:sampling_interval:end);
    sampled_uo = uo_time(1:sampling_interval:end, 1:sampling_interval:end);
    sampled_vo = vo_time(1:sampling_interval:end, 1:sampling_interval:end);

    % 그림 생성
    figure;
    contourf(lon, lat, SSH', levels);
    colorbar;
    caxis([-0.1, 0.5]);

    hold on;

    % 샘플링된 유속 벡터 표시
    quiver(sampled_lon, sampled_lat, sampled_uo', sampled_vo', 'color', 'k', 'autoscale', 'off');

    % 날짜 형식 설정
    date_str = datestr(dt(time_idx(t_idx)), 'yyyymm'); % yyyymmdd 형식
    title(['GLORYS Mean SSH (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 그래프 저장
    saveas(gcf, ['GLORYS_Mean_SSH_', date_str, '.png']);
    close;
end


