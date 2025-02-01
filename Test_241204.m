%%% Test_241204

%% XX도 등온선 contour (동서방향)
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

time_idx = 51:91;
levels = 0:1:30;

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 등온선 
isoterm_5 = cell(length(time_idx), 1);

% 타겟 수온
target_temp = 10;
depth_idx = 1:31;

% 경도 고정
[~, lon_idx] = min(abs(lon - center_lon(t_idx)));
lat_idx = find(lat >= center_lat(t_idx)-1 & lat <= center_lat(t_idx)+1);

lat_range = lat(lat_idx);
depth_range = depth(depth_idx);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스

    % 관심 영역의 온도 데이터 추출
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, t)); 
    
    % 등온선 추출
    [C, h] = contour(lat_range, depth_range, temp_subset', [target_temp target_temp], 'LineColor', 'r');

    % 등온선 저장
    isoterm_5{t_idx} = C;
  
end

% 시각화 준비
figure;
hold on;
grid on;
xlabel('Latitude (°N)');
ylabel('Depth (m)');
title('10°C Isothermal Line');

% 사용자 정의 컬러맵 생성 (흰색에서 검정색으로 점진적 변화)
colors = [linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))'];

% 각 시간에 대해 등온선 시각화
for t_idx = 1:length(time_idx)
    C = isoterm_5{t_idx};
    if ~isempty(C)
        idx = 1; % 시작 인덱스
        while idx < size(C, 2)
            level = C(1, idx); % 레벨 정보
            num_points = C(2, idx); % 점 개수
            
            % 레벨 값과 점 개수 제외하고 좌표만 추출
            lat_values = C(1, idx + 1:idx + num_points);
            depth_values = C(2, idx + 1:idx + num_points);
            
            % 유효한 데이터가 있으면 플롯
            if ~isempty(lat_values)
                plot(lat_values, depth_values, 'Color', colors(t_idx, :), ...
                    'DisplayName', datestr(dates{t_idx}, 'yyyy-mm-dd'));
            end
            
            % 다음 등고선으로 이동
            idx = idx + num_points + 1; % 다음 등고선 헤더로 이동
        end
    end
end

% y축 뒤집기
set(gca, 'YDir', 'reverse');

hold off;

saveas(gcf, ['Isothermalline_10_fixed_lat.jpg']);


%% event 등온선 contour (동서방향)
% 시각화 준비
figure;
hold on;
grid on;
xlabel('Latitude (°N)');
ylabel('Depth (m)');
title('10°C Isothermal Line');

% 사용자 정의 컬러맵 생성 (흰색에서 검정색으로 점진적 변화)
colors = [linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))'];

% 시각화할 time_idx 필터 설정
visualize_times = [60, 75, 90];

% 각 시간에 대해 등온선 시각화
for t_idx = 1:length(time_idx)
    % 현재 시간 인덱스
    t = time_idx(t_idx);
    
    % 시각화할 시간인지 확인
    if ~ismember(t, visualize_times)
        continue; % 시각화 대상이 아니면 건너뜀
    end

    C = isoterm_5{t_idx};
    if ~isempty(C)
        idx = 1; % 시작 인덱스
        while idx < size(C, 2)
            level = C(1, idx); % 레벨 정보
            num_points = C(2, idx); % 점 개수
            
            % 레벨 값과 점 개수 제외하고 좌표만 추출
            lon_values = C(1, idx + 1:idx + num_points);
            depth_values = C(2, idx + 1:idx + num_points);
            
            % 유효한 데이터가 있으면 플롯
            if ~isempty(lon_values)
                plot(lon_values, depth_values, 'Color', colors(t_idx, :), ...
                    'DisplayName', datestr(dates{t_idx}, 'yyyy-mm-dd'));
            end
            
            % 다음 등고선으로 이동
            idx = idx + num_points + 1; % 다음 등고선 헤더로 이동
        end
    end
end

% y축 뒤집기
set(gca, 'YDir', 'reverse');

hold off;


saveas(gcf, ['Isothermalline_10_fixed_lon_event.jpg']);



%% 3일 간격 contour 시각화 (동서방향)
% 시각화 준비
figure;
hold on;
grid on;
xlabel('Longitude (°E)');
ylabel('Depth (m)');
title('10°C Isothermal Line');

% 사용자 정의 컬러맵 생성 (흰색에서 검정색으로 점진적 변화)
colors = [linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))'];

% 3일 간격으로 time_idx 필터링
filtered_time_idx = time_idx(1:3:end); % 3일 간격으로 선택

% 각 시간에 대해 등온선 시각화
for t_idx = 1:length(filtered_time_idx)
    original_idx = find(time_idx == filtered_time_idx(t_idx)); % 원래 인덱스 찾기
    C = isoterm_5{original_idx};
    if ~isempty(C)
        idx = 1; % 시작 인덱스
        while idx < size(C, 2)
            level = C(1, idx); % 레벨 정보
            num_points = C(2, idx); % 점 개수
            
            % 레벨 값과 점 개수 제외하고 좌표만 추출
            lon_values = C(1, idx + 1:idx + num_points);
            depth_values = C(2, idx + 1:idx + num_points);
            
            % 유효한 데이터가 있으면 플롯
            if ~isempty(lon_values)
                plot(lon_values, depth_values, 'Color', colors(original_idx, :), ...
                    'DisplayName', datestr(dates{original_idx}, 'yyyy-mm-dd'));
            end
            
            % 다음 등고선으로 이동
            idx = idx + num_points + 1; % 다음 등고선 헤더로 이동
        end
    end
end

% y축 뒤집기
set(gca, 'YDir', 'reverse');

hold off;

saveas(gcf, ['Isothermalline_10_fixed_lon_3day.jpg']);


%% XX도 등온선 contour (남북방향)
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

time_idx = 51:91;
levels = 0:1:30;

% 각 시간마다 zos 최대값이 나타나는 모든 위도, 경도 찾기
max_lat_all = cell(length(time_idx), 1);
max_lon_all = cell(length(time_idx), 1);
max_zos = cell(length(time_idx), 1);
dates = cell(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스
    
    % 현재 시간의 zos 데이터 추출
    zos_time = zos(lon_idx, lat_idx, t); 

    % zos 최대값 찾기
    max_zos{t_idx} = max(zos_time(:));  % 셀 배열에 저장
    
    % 최대값이 나타나는 모든 위치 찾기
    [row, col] = find(zos_time == max_zos{t_idx}); % 최대값이 나타나는 모든 인덱스
    
    % 해당 위치들의 위도와 경도
    max_lat_all{t_idx} = lat(lat_idx(col)); % 위도
    max_lon_all{t_idx} = lon(lon_idx(row)); % 경도    

    dates{t_idx} = dt(t); % 날짜 저장
end

% 각 시간에 대한 최대값이 나타나는 위도와 경도의 중심 계산
center_lat = NaN(length(time_idx), 1);
center_lon = NaN(length(time_idx), 1);

for t_idx = 1:length(time_idx)
    % 각 시간의 최대값이 나타나는 위도와 경도의 중심 계산
    center_lat(t_idx) = mean(max_lat_all{t_idx});
    center_lon(t_idx) = mean(max_lon_all{t_idx});
end

% 등온선 
isoterm_5 = cell(length(time_idx), 1);

% 타겟수온
target_temp = 10;
depth_idx = 1:31;

% 경도 고정
[~, lat_idx] = min(abs(lat - center_lat(t_idx)));
lon_idx = find(lon >= center_lon(t_idx)-1 & lon <= center_lon(t_idx)+1);

lon_range = lon(lon_idx);
depth_range = depth(depth_idx);

for t_idx = 1:length(time_idx)
    t = time_idx(t_idx); % 현재 시간 인덱스

    % 관심 영역의 온도 데이터 추출
    temp_subset = squeeze(temp(lon_idx, lat_idx, depth_idx, t)); 
    
    % 등온선 추출
    [C, h] = contour(lon_range, depth_range, temp_subset', [target_temp target_temp], 'LineColor', 'r');

    % 등온선 저장
    isoterm_5{t_idx} = C;
  
end

% 시각화 준비
figure;
hold on;
grid on;
xlabel('Longitude (°E)');
ylabel('Depth (m)');
title('10°C Isothermal Line');

% 사용자 정의 컬러맵 생성 (흰색에서 검정색으로 점진적 변화)
colors = [linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))'];

% 각 시간에 대해 등온선 시각화
for t_idx = 1:length(time_idx)
    C = isoterm_5{t_idx};
    if ~isempty(C)
        idx = 1; % 시작 인덱스
        while idx < size(C, 2)
            level = C(1, idx); % 레벨 정보
            num_points = C(2, idx); % 점 개수
            
            % 레벨 값과 점 개수 제외하고 좌표만 추출
            lon_values = C(1, idx + 1:idx + num_points);
            depth_values = C(2, idx + 1:idx + num_points);
            
            % 유효한 데이터가 있으면 플롯
            if ~isempty(lon_values)
                plot(lon_values, depth_values, 'Color', colors(t_idx, :), ...
                    'DisplayName', datestr(dates{t_idx}, 'yyyy-mm-dd'));
            end
            
            % 다음 등고선으로 이동
            idx = idx + num_points + 1; % 다음 등고선 헤더로 이동
        end
    end
end

% y축 뒤집기
set(gca, 'YDir', 'reverse');

hold off;

saveas(gcf, ['Isothermalline_10_fixed_lon.jpg']);


%% event 등온선 contour (남북방향)
% 시각화 준비
figure;
hold on;
grid on;
xlabel('Longitude (°E)');
ylabel('Depth (m)');
title('10°C Isothermal Line');

% 사용자 정의 컬러맵 생성 (흰색에서 검정색으로 점진적 변화)
colors = [linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))'];

% 시각화할 time_idx 필터 설정
visualize_times = [60, 75, 90];

% 각 시간에 대해 등온선 시각화
for t_idx = 1:length(time_idx)
    % 현재 시간 인덱스
    t = time_idx(t_idx);
    
    % 시각화할 시간인지 확인
    if ~ismember(t, visualize_times)
        continue; % 시각화 대상이 아니면 건너뜀
    end

    C = isoterm_5{t_idx};
    if ~isempty(C)
        idx = 1; % 시작 인덱스
        while idx < size(C, 2)
            level = C(1, idx); % 레벨 정보
            num_points = C(2, idx); % 점 개수
            
            % 레벨 값과 점 개수 제외하고 좌표만 추출
            lat_values = C(1, idx + 1:idx + num_points); % lat으로 변경
            depth_values = C(2, idx + 1:idx + num_points);
            
            % 유효한 데이터가 있으면 플롯
            if ~isempty(lat_values)
                plot(lat_values, depth_values, 'Color', colors(t_idx, :), ...
                    'DisplayName', datestr(dates{t_idx}, 'yyyy-mm-dd'));
            end
            
            % 다음 등고선으로 이동
            idx = idx + num_points + 1; % 다음 등고선 헤더로 이동
        end
    end
end

% y축 뒤집기
set(gca, 'YDir', 'reverse');

hold off;

saveas(gcf, ['Isothermalline_10_fixed_lat_event.jpg']);

%% 3일 간격 contour 시각화 (남북방향)
% 시각화 준비
figure;
hold on;
grid on;
xlabel('Latitude (°N)');
ylabel('Depth (m)');
title('10°C Isothermal Line');

% 사용자 정의 컬러맵 생성 (흰색에서 검정색으로 점진적 변화)
colors = [linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))', linspace(1, 0, length(time_idx))'];

% 3일 간격으로 time_idx 필터링
filtered_time_idx = time_idx(1:3:end); % 3일 간격으로 선택

% 각 시간에 대해 등온선 시각화
for t_idx = 1:length(filtered_time_idx)
    original_idx = find(time_idx == filtered_time_idx(t_idx)); % 원래 인덱스 찾기
    C = isoterm_5{original_idx};
    if ~isempty(C)
        idx = 1; % 시작 인덱스
        while idx < size(C, 2)
            level = C(1, idx); % 레벨 정보
            num_points = C(2, idx); % 점 개수
            
            % 레벨 값과 점 개수 제외하고 좌표만 추출
            lat_values = C(1, idx + 1:idx + num_points); % lat으로 변경
            depth_values = C(2, idx + 1:idx + num_points);
            
            % 유효한 데이터가 있으면 플롯
            if ~isempty(lat_values)
                plot(lat_values, depth_values, 'Color', colors(original_idx, :), ...
                    'DisplayName', datestr(dates{original_idx}, 'yyyy-mm-dd'));
            end
            
            % 다음 등고선으로 이동
            idx = idx + num_points + 1; % 다음 등고선 헤더로 이동
        end
    end
end

% y축 뒤집기
set(gca, 'YDir', 'reverse');

hold off;

saveas(gcf, ['Isothermalline_10_fixed_lat_3day.jpg']);


