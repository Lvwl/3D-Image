clc
clear

e2s=50;%眼距屏幕位置（厘米）
b2s=50;%虚拟背景位置（厘米）
eed=6.5;%瞳孔间距（厘米）
realsiz=[31,17.5];%屏幕真实物理尺寸
scrsiz=[1366,768];%屏幕像素尺寸/屏幕分辨率
cm2p=1366/31;%（厘米/像素）单位转换

A=imread('s1.png');
%导入原始背景图像
% A=rgb2gray(A);

%% 厘米转像素
Pe2s=e2s*cm2p;
Pb2s=b2s*cm2p;
Peed=6.5*cm2p;

%% 生成目标虚拟图像上每个点的高度的矩阵 h(x,y)
siz=[331,600];%屏幕大小
center0=siz/2;%球中心
R=200;%球半径
for x=1:siz(1)
    for y=1:siz(2)
        l(x,y)=((center0(1)-x)^2+(center0(2)-y)^2)^.5;
        if l(x,y)>R
            l(x,y)=R;
        end
        h(x,y)=(R^2-l(x,y).^2).^.5;
    end
end
h=h*4;%弄高点
%x=1:siz(1);y=1:siz(2);
%mesh(y,x,h)
%% 计算前景表面偏移量

Pi2b=h;
Pi2s=Pb2s-Pi2b;
unit=round(Pi2s./(Pi2s+Pe2s).*Peed);%某点对应的表面偏移量（取整）
%unit=Pi2s./(Pi2s+Pe2s).*Peed;%某点对应的表面偏移量（小数）
%x=1:siz(1);y=1:siz(2);
%mesh(y,x,unit)

%% 根据数据绘图
B=A;
B(:,end+1:siz(2),:)=0;
for y=1:siz(2)
    for x=1:siz(1)
        if y-unit(x,y)>0
        B(x,y,:)=B(x,y-unit(x,y),:);
%         B(x,y,:)=interp2(1:siz(2),1:siz(1),B,y-unit(x,y),x);%插值
        end
    end
end
% B=mat2gray(B);
figure
imshow(B)
    