%%% Test_241202

%% SSH Amplitude
clc; clear all; close all;

% 데이터
dates = datetime(2007, 7, 30):datetime(2007, 8, 29); 
ssh_diff = [0.0842, 0.0888, 0.0812, 0.0809, 0.0818, 0.0928, ...
                    0.1047, 0.1016, 0.1154, 0.1141, 0.1376, ...
                    0.1361, 0.1389, 0.1462, 0.1337, 0.1477, ...
                    0.1410, 0.1389, 0.1419, 0.1291, 0.1257, ...
                    0.1233, 0.1202, 0.1096, 0.1187, 0.1090, ...
                    0.1041, 0.0931, 0.0983, 0.0772, 0.0818];

% 그림 그리기
figure;
plot(dates, ssh_diff, '-o');
xlabel('Date');
ylabel('SSH Amplitude (m)');
title('SSH Amplitude');
xtickformat('yyyy-MM-dd');  % 날짜 형식 설정

% 그래프 저장
saveas(gcf, 'SSH_amplitude.png');


%% Mean Velocity
clc; clear all; close all;

% 데이터
dates = datetime(2007, 7, 30):datetime(2007, 8, 29);  % 날짜 예시
mean_velocity = [0.2378, 0.2469, 0.2723, 0.2299, 0.2283, ...
                 0.2176, 0.2367, 0.2335, 0.2427, 0.2880, ...
                 0.2507, 0.2481, 0.2429, 0.2530, 0.2452, ...
                 0.2534, 0.2471, 0.2471, 0.2544, 0.2423, ...
                 0.2431, 0.2464, 0.2260, 0.2538, 0.2621, ...
                 0.2616, 0.2580, 0.2528, 0.2569, 0.2383, 0.2460];

% 그림 그리기
figure;
plot(dates, mean_velocity, '-o');
xlabel('Date');
ylabel('velocity (m/s)');
title('Mean Velocity');
xtickformat('yyyy-MM-dd');  % 날짜 형식 설정

% 그래프 저장
saveas(gcf, 'Mean_Velocity.png');


%% Max Velocity
clc; clear all; close all;

% 데이터
dates = datetime(2007, 7, 30):datetime(2007, 8, 29);  % 날짜 예시
max_velocity = [0.4181, 0.4145, 0.4703, 0.3429, 0.4171, ...
                 0.3328, 0.4266, 0.4204, 0.4972, 0.5372, ...
                 0.4985, 0.5921, 0.6959, 0.7821, 0.6685, ...
                 0.6725, 0.6220, 0.6049, 0.6105, 0.5984, ...
                 0.5669, 0.5076, 0.4750, 0.5327, 0.5775, ...
                 0.5435, 0.4814, 0.4740, 0.4658, 0.4287, 0.4237];

% 그림 그리기
figure;
plot(dates, max_velocity, '-o');
xlabel('Date');
ylabel('Velocity (m/s)');
title('Max Velocity');
xtickformat('yyyy-MM-dd');  % 날짜 형식 설정

% 그래프 저장
saveas(gcf, 'Max_Velocity.png');


%% Mean Temp
clc; clear all; close all;

% 데이터
dates = datetime(2007, 7, 30):datetime(2007, 8, 29);  % 날짜 예시
mean_temp = [23.4762, 23.6882, 23.8345, 24.2295, 23.8977, ...
            24.1962, 24.5317, 24.4057, 24.3173, 23.8396, ...
            23.5517, 23.7221, 23.9858, 23.9762, 24.0978, ...
            24.0559, 24.2953, 24.7549, 25.4347, 25.9116, ...
            26.3885, 26.4341, 25.6289, 25.5645, 25.6609, ...
            25.6716, 26.0769, 26.5301, 26.2347, 26.1094, 25.738];

% 그림 그리기
figure;
plot(dates, mean_temp, '-o');
xlabel('Date');
ylabel('Temperature (°C)');
title('Mean Temperature');
xtickformat('yyyy-MM-dd');  % 날짜 형식 설정

% 그래프 저장
saveas(gcf, 'Mean_Temperature.png');



%% Mean Salt
clc; clear all; close all;

% 데이터
dates = datetime(2007, 7, 30):datetime(2007, 8, 29);  
mean_salt = [33.4831, 33.4244, 33.3095, 33.1695, 33.2675, ...
             33.1255, 32.9806, 32.9815, 32.8971, 32.9581, ...
             32.9890, 32.9480, 32.9692, 33.0277, 33.1209, ...
             33.1663, 33.2380, 33.2735, 33.2830, 33.3156, ...
             33.3602, 33.4036, 33.4297, 33.4861, 33.4989, ...
             33.5213, 33.5173, 33.5366, 33.5432, 33.5548, 33.5499];

% 그림 그리기
figure;
plot(dates, mean_salt, '-o');
xlabel('Date');
ylabel('Salinity');
title('Mean Salinity');
xtickformat('yyyy-MM-dd');  % 날짜 형식 설정

% 그래프 저장
saveas(gcf, 'Mean_Salinity.png');


%% Area of Eddy
clc; clear all; close all;

%데이터
dates = datetime(2007, 7, 30):datetime(2007, 8, 29);  
area_values = [26400.0, 25200.0, 25200.0, 25200.0, 25200.0, ...
             26400.0, 32500.0, 32500.0, 32500.0, 32500.0, ...
             32500.0, 32500.0, 32500.0, 32500.0, 32500.0, ... 
             31200.0, ...
             31200.0, 31200.0, 31200.0, 28600.0, 28600.0, ...
             28600.0, 28600.0, 28600.0, 27300.0, 27300.0, ...
             27300.0, 27300.0, 26250.0, 26250.0, 25200.0];

% 그림 그리기
figure;
plot(dates, area_values, '-o');
xlabel('Date');
ylabel('Area (km^2)');
title('Area of Eddy');
xtickformat('yyyy-MM-dd');  % 날짜 형식 설정

% 그래프 저장
saveas(gcf, 'Area_of_Eddy.png');



