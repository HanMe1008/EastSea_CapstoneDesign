%%% Test_241115

%% GLORYS SSH (use pcolor)
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

% 분석할 시간 범위 인덱스 설정
time_idx = 1:length(time);

% 깊이 설정
depth_idx = 1; 

for t_idx = 1:length(time_idx)

    % SSH 데이터 추출
    SSH = squeeze(zos(:, :, time_idx(t_idx)));

    figure;
    pcolor(lon, lat, SSH');
    shading interp;
    colorbar;
    caxis([-0.1, 0.4]);

    date_str = datestr(dt(time_idx(t_idx)), 'yyyymmdd'); % yyyymmdd 형식
    title(['GLORYS SSH (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 그래프 저장
    saveas(gcf, ['GLORYS_SSH_', date_str, '.png']);
    close;
end

%% GLORYS SSH (use contourf)
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

% 분석할 시간 범위 인덱스 설정
time_idx = 1:length(time);

% 깊이 설정
depth_idx = 1; 

% contour 간격 설정
levels = -0.1:0.02:0.5;

for t_idx = 1:length(time_idx)

    % SSH 데이터 추출
    SSH = squeeze(zos(:, :, time_idx(t_idx)));

    figure;
    contourf(lon, lat, SSH', levels); 
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


%% GLORYS SSH (use contourf) > gif로 저장
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

% 분석할 시간 범위 인덱스 설정
time_idx = 1:length(time);

% GIF 저장 설정
gif_filename = 'GLORYS_SSH_animation.gif';

% 깊이 설정
depth_idx = 1; 

% contour 간격 설정
levels = -0.1:0.02:0.5;

for t_idx = 1:length(time_idx)

    % SSH 데이터 추출
    SSH = squeeze(zos(:, :, time_idx(t_idx)));

    figure('Visible', 'off'); % 창을 표시하지 않음
    contourf(lon, lat, SSH', levels); 
    colorbar;
    caxis([-0.1, 0.5]);

    title(['GLORYS SSH (', datestr(dt(time_idx(t_idx)), 'yyyymmdd'), ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 프레임을 캡처하여 GIF에 저장
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256); % GIF 형식으로 변환

    if t_idx == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end

    close;
end


%% GLORYS SSH (use pcolor) > gif로 저장
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

% 분석할 시간 범위 인덱스 설정
time_idx = 1:length(time);

% GIF 저장 설정
gif_filename = 'GLORYS_SSH_pcolor.gif';

% 깊이 설정
depth_idx = 1; 

for t_idx = 1:length(time_idx)

    % SSH 데이터 추출
    SSH = squeeze(zos(:, :, time_idx(t_idx)));

    % 그래프 생성
    figure('Visible', 'off'); % 창 표시 안 함
    pcolor(lon, lat, SSH');
    shading interp;
    colorbar;
    caxis([-0.1, 0.4]);
    
    % 날짜 정보 추가
    date_str = datestr(dt(time_idx(t_idx)), 'yyyymmdd'); % yyyymmdd 형식
    title(['GLORYS SSH (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 프레임 캡처 및 GIF 저장
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256); % GIF 형식으로 변환

    if t_idx == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end

    close;
end


