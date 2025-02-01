% Test_241007

%%% 표층 수온 자료
clc; clear all; close all;

load('SST_daily_2007.mat')  % 표층 수온 자료

time_range = 1:365

% 울릉도
lon_marker = 130.86;
lat_marker = 37.5;

for i = length(time_range):-1:1
    time_idx = time_range(i);
    sst_for_time = ssts(:, :, time_idx);

    figure;
    pcolor(lons, lats, sst_for_time');
    shading interp;
    colorbar;
    
    % colorbar 범위 설정
    caxis([0, 30]); % 최소값과 최대값으로 범위 설정

    hold on;
    plot(lon_marker, lat_marker, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none');

    xlabel('Longitude')
    ylabel('Latitude')
    title(['SST at time\_idx = ', num2str(time_idx)]);
    
    pause(0.2);
end


%%% ADT 자료(표층 유속)
clc; clear all; close all;

load('ADT_geovel_daily_2007.mat')   % ADT 자료(표층 유속)

time_range = 1:10;

% 울릉도
lon_marker = 130.86;
lat_marker = 37.5;

for i = 1:length(time_range)
    time_idx = time_range(i);
    ug_for_time = ug(:, :, time_idx);
    vg_for_time = vg(:, :, time_idx);
    adt_for_time = adt(:, :, time_idx);

    figure;
    pcolor(lon, lat, adt_for_time');
    shading interp;
    colorbar;

    hold on;
    quiver(lon, lat, ug_for_time', vg_for_time', 'color', 'k', 'autoscale', 'on')
    
    plot(lon_marker, lat_marker, 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r')

    xlabel('Longitude');
    ylabel('Latitude');
    title(['ADT at time\_idx = ', num2str(time_idx)]);

    pause(0.1);
end

%%% 수온, 염분 자료 (표층-500m)
clc; clear all; close all;

load('CTD_bimonthly_2007.mat');

temp_207 = ctd{1}.temp;
% sal_207 = ctd{1}.sal;
% pden_207 = ctd{1}.sal;
% DO_207 = ctd{1}.DO;
lat_207 = ctd{1}.lat;
lon_207 = ctd{1}.lon;

time_idx = 6

temp_207_for_time = temp_207(:, :, time_idx);
% sal_207_for_time = sal_207(:, :, time_idx);

figure;

for i = 1:3
    lat_idx = lat_207(i);
    lon_idx = lon_207(i);

    temp_profile = temp_207_for_time(:, i);
    % sal_profile = sal_207_for_time(:, i);

    subplot(1, 3, i);
    plot(temp_profile, depth);
    % plot(sal_profile, depth);
    set(gca, 'Ydir', 'reverse');

    xlabel('Temp')
    ylabel('Depth')
    title(['lat : ', num2str(lat_idx), '\newline lon : ', num2str(lon_idx)]);

    grid on;
end

sgtitle('Temperature Profile at Line 207'); % 전체 제목 설정

