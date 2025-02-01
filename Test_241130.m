%%% Test_241130

%% 수심 0.49m contour 내부 에디 특성 정량화
clc; clear all; close all;

% 파일 경로
glo_temp_and_sal = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_Temp_and_Sal.nc';
glo_velocity = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_V.nc';
glo_ssh = 'cmems_mod_glo_phy_my_0.083deg_P1D-m_SSH.nc';

% 데이터 읽기
temp = ncread(glo_temp_and_sal, 'thetao');  % temp(lon, lat, depth, time)
sal = ncread(glo_temp_and_sal, 'so');       % sal(lon, lat, depth, time)
vo = ncread(glo_velocity, 'vo');            % 북향 속도 (lon, lat, depth, time)
uo = ncread(glo_velocity, 'uo');            % 동향 속도 (lon, lat, depth, time)
zos = ncread(glo_ssh, 'zos');               % SSH (lon, lat, time)

time = ncread(glo_ssh, 'time');
lon = ncread(glo_ssh, 'longitude');
lat = ncread(glo_ssh, 'latitude');
depth = ncread(glo_velocity, 'depth');

% 시간 변환
reference_time = datetime(1970, 1, 1, 0, 0, 0); % 기준 시간
dt = reference_time + seconds(time);

% 파라미터 설정
time_idx = 90;  
depth_idx = 1; % 표층 (depth = 1), 92.3m (depth = 22)
levels = -0.1:0.02:0.5;

% 관심 있는 위도 및 경도 범위 설정
lat_range = [37.1, 38.95]; % 관심 위도 범위
lon_range = [129.7, 131.75]; % 관심 경도 범위

% 위도와 경도 인덱스 추출
lat_idx = find(lat >= lat_range(1) & lat <= lat_range(2)); % 위도 인덱스
lon_idx = find(lon >= lon_range(1) & lon <= lon_range(2)); % 경도 인덱스

% 제한된 범위의 데이터 추출
lon_sub = lon(lon_idx); % 경도
lat_sub = lat(lat_idx); % 위도
SSH_sub = zos(lon_idx, lat_idx, time_idx); % 제한된 SSH 데이터
temp_sub = temp(lon_idx, lat_idx, depth_idx, time_idx); % 제한된 temp 데이터 (표층)
salt_sub = sal(lon_idx, lat_idx, depth_idx, time_idx); % 제한된 salt 데이터 (표층)
uo_sub = uo(lon_idx, lat_idx, depth_idx, time_idx); % 제한된 uo 데이터
vo_sub = vo(lon_idx, lat_idx, depth_idx, time_idx); % 제한된 vo 데이터

% 유속 계산
velocity_sub = sqrt(uo_sub.^2 + vo_sub.^2); % 유속 = sqrt(uo^2 + vo^2)

% 제한된 범위의 SSH 등고선 플롯
figure;
[c, h] = contourf(lon_sub, lat_sub, SSH_sub', levels); % 기본 SSH 등고선
hold on;
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title(sprintf('SSH contour (%s)', datestr(dt(time_idx), 'yyyy-mm-dd')));

% 특정 등고선 강조
target_level = 0.24; % 원하는 contour level
[c_single, h_single] = contour(lon_sub, lat_sub, SSH_sub', [target_level, target_level], 'k-', 'LineWidth', 2); % 강조 등고선

% 특정 등고선 내부 영역만 선택
if ~isempty(c_single)
    % 등고선 경계 추출
    idx = find(c_single(1,:) == target_level, 1); % 해당 level의 시작점 인덱스
    num_points = c_single(2, idx); % 경계점 개수
    x_boundary = c_single(1, idx+1:idx+num_points); % 경계의 x 좌표
    y_boundary = c_single(2, idx+1:idx+num_points); % 경계의 y 좌표

    % 경계 내부 점 찾기
    [X, Y] = meshgrid(lon_sub, lat_sub);
    in = inpolygon(X, Y, x_boundary, y_boundary); % 내부 점 마스킹

    % 경계 내부 velocity, temp, salt 값 추출
    velocity_inside = velocity_sub(in'); % 경계 내부 유속 값
    temp_inside = temp_sub(in'); % 경계 내부 temp 값
    salt_inside = salt_sub(in'); % 경계 내부 salt 값
    SSH_inside = SSH_sub(in'); % 경계 내부 SSH 값

    % velocity 값의 평균 및 최대값 계산
    mean_velocity = mean(velocity_inside, 'omitnan'); % NaN 제외 유속 평균
    max_velocity = max(velocity_inside, [], 'omitnan'); % NaN 제외 최대 유속

    % 최대값 위치 확인
    [max_row_velocity, max_col_velocity] = find(velocity_sub == max_velocity); % 유속 최대값 위치
    max_lon_velocity = lon_sub(max_row_velocity);
    max_lat_velocity = lat_sub(max_col_velocity);

    % % temp 값의 평균 계산
    % mean_temp = mean(temp_inside, 'omitnan'); % NaN 제외 평균
    % 
    % % salt 값의 평균 계산
    % mean_salt = mean(salt_inside, 'omitnan'); % NaN 제외 평균
    % 
    % % 에디 면적 계산
    % total_elements = numel(in);
    % area_eddy = total_elements * 50;
    % 
    % % SSH 최대값과 최소값 차이 계산
    % max_SSH = max(SSH_inside, [], 'omitnan'); % 경계 내부 SSH 최대값
    % min_SSH = min(SSH_inside, [], 'omitnan'); % 경계 내부 SSH 최소값
    % SSH_diff = max_SSH - min_SSH; % 최대값과 최소값 차이    

    % % 결과 출력
    % fprintf('Contour level %.2f 내부 유속 평균: %.4f\n', target_level, mean_velocity);
    % fprintf('Contour level %.2f 내부 유속 최대값: %.4f (위도: %.2f, 경도: %.2f)\n', target_level, max_velocity, max_lat_velocity, max_lon_velocity);
    % fprintf('Contour level %.2f 내부 temp 평균: %.4f\n', target_level, mean_temp);
    % fprintf('Contour level %.2f 내부 salt 평균: %.4f\n', target_level, mean_salt);
    % fprintf('Contour level %.2f 내부 SSH 최대값과 최소값 차이: %.4f\n', target_level, SSH_diff);
    % fprintf('%.1f km^2 at %s', area_eddy, datestr(dt(time_idx)));


    % 강조된 등고선 및 최대값 위치 표시
    plot(x_boundary, y_boundary, 'r-', 'LineWidth', 2); % 경계선을 강조 (빨간색)
    scatter(max_lon_velocity, max_lat_velocity, 80, 'w', 'filled'); % 유속 최대값 위치 강조
    text(max_lon_velocity, max_lat_velocity, sprintf('%.2f cm/s', max_velocity*100), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', 'white', 'FontWeight', 'bold');
else
    fprintf('Target contour level %.2f이 존재하지 않습니다.\n', target_level);
end

% 그림 저장
saveas(gcf, sprintf('Eddy_mean_%s.png', datestr(dt(time_idx), 'yyyy-mm-dd')));





%% 내부의 점 확인
% 위도, 경도 그리드 생성
% [X, Y] = meshgrid(lon_sub, lat_sub);
% 
% % 내부점에 해당하는 경도 및 위도 추출
% x_in = X(in);
% y_in = Y(in);
% 
% % 플롯
% figure;
% hold on;
% 
% % 전체 영역의 점 표시
% scatter(X(:), Y(:), 10, 'b', 'filled', 'DisplayName', 'outter point'); % 전체 점 (파란색)
% 
% % 내부점 표시
% scatter(x_in, y_in, 20, 'r', 'filled', 'DisplayName', 'inner point'); % 내부 점 (빨간색)
% 
% % 등고선 및 경계 표시
% contour(lon_sub, lat_sub, SSH_sub', levels, 'k-'); % SSH 등고선
% plot(x_boundary, y_boundary, 'g-', 'LineWidth', 2, 'DisplayName', 'boundary'); % 특정 등고선 강조 (초록색)
% 
% % 그래프 설정
% xlabel('Longitude');
% ylabel('Latitude');
% legend show;
% title('Selected data');
% grid on;
% hold off;
