%%% Test_241112

%% ADT contour line > GIF로 저장
clc; clear all; close all;

load('ADT_geovel_daily_2007.mat')
load('coastline_around_Korea.mat')

time_range = 182:243;
gif_filename = 'ADT_contour_Line_Jul_to_Aug.gif';

frame_width = 800; 
frame_height = 600; 

dt = datetime(time, 'ConvertFrom', 'datenum'); % 'time' 변수를 datetime 형식으로 변환
dt_str = datestr(dt, 'yyyy-mm-dd');

lon_idx = find(lon >= 127.0 & lon <= 135);
lat_idx = find(lat >= 34.0 & lat <= 40);

lon = lon(lon_idx);
lat = lat(lat_idx);
[lonGrid, latGrid] = meshgrid(lon, lat);  

% contour 간격 설정
levels = 0:0.02:1.2;

% 해안선 데이터를 지정된 경도, 위도 범위로 제한
coast_idx = (cllon >= min(lon) & cllon <= max(lon) & cllat >= min(lat) & cllat <= max(lat));
cllon_limited = cllon(coast_idx);
cllat_limited = cllat(coast_idx);

for i = 1:length(time_range)
    time_idx = time_range(i);
    adt_for_time = adt(lon_idx, lat_idx, time_idx);
    wu10_for_time = ug(lon_idx, lat_idx, time_idx);
    wv10_for_time = vg(lon_idx, lat_idx, time_idx);

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]); 
    contourf(lonGrid, latGrid, adt_for_time', levels);
    colorbar;
    caxis([0, 1.2]); 

    % hold on;
    % quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'on')
    % plot(cllon_limited, cllat_limited, '.k')  % 제한된 해안선 데이터만 표시

    xlabel('Longitude');
    ylabel('Latitude');
    title(['Satellite ADT (', dt_str(time_idx, :), ')']);

    frame = getframe(gcf); 
    im = frame2im(frame); 

    [imind, cm] = rgb2ind(im, 256); 
    if i == 1
        imwrite(imind, cm, gif_filename, 'gif', 'LoopCount', inf, 'DelayTime', 0.2);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2);
    end
    
    close; 
end

%% ADT contour line > jpg 개별 저장
clc; clear all; close all;

load('ADT_geovel_daily_2007.mat');

time_range = 211:242;

lon_idx = find(lon >= 127.0 & lon <= 135);
lat_idx = find(lat >= 34.0 & lat <= 40);

lon = lon(lon_idx);
lat = lat(lat_idx);
[lonGrid, latGrid] = meshgrid(lon, lat);

% time 배열을 datetime 형식으로 변환
dt = datetime(time(:,1), time(:,2), time(:,3), time(:,4), time(:,5), time(:,6));

levels = 0:0.02:1.3;

for i = 1:length(time_range)
    time_idx = time_range(i);
    adt_for_time = adt(lon_idx, lat_idx, time_idx);
    wu10_for_time = ug(lon_idx, lat_idx, time_idx);
    wv10_for_time = vg(lon_idx, lat_idx, time_idx);

    % 날짜 문자열 생성
    date_str = datestr(dt(time_idx), 'yyyy-mm-dd');
    
    % 그림 생성 및 설정
    figure('Visible', 'off', 'Position', [100, 100, 800, 600]); 
    contourf(lonGrid, latGrid, adt_for_time', levels);
    colorbar;
    caxis([0, 1.3]);

    % hold on;
    % quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'off');

    title(['Satellite ADT (', date_str, ')']);
    xlabel('Longitude');
    ylabel('Latitude');

    % 이미지 저장
    filename = ['ADT_contour_Line_at_' date_str '_no_current.png'];
    saveas(gcf, filename); % PNG로 저장

    close;
end
