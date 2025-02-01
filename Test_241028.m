% Test_241008
clc; clear all; close all;

%% SST + 유속 확인 (gif)
load('coastline_around_Korea.mat');
load('ADT_geovel_daily_2007.mat');
load('CTD_bimonthly_2007.mat');
load('OSTIA_SST_daily_2007.mat');

time_range = 182:365;

gif_filename = 'SST_animation_with_current_since_Jul.gif';

frame_width = 800; 
frame_height = 600; 

% SST 변수
lons_idx = find(lons >= 127.0 & lons <= 135);
lats_idx = find(lats >= 34.0 & lats <= 40);
lons = lons(lons_idx);
lats = lats(lats_idx);

% ADT 변수
lon_idx = find(lon >= 127.0 & lon <= 135);
lat_idx = find(lat >= 34.0 & lat <= 40);
lon = lon(lon_idx);
lat = lat(lat_idx);
dt = datetime(time, 'ConvertFrom', 'datenum'); % 'time' 변수를 datetime 형식으로 변환
dt_str = datestr(dt, 'yyyy-mm-dd');

% CTD 변수
ctd_103_lat = ctd{5}.lat;
ctd_103_lon = ctd{5}.lon;
ctd_104_lat = ctd{6}.lat;
ctd_104_lon = ctd{6}.lon;
ctd_105_lat = ctd{7}.lat;
ctd_105_lon = ctd{7}.lon;

for i = 1:length(time_range) 
    time_idx = time_range(i);
    sst_for_time = ssts(lons_idx, lats_idx, time_idx);
    wu10_for_time = ug(lon_idx, lat_idx, time_idx);
    wv10_for_time = vg(lon_idx, lat_idx, time_idx);

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]);
    pcolor(lons, lats, sst_for_time');
    
    hold on;
    quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'on')
    plot(cllon, cllat, '.k'); 
    shading interp;
    
    colormap('jet')
    colorbar; 
    caxis([0, 30]); 

    xlabel('Longitude');
    ylabel('Latitude');
    title(['SST with Current at ', dt_str(time_idx, :)]);
    
    frame = getframe(gcf); 
    im = frame2im(frame); 

    [imind, cm] = rgb2ind(im, 256);
    if i == 1
        imwrite(imind, cm, gif_filename, 'gif', 'LoopCount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end
    
    close; 
end

%% 정선 관측 날짜의 SST와 유속 확인 + 그림 저장
clc; clear all; close all;

load('OSTIA_SST_daily_2007.mat');
load('coastline_around_Korea.mat');
load('ADT_geovel_daily_2007.mat');
load('CTD_bimonthly_2007.mat');

% SST 변수
lons_idx = find(lons >= 127.0 & lons <= 135);
lats_idx = find(lats >= 34.0 & lats <= 40);
lons = lons(lons_idx);
lats = lats(lats_idx);

% ADT 변수
lon_idx = find(lon >= 127.0 & lon <= 135);
lat_idx = find(lat >= 34.0 & lat <= 40);
lon = lon(lon_idx);
lat = lat(lat_idx);

% CTD 변수
ctd_102_lat = ctd{4}.lat;
ctd_102_lon = ctd{4}.lon;
ctd_103_lat = ctd{5}.lat;
ctd_103_lon = ctd{5}.lon;
ctd_104_lat = ctd{6}.lat;
ctd_104_lon = ctd{6}.lon;
ctd_105_lat = ctd{7}.lat;
ctd_105_lon = ctd{7}.lon;
ctd_106_lat = ctd{8}.lat;
ctd_106_lon = ctd{8}.lon;
ctd_107_lat = ctd{9}.lat;
ctd_107_lon = ctd{9}.lon;

time_indices = [46, 105, 166, 227, 288, 349]; % 정선 관측 날짜 index
day_indices = {'2007-02-15', '2007-04-15', '2007-06-15', '2007-08-15', '2007-10-15', '2007-12-15'};
num_plots = length(time_indices);

figure;
set(gcf, 'Position', [100, 100, 800, 1000]);
tiledlayout(3, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

for i = 1:length(time_indices)
    time_idx = time_indices(i);
    sst_for_time = ssts(lons_idx, lats_idx, time_idx);
    wu10_for_time = ug(lon_idx, lat_idx, time_idx);
    wv10_for_time = vg(lon_idx, lat_idx, time_idx);

    subplot(3, 2, i);
    pcolor(lons, lats, sst_for_time');
    shading interp;
    caxis([0, 25]);

    hold on;
    quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'on')
    plot(cllon, cllat, '.k');
    plot(ctd_107_lon, ctd_107_lat, 'k-', 'LineWidth', 2, 'Color', 'blue'); %% Line 표시
    shading interp;

    % 경로선에 주석 추가 (첫 번째 경로점에만)
    text(ctd_107_lon(1)-0.3, ctd_107_lat(1), sprintf('Line 107'), ... 
        'Color', 'blue', 'FontSize', 10, 'HorizontalAlignment', 'right'); %%%
    
    if mod(i, 2) == 1
        ylabel('Latitude');
    end
    if i > 4
        xlabel('Longitude');
    end
    title(day_indices{i});  
end

% 공통 컬러바 추가
colormap('jet')
h = colorbar;
h.Position = [0.92, 0.1, 0.02, 0.8];  
h.Label.String = 'SST (°C)';

sgtitle(['SST with Current']);  % 공통 타이틀

% 파일 저장
saveas(gcf, 'SST_with_current_line_107_subplots.png');  %
