% Test_241008

%%% 표층 수온 자료 (GIF 저장)
clc; clear all; close all;

load('SST_daily_2007.mat');  

time_range = 1:365;

% 울릉도
lon_marker = 130.86;
lat_marker = 37.5;

% GIF 파일 이름
gif_filename = 'SST_animation.gif';

% 프레임 해상도 설정
frame_width = 800; 
frame_height = 600; 

for i = 1:length(time_range) 
    time_idx = time_range(i);
    sst_for_time = ssts(:, :, time_idx);

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]); % 그래프를 화면에 표시하지 않음
    pcolor(lons, lats, sst_for_time'); % 데이터 시각화
    shading interp; % 인터폴레이션 적용
    colorbar; % 색상 막대 표시
    
    % colorbar 범위 설정
    caxis([0, 30]); % 최소값과 최대값으로 범위 설정

    hold on;
    
    % 마커 크기를 적절히 조정
    plot(lon_marker, lat_marker, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none'); 

    xlabel('Longitude');
    ylabel('Latitude');
    title(['SST at time\_idx = ', num2str(time_idx)]);
    
    % 프레임을 캡처하고 GIF에 추가
    frame = getframe(gcf); % 현재 그림의 프레임을 캡처
    im = frame2im(frame); % 프레임을 이미지로 변환

    % 이미지를 256 색상으로 줄여서 GIF로 저장
    [imind, cm] = rgb2ind(im, 256); % RGB 이미지를 인덱스 이미지로 변환
    if i == 1
        % GIF 파일 생성 (첫 프레임)
        imwrite(imind, cm, gif_filename, 'gif', 'LoopCount', inf, 'DelayTime', 0.2);
    else
        % GIF 파일에 추가 (다음 프레임)
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2);
    end
    
    close; % 현재 figure 창 닫기
end
