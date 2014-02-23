function make3d()
tic
clc;
W  =  80;     %  重复的图案宽度 , displace distance 
MAXZ = 10;    %  三维形象最大层数,layers 
S = 20;    % scale factor 

hf='000000010000000000000000000000000000000020000000000000000000000000000003000000000000000000000000111177777777111111777777777111111111777777777111117711111177111111111111117771111177111111771111111111111177711111771111117711111111777777777111117711111177111111111111117771111177111111771111111111111177711111771111117711111111777777777111117711111177111111117777777711111177777777711111111111111111111111111111111111111111111111111111111111111111111111112233445566776655443322111111111122334455667766554433221111111111111111111111111111111111111111111111111111111111111111111111111122233444566654433222111111111111222334445666544332221111111110101010101010101010101010101010010101010101010101010101010101011010101010101010101010101010101001010101010101010101010101010101';
hf = reshape(hf,32,24)';
k = zeros(24,32);
for i = 1:24
    for j = 1:32
        k(i,j)=hf(i,j)-'0';
    end
end
hf=k;

% hf = imread('e:/c.png');
% % hf = imresize(hf,[48,64]);
% hf = rgb2gray(hf);
% hf = double(hf);
% hf = floor((hf/26));

MAXX = S*size(hf,2);
MAXY = S*size(hf,1);

img=zeros(MAXY,MAXX,3);
% img(:,:,1) = randi([0,255],MAXY,MAXX);
% img(:,:,2) = randi([0,255],MAXY,MAXX);
% img(:,:,3) = randi([0,255],MAXY,MAXX);

L = 20;
for i = 1 : 10000
    x = randi([1 MAXX-L],1,1);
    y = randi([1 MAXY-L],1,1);
    dx = randi([1 L],1,1);
    dy = sqrt(L^2-dx^2);
    xp = floor(linspace(x,x+dx,2*L));
    yp = floor(linspace(y,y+dy,2*L));
    color = randi([255],1,3);
    color = reshape(color,1,1,3);
    for k = 1 : 2*L
        img(yp(k),xp(k),:) = color;
    end
end
%     
img = uint8(img);
% for y = 1  : S : MAXY
%     t_x = 1:MAXX;
%     for h = 1 : MAXZ
%         d = W-h;
%         for x = 1 : MAXX
%             if hf(ceil(y/S),ceil(x/S)) == h
%                 t_x(x+d)=x;
%             end
%         end
%     end
%     
%     for x = 1 : MAXX
%         if t_x(x) ~= x
%             img(y:y+S-1,x,:) = img(y:y+S-1,t_x(x),:);
%         end
%     end
% end            

% imwrite(img,'e:/k.png');


NO = 999;
dot = zeros(3,MAXX);
for y = 1  : S : MAXY
    dot(1:2,:) = NO;
    dot(1,1:MAXX-W)=(1+W):MAXX;
    dot(2,W:MAXX) = 0:(MAXX-W);
    
    for h = 1 : MAXZ
        for x = 1: MAXX
            lx = floor(x-W/2+h);
            rx = floor(x+W/2-h);
            if hf(ceil(y/S),ceil(x/S)) == h && lx > 0 && rx <= MAXX
                if(dot(1,lx+1) ~= NO)
                    dot(2,dot(1,lx+1)) = NO;
                end
                dot(1,lx+1) = rx;
                if(dot(2,rx) ~= NO)
                    dot(1,dot(2,rx+1)) = NO;
                end
                dot(2,rx) = lx;
            end
        end
        
        for x = 1 : MAXX
            if(dot(2,x) == NO)
                dot(3,x) = x;
                tx = x;
                while(dot(1,tx) ~= NO)
                    tx = dot(1,tx);
                    dot(3,tx) = x;
                end
            end
            if(dot(3,x) ~= x)
                img(y:y+S-1,x,:) = img(y:y+S-1,dot(3,x)+1,:);
            end
        end
    end
end    
imshow(img)
toc