function my3d()
clc
clear

cm2p=40;%������/���أ���λת��

A=imread('s1.png');

Pe2s=2000;%�۾���Ļλ�ã����ף�
Pb2s=2000;%���ⱳ��λ�ã����ף�
Peed=260;%ͫ�׼�ࣨ���ף�

%% ����Ŀ������ͼ����ÿ����ĸ߶ȵľ��� h(x,y)
siz=[331,600];%��Ļ��С
center0=siz/2;%������
R=200;%��뾶
for x=1:siz(1)
    for y=1:siz(2)
        l(x,y)=((center0(1)-x)^2+(center0(2)-y)^2)^.5;
        if l(x,y)>R
            l(x,y)=R;
        end
        h(x,y)=(R^2-l(x,y).^2).^.5;
    end
end
h=h*4;%Ū�ߵ�
% x=1:siz(1);y=1:siz(2);
% mesh(y,x,h)
%% ����ǰ������ƫ����

Pi2b=h;
Pi2s=Pb2s-Pi2b;
unit=round(Pi2s./(Pi2s+Pe2s).*Peed);%ĳ���Ӧ�ı���ƫ������ȡ����
%unit=Pi2s./(Pi2s+Pe2s).*Peed;%ĳ���Ӧ�ı���ƫ������С����
% x=1:siz(1);y=1:siz(2);
% mesh(y,x,unit)

%% �������ݻ�ͼ
B=A;
B(:,end+1:siz(2),:)=0;
for y=1:siz(2)
    for x=1:siz(1)
        if y-unit(x,y)>0
        B(x,y,:)=B(x,y-unit(x,y),:);
%         B(x,y,:)=interp2(1:siz(2),1:siz(1),B,y-unit(x,y),x);%��ֵ
        end
    end
end
% B=mat2gray(B);
figure
imshow(B)
    