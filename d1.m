clc
clear

e2s=50;%�۾���Ļλ�ã����ף�
b2s=50;%���ⱳ��λ�ã����ף�
eed=6.5;%ͫ�׼�ࣨ���ף�
realsiz=[31,17.5];%��Ļ��ʵ����ߴ�
scrsiz=[1366,768];%��Ļ���سߴ�/��Ļ�ֱ���
cm2p=1366/31;%������/���أ���λת��

A=imread('s1.png');
%����ԭʼ����ͼ��
% A=rgb2gray(A);

%% ����ת����
Pe2s=e2s*cm2p;
Pb2s=b2s*cm2p;
Peed=6.5*cm2p;

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
%x=1:siz(1);y=1:siz(2);
%mesh(y,x,h)
%% ����ǰ������ƫ����

Pi2b=h;
Pi2s=Pb2s-Pi2b;
unit=round(Pi2s./(Pi2s+Pe2s).*Peed);%ĳ���Ӧ�ı���ƫ������ȡ����
%unit=Pi2s./(Pi2s+Pe2s).*Peed;%ĳ���Ӧ�ı���ƫ������С����
%x=1:siz(1);y=1:siz(2);
%mesh(y,x,unit)

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
    