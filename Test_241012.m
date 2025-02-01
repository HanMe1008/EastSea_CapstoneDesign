% Test_241012
clc; clear all; close all;

%%% ADT 자료(표층 유속) (GIF 저장)
clc; clear all; close all;

load('ADT_geovel_daily_2007.mat')

time_range = 1:365;

% 울릉도 위치
lon_marker = 130.86;
lat_marker = 37.5;

% GIF 파일 이름
gif_filename = 'ADT_animation.gif';

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
    caxis([0, 2.0]); 

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


%%% 표층 바람자료 (GIF 저장)
clc; clear all; close all;

load('Wind_surf_daily_2007.mat')

time_range = 1:365;

% 울릉도 위치
lon_marker = 130.86;
lat_marker = 37.5;

% GIF 파일 이름
gif_filename = 'Wind_surf_animation.gif';

% 프레임 해상도 설정
frame_width = 800; 
frame_height = 600;

for i = 1:length(time_range) 
    time_idx = time_range(i);
    tair_for_time = tair(:, :, time_idx);
    wu10_for_time = wu10(:, :, time_idx);
    wv10_for_time = wv10(:, :, time_idx);

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, tair_for_time'); % 데이터 시각화
    shading interp; % 인터폴레이션 적용
    colorbar;
    
    % colorbar 범위 설정
    caxis([0, 30]); 

    hold on;
    quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'on')
    plot(lon_marker, lat_marker, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none'); 

    xlabel('Longitude');
    ylabel('Latitude');
    title(['Surf Wind at time\_idx = ', num2str(time_idx)]);
    
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


%%% 표층 복사량자료 (GIF 저장)
clc; clear all; close all;

load('Radiation_surf_daily_2007.mat')

time_range = 1:365;

% 울릉도 위치
lon_marker = 130.86;
lat_marker = 37.5;

% GIF 파일 이름
gif_filename = 'Radiation_surf_animation.gif';

% 프레임 해상도 설정
frame_width = 800; 
frame_height = 600;

for i = 1:length(time_range)  
    time_idx = time_range(i);
    radl_for_time = radl(:, :, time_idx);
    rads_for_time = rads(:, :, time_idx);
    total_rad = radl_for_time + rads_for_time;

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]); % 그래프를 화면에 표시하지 않음
    pcolor(lon, lat, total_rad'); % 데이터 시각화
    shading interp; % 인터폴레이션 적용
    colorbar;
    
    % colorbar 범위 설정
    caxis([0, 300]); 

    hold on;
    plot(lon_marker, lat_marker, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none'); 

    xlabel('Longitude');
    ylabel('Latitude');
    title(['Surf Radiation at time\_idx = ', num2str(time_idx)]);
    
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



