%%% Test_241117

%% GLORYS Temp (0.49m) > gif로 저장
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
time_idx = 1:214;

% 깊이 설정
depth_idx = 1;

% GIF 파일 이름 설정
gif_filename = 'GLORYS_Temp_0.49m.gif';

% GIF 생성
for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    current_temp = temp(:, :, depth_idx, t); % 해당 시간 및 깊이의 온도 데이터

    % 그래프 생성
    figure('Visible', 'off'); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, current_temp');
    shading interp;

    colormap('jet');
    cb = colorbar(); 
    cb.Label.String = 'Temperature (°C)'; 
    caxis([0, 25]);

    date_str = datestr(dt(time_idx(t_idx)), 'yyyy-mm-dd'); % 날짜 형식 설정
    title(['GLORYS Temp at 0.49m (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 프레임 캡처
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);

    % GIF 저장
    if t_idx == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end

    close; % 그래프 닫기
end


%% GLORYS Temp (92.3m) > gif로 저장
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
time_idx = 1:214;

% 깊이 설정
depth_idx = 22;

% GIF 파일 이름 설정
gif_filename = 'GLORYS_Temp_92.3m.gif';

% GIF 생성
for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    current_temp = temp(:, :, depth_idx, t); % 해당 시간 및 깊이의 온도 데이터

    % 그래프 생성
    figure('Visible', 'off'); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, current_temp');
    shading interp;

    colormap('jet');
    cb = colorbar(); 
    cb.Label.String = 'Temperature (°C)'; 
    caxis([0, 25]);

    date_str = datestr(dt(time_idx(t_idx)), 'yyyy-mm-dd'); % 날짜 형식 설정
    title(['GLORYS Temp at 92.3m (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 프레임 캡처
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);

    % GIF 저장
    if t_idx == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end

    close; % 그래프 닫기
end


%% GLORYS Salt (0.49m) > gif로 저장
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
time_idx = 1:214;

% 깊이 설정
depth_idx = 1;

% GIF 파일 이름 설정
gif_filename = 'GLORYS_Salt_0.49m.gif';

% GIF 생성
for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    current_sal = sal(:, :, depth_idx, t); % 해당 시간 및 깊이의 온도 데이터

    % 그래프 생성
    figure('Visible', 'off'); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, current_sal');
    shading interp;

    cb = colorbar(); 
    cb.Label.String = 'psu'; 
    caxis([31, 35]);

    date_str = datestr(dt(time_idx(t_idx)), 'yyyy-mm-dd'); % 날짜 형식 설정
    title(['GLORYS Salt at 0.49m (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 프레임 캡처
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);

    % GIF 저장
    if t_idx == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end

    close; % 그래프 닫기
end

%% GLORYS Salt (92.3m) > gif로 저장
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
time_idx = 1:214;

% 깊이 설정
depth_idx = 22;

% GIF 파일 이름 설정
gif_filename = 'GLORYS_Salt_92.3m.gif';

% GIF 생성
for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    current_sal = sal(:, :, depth_idx, t); % 해당 시간 및 깊이의 온도 데이터

    % 그래프 생성
    figure('Visible', 'off'); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, current_sal');
    shading interp;

    cb = colorbar(); % colorbar 객체 생성
    cb.Label.String = 'psu'; % colorbar에 레이블 추가
    caxis([33, 35]);


    date_str = datestr(dt(time_idx(t_idx)), 'yyyy-mm-dd'); % 날짜 형식 설정
    title(['GLORYS Salt at 92.3m (', date_str, ')']);
    xlabel('Longitude (°E)');
    ylabel('Latitude (°N)');
    grid on;

    % 프레임 캡처
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);

    % GIF 저장
    if t_idx == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end

    close; % 그래프 닫기
end