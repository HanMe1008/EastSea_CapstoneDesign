% Test_241025
clc; clear all; close all;

%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

%%% COASTLINE
load('coastline_around_Korea.mat')
figure
plot(cllon,cllat,'.k') 

%%% ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

%%% HYCOM 자료와 CTD 자료 비교

%% CTD 자료
clc; clear all; close all;

load('CTD_bimonthly_2007.mat')

% 102 LINE
ctd_102_lat = ctd{4}.lat;
ctd_102_lon = ctd{4}.lon;
ctd_102_temp = ctd{4}.temp;
ctd_102_sal = ctd{4}.temp;
ctd_102_pden = ctd{4}.pden;
ctd_102_statn = ctd{4}.statn;
ctd_102_DO = ctd{4}.DO;
ctd_102_line = num2str(ctd{4}.line);

% 103 LINE
ctd_103_lat = ctd{5}.lat;
ctd_103_lon = ctd{5}.lon;
ctd_103_temp = ctd{5}.temp;
ctd_103_sal = ctd{5}.sal;
ctd_103_pden = ctd{5}.pden;
ctd_103_statn = ctd{5}.statn;
ctd_103_DO = ctd{5}.DO;
ctd_103_line = num2str(ctd{5}.line);

% 104 LINE
ctd_104_lat = ctd{6}.lat;
ctd_104_lon = ctd{6}.lon;
ctd_104_temp = ctd{6}.temp;
ctd_104_sal = ctd{6}.sal;
ctd_104_pden = ctd{6}.pden;
ctd_104_statn = ctd{6}.statn;
ctd_104_DO = ctd{6}.DO;
ctd_104_line = num2str(ctd{6}.line);

% 105 LINE
ctd_105_lat = ctd{7}.lat;
ctd_105_lon = ctd{7}.lon;
ctd_105_temp = ctd{7}.temp;
ctd_105_sal = ctd{7}.sal;
ctd_105_pden = ctd{7}.pden;
ctd_105_statn = ctd{7}.statn;
ctd_105_DO = ctd{7}.DO;
ctd_105_line = num2str(ctd{7}.line);

% 106 LINE
ctd_106_lat = ctd{8}.lat;
ctd_106_lon = ctd{8}.lon;
ctd_106_temp = ctd{8}.temp;
ctd_106_sal = ctd{8}.sal;
ctd_106_pden = ctd{8}.pden;
ctd_106_statn = ctd{8}.statn;
ctd_106_DO = ctd{8}.DO;
ctd_106_line = num2str(ctd{8}.line);

% 107 LINE
ctd_107_lat = ctd{9}.lat;
ctd_107_lon = ctd{9}.lon;
ctd_107_temp = ctd{9}.temp;
ctd_107_sal = ctd{9}.sal;
ctd_107_pden = ctd{9}.pden;
ctd_107_statn = ctd{9}.statn;
ctd_107_DO = ctd{9}.DO;
ctd_107_line = num2str(ctd{9}.line);

%%% 시각화
% selected_date = datetime(times(2, :));
% date_str = datestr(selected_date, 'yyyy-mm-dd');
% 
% ctd_102_temp_day = ctd_102_temp(:,:,2);
% 
% contourf(ctd_102_lon, depth, ctd_102_temp_day, 20, 'LineColor', 'none');
% set(gca, 'YDir', 'reverse');
% colormap("jet")
% colorbar;
% caxis([0, 25])
% 
% xlabel('Longitude (°E)');
% ylabel('Depth (m)');
% title(['CTD Temp / ', date_str, ' / Line : ', ctd_102_line]);
% grid on;


%% CTD_Temp_Line_NUM_DATE
for i = 1:size(times, 1)
    selected_date = datetime(times(i, :));
    date_str = datestr(selected_date, 'yyyy-mm-dd');

    ctd_107_temp_day = ctd_107_temp(1:15,:,i); %%

    contourf(ctd_107_lon, depth(1:15), ctd_107_temp_day, 20, 'LineColor', 'none'); %%
    set(gca, 'YDir', 'reverse');
    colormap("jet");
    colorbar;
    caxis([0, 25]);

    xlabel('Longitude (°E)');
    ylabel('Depth (m)');
    title(['CTD Temp / ', date_str, ' / Line : ', ctd_107_line]); %
    grid on;

    filename = ['CTD_Temp_Line_107 ', date_str, '.png']; %
    saveas(gcf, filename); 
    close(gcf);
end


%% CTD_Temp_Line_NUM_subplot
figure;

for i = 1:size(times, 1) 
    selected_date = datetime(times(i, :));
    date_str = datestr(selected_date, 'yyyy-mm-dd');

    ctd_107_temp_day = ctd_107_temp(1:15,:,i); %%
    subplot(3, 2, i);
    
    h = contourf(ctd_107_lon, depth(1:15), ctd_107_temp_day, 20, 'LineColor', 'none'); %%
    set(gca, 'YDir', 'reverse');
    colormap("jet"); 
    caxis([0, 25]);

    xlabel('Longitude (°E)');
    ylabel('Depth (m)');
    title(['CTD Temp / ', date_str, ' / Line : ', ctd_107_line]); %
    grid on;

    if i == size(times, 1)
        cb = colorbar;
        cb.Label.String = 'Temperature (°C)';
        cb.Position = [0.92 0.11 0.02 0.815]; 
    end
end

set(gcf, 'Position', [100, 100, 800, 1000]);

saveas(gcf, 'CTD_Temp_Line_107_Subplots.png'); % 
close(gcf); 


%% HYCOM 자료
clc; clear all; close all;

% CTD 자료 안에 depth 변수가 HYCOM 변수와 겹쳐서 앞으로 뺌
load('CTD_bimonthly_2007.mat')
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

% 위도 고정, 깊이에 따른 수온
load('.\HYCOM_data\2007\hycES_2007_02_15_00_Reanalysis.mat');
date_0215 = hyc.date;
temp_0215 = hyc.temp;
date_0215_str = datestr(date_0215, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_04_15_00_Reanalysis.mat');
date_0415 = hyc.date;
temp_0415 = hyc.temp;
date_0415_str = datestr(date_0415, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_06_15_00_Reanalysis.mat');
date_0615 = hyc.date;
temp_0615 = hyc.temp;
date_0615_str = datestr(date_0615, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_08_15_00_Reanalysis.mat');
date_0815 = hyc.date;
temp_0815 = hyc.temp;
date_0815_str = datestr(date_0815, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_10_15_00_Reanalysis.mat');
date_1015 = hyc.date;
temp_1015 = hyc.temp;
date_1015_str = datestr(date_1015, 'yyyy-mm-dd');
load('.\HYCOM_data\2007\hycES_2007_12_15_00_Reanalysis.mat');
date_1215 = hyc.date;
temp_1215 = hyc.temp;
date_1215_str = datestr(date_1215, 'yyyy-mm-dd');

lat = hyc.lat;
lon = hyc.lon;
depth = hyc.dep;



% lon&lat indexing
[~, lat_102_idx] = min(abs(lat - ctd_102_lat(1)));
[~, lat_103_idx] = min(abs(lat - ctd_103_lat(1)));
[~, lat_104_idx] = min(abs(lat - ctd_104_lat(1)));
[~, lat_105_idx] = min(abs(lat - ctd_105_lat(1)));
[~, lat_106_idx] = min(abs(lat - ctd_106_lat(1)));
[~, lat_107_idx] = min(abs(lat - ctd_107_lat(1)));

lon_102_idx = find(lon >= min(ctd_102_lon) & lon <= max(ctd_102_lon));
lon_103_idx = find(lon >= min(ctd_103_lon) & lon <= max(ctd_103_lon));
lon_104_idx = find(lon >= min(ctd_104_lon) & lon <= max(ctd_104_lon));
lon_105_idx = find(lon >= min(ctd_105_lon) & lon <= max(ctd_105_lon));
lon_106_idx = find(lon >= min(ctd_106_lon) & lon <= max(ctd_106_lon));
lon_107_idx = find(lon >= min(ctd_107_lon) & lon <= max(ctd_107_lon));

lon_102_range = lon(lon_102_idx);
lon_103_range = lon(lon_103_idx);
lon_104_range = lon(lon_104_idx);
lon_105_range = lon(lon_105_idx);
lon_106_range = lon(lon_106_idx);
lon_107_range = lon(lon_107_idx);

depth_idx = 1:29; 
depth_range = depth(depth_idx);

% 0215
temp_0215_subset_102 = squeeze(temp_0215(lon_102_idx, lat_102_idx, depth_idx));
temp_0215_subset_103 = squeeze(temp_0215(lon_103_idx, lat_103_idx, depth_idx));
temp_0215_subset_104 = squeeze(temp_0215(lon_104_idx, lat_104_idx, depth_idx));
temp_0215_subset_105 = squeeze(temp_0215(lon_105_idx, lat_105_idx, depth_idx));
temp_0215_subset_106 = squeeze(temp_0215(lon_106_idx, lat_106_idx, depth_idx));
temp_0215_subset_107 = squeeze(temp_0215(lon_107_idx, lat_107_idx, depth_idx));

% 0415
temp_0415_subset_102 = squeeze(temp_0415(lon_102_idx, lat_102_idx, depth_idx));
temp_0415_subset_103 = squeeze(temp_0415(lon_103_idx, lat_103_idx, depth_idx));
temp_0415_subset_104 = squeeze(temp_0415(lon_104_idx, lat_104_idx, depth_idx));
temp_0415_subset_105 = squeeze(temp_0415(lon_105_idx, lat_105_idx, depth_idx));
temp_0415_subset_106 = squeeze(temp_0415(lon_106_idx, lat_106_idx, depth_idx));
temp_0415_subset_107 = squeeze(temp_0415(lon_107_idx, lat_107_idx, depth_idx));

% 0615
temp_0615_subset_102 = squeeze(temp_0615(lon_102_idx, lat_102_idx, depth_idx));
temp_0615_subset_103 = squeeze(temp_0615(lon_103_idx, lat_103_idx, depth_idx));
temp_0615_subset_104 = squeeze(temp_0615(lon_104_idx, lat_104_idx, depth_idx));
temp_0615_subset_105 = squeeze(temp_0615(lon_105_idx, lat_105_idx, depth_idx));
temp_0615_subset_106 = squeeze(temp_0615(lon_106_idx, lat_106_idx, depth_idx));
temp_0615_subset_107 = squeeze(temp_0615(lon_107_idx, lat_107_idx, depth_idx));

% 0815
temp_0815_subset_102 = squeeze(temp_0815(lon_102_idx, lat_102_idx, depth_idx));
temp_0815_subset_103 = squeeze(temp_0815(lon_103_idx, lat_103_idx, depth_idx));
temp_0815_subset_104 = squeeze(temp_0815(lon_104_idx, lat_104_idx, depth_idx));
temp_0815_subset_105 = squeeze(temp_0815(lon_105_idx, lat_105_idx, depth_idx));
temp_0815_subset_106 = squeeze(temp_0815(lon_106_idx, lat_106_idx, depth_idx));
temp_0815_subset_107 = squeeze(temp_0815(lon_107_idx, lat_107_idx, depth_idx));

% 1015
temp_1015_subset_102 = squeeze(temp_1015(lon_102_idx, lat_102_idx, depth_idx));
temp_1015_subset_103 = squeeze(temp_1015(lon_103_idx, lat_103_idx, depth_idx));
temp_1015_subset_104 = squeeze(temp_1015(lon_104_idx, lat_104_idx, depth_idx));
temp_1015_subset_105 = squeeze(temp_1015(lon_105_idx, lat_105_idx, depth_idx));
temp_1015_subset_106 = squeeze(temp_1015(lon_106_idx, lat_106_idx, depth_idx));
temp_1015_subset_107 = squeeze(temp_1015(lon_107_idx, lat_107_idx, depth_idx));

% 1215
temp_1215_subset_102 = squeeze(temp_1215(lon_102_idx, lat_102_idx, depth_idx));
temp_1215_subset_103 = squeeze(temp_1215(lon_103_idx, lat_103_idx, depth_idx));
temp_1215_subset_104 = squeeze(temp_1215(lon_104_idx, lat_104_idx, depth_idx));
temp_1215_subset_105 = squeeze(temp_1215(lon_105_idx, lat_105_idx, depth_idx));
temp_1215_subset_106 = squeeze(temp_1215(lon_106_idx, lat_106_idx, depth_idx));
temp_1215_subset_107 = squeeze(temp_1215(lon_107_idx, lat_107_idx, depth_idx));

%% HYCOM_Temp_Line_NUM_DATE
% 날짜 배열 및 날짜 문자열 배열
dates = {temp_0215, temp_0415, temp_0615, temp_0815, temp_1015, temp_1215};
date_strs = {date_0215_str, date_0415_str, date_0615_str, date_0815_str, date_1015_str, date_1215_str};

% 위치 배열
lat_idxs = [lat_102_idx, lat_103_idx, lat_104_idx, lat_105_idx, lat_106_idx, lat_107_idx];
lon_idxs = {lon_102_idx, lon_103_idx, lon_104_idx, lon_105_idx, lon_106_idx, lon_107_idx};
lines = {'102', '103', '104', '105', '106', '107'};

% 반복문을 통해 각 날짜 및 위치별 그래프 생성 및 저장
for i = 1:length(dates)
    for j = 1:length(lines)
        % temp 데이터의 서브셋 생성
        temp_subset = squeeze(dates{i}(lon_idxs{j}, lat_idxs(j), depth_idx));
        
        % 그림 생성
        figure;
        contourf(lon(lon_idxs{j}), depth_range, temp_subset', 20, 'LineColor', 'none');
        set(gca, 'YDir', 'reverse');
        colormap("jet");
        colorbar;
        caxis([0, 25]);
        
        % 축 및 제목 설정
        xlabel('Longitude (°E)');
        ylabel('Depth (m)');
        title(['HYCOM Temp / ', date_strs{i}, ' / Line : ', lines{j}]);
        grid on;
        
        % 이미지 파일 저장
        filename = ['HYCOM_Temp_Line_', lines{j}, ' ', date_strs{i}, '.png'];
        saveas(gcf, filename);
        close(gcf); % 저장 후 창 닫기
    end
end

%% HYCOM_Temp_Line_NUM_subplot
% 날짜 배열 및 날짜 문자열 배열
dates = {temp_0215, temp_0415, temp_0615, temp_0815, temp_1015, temp_1215};
date_strs = {date_0215_str, date_0415_str, date_0615_str, date_0815_str, date_1015_str, date_1215_str};

% 위치 배열
lat_idxs = [lat_102_idx, lat_103_idx, lat_104_idx, lat_105_idx, lat_106_idx, lat_107_idx];
lon_idxs = {lon_102_idx, lon_103_idx, lon_104_idx, lon_105_idx, lon_106_idx, lon_107_idx};
lines = {'102', '103', '104', '105', '106', '107'};

% 반복문을 통해 각 line에 대해 모든 날짜별 그래프 생성 및 저장
for j = 1:length(lines)
    figure('Position', [100, 100, 800, 1000]); % Figure 크기 설정
    sgtitle(['HYCOM Temp / Line : ', lines{j}]); % 서브플롯 제목
    
    for i = 1:length(dates)
        % temp 데이터의 서브셋 생성
        temp_subset = squeeze(dates{i}(lon_idxs{j}, lat_idxs(j), depth_idx));
        
        % 서브플롯 생성
        subplot(3, 2, i); % 3x2 레이아웃으로 서브플롯 구성
        contourf(lon(lon_idxs{j}), depth_range, temp_subset', 20, 'LineColor', 'none');
        set(gca, 'YDir', 'reverse');
        colormap("jet");
        caxis([0, 25]);
        
        % 축 및 제목 설정
        xlabel('Longitude (°E)');
        ylabel('Depth (m)');
        title([date_strs{i}]);
        grid on;
    end
    
    % 공통 컬러바 추가
    h = colorbar;
    h.Position = [0.93 0.11 0.02 0.815]; % 전체 그림 기준으로 위치 조정

    % 이미지 파일 저장
    filename = ['HYCOM_Temp_Line_', lines{j}, '_Subplots.png'];
    saveas(gcf, filename);
    close(gcf); % 저장 후 창 닫기
end

%% ADT + current > GIF로 저장
clc; clear all; close all;

load('ADT_geovel_daily_2007.mat')
load('coastline_around_Korea.mat')

time_range = 182:365;
gif_filename = 'ADT_animation_since_Jul.gif';

frame_width = 800; 
frame_height = 600; 

dt = datetime(time, 'ConvertFrom', 'datenum'); % 'time' 변수를 datetime 형식으로 변환
dt_str = datestr(dt, 'yyyy-mm-dd');

lon_idx = find(lon >= 127.0 & lon <= 135);
lat_idx = find(lat >= 34.0 & lat <= 40);

lon = lon(lon_idx);
lat = lat(lat_idx);

for i = 1:length(time_range)
    time_idx = time_range(i);
    adt_for_time = adt(lon_idx, lat_idx, time_idx);
    wu10_for_time = ug(lon_idx, lat_idx, time_idx);
    wv10_for_time = vg(lon_idx, lat_idx, time_idx);

    figure('Visible', 'off', 'Position', [100, 100, frame_width, frame_height]); 
    pcolor(lon, lat, adt_for_time'); 
    shading interp; 
    colorbar;
    caxis([0, 1.3]); 

    hold on;
    quiver(lon, lat, wu10_for_time', wv10_for_time', 'color', 'k', 'autoscale', 'on')
    plot(cllon, cllat, '.k'); 

    xlabel('Longitude');
    ylabel('Latitude');
    title(['ADT at ', dt_str(time_idx, :)]);

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



