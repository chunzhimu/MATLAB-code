figure(1)
imagesc();


clear;
close all;
clc;

lamda = 0.55;   %工作中心波长
%% 物镜参数 
F_obj =20;  %mm
NA = 0.28;
AS = 11.2; %mm
M = 10;
WD = 34;  %mm
F_obj2 = asin(tan(0.28));

%% 相机参数
res_H = 7728;
res_V = 5368;
pixel_size = 1.1; %um
sensor_size_H = 8.8; %mm
sensor_size_V = 6.6; %mm

%% 




%% 微透镜阵列
shape = 'hex';
pitch = 2;   %mm
F_mla = 17;     %mm
% F_mla = 35;     %mm
lens_diam = 20;    %mm

NA_mla1 = pitch/2/F_mla; 
% NA_mla1 = 0.0271; 
abbe_mla = lamda/2/NA_mla1;


%% 中继透镜4f系统
F1 = 63; %mm
F2 = 63; %mm
F1_diam = 20;    %mm
F2_diam = 20;    %mm

%% 参数计算
M1 = F1/F_obj;
% Dcam = sensor_size_H;
Dcam = sensor_size_V;

% F2 = Dcam*M1/2/NA;
N = 2*NA*F2/M1/pitch;


Sr = lamda/2/NA_mla1/pixel_size;
Rxy = Sr*pixel_size*F2/F_mla/M1;
Rz = lamda*N*N/4/sqrt(2)/NA/NA;

Rz2=pitch*Rxy*Rxy/lamda/pitch;

MR = F1/F2;  %中继系统放大倍数
MT = F_mla*F1/F2/F_obj; % 系统总放大倍数

% N = AS*F1/F2/pitch;  % 子透镜数量
FS = pitch*F2/F_mla;   % 截止光阑直径

FOV2=Dcam/M1;
DOF2=N*N*lamda/NA/NA+N*N*lamda/2/Sr/NA/NA;
% DOF3=
MT2=Sr*pixel_size/Rxy;

DOF3=2*(4+2/Sr)*Rxy/lamda;

abbe = N*lamda/2/NA;    % 衍射极限
sample = 2*pixel_size/MT;   %采样极限
R_xy = max([abbe sample]);     % 横向分辨率，um

FOV = pitch/MT;    % 视场大小um

DOF =  2*lamda*N*N/NA/NA + N*pixel_size/NA/MT;   %景深大小um

ratio_xy=FOV*1000/Rxy;
ratio_z=DOF/Rz;

parameters = [R_xy FOV Rz Rz2 DOF]

hardware = [F_obj NA F1 F2 pitch F_mla pixel_size]

ratio=[ratio_xy ratio_z]

%% 微透镜阵列焦距计算
Rc=12.4;
n=1.517;
a=0.75;
T=2.5;

h=Rc-sqrt(Rc^2-a^2);
NA_mla=h/a;
f_effl1=Rc/(n-1);
f_effl2=(h+(a^2)/h)/2/(n-1);

f_bfl=Rc/(n-1)-T/n;


aaa=pitch/2/F_mla;
bb=atan(aaa);
NAM=n*sin(bb)



%%物镜和筒镜间距计算
f1=20;
NA1=0.28;
phi_1=11.2;
phi1=2*f1*NA1;

f2=63;
phi2=20;

phi3=11;

L=f2*(phi2-phi1)/phi3;

