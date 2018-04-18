%uiopen('/Users/vamshi/Desktop/3b experiment/white.jpeg',1)
%liver =double(imread('white.jpeg'));
clear
clc
whit = imread('white.jpeg');
white =rgb2gray(whit);
[x, y] = size(white)
xx = x.*rand(30,1)
yy = y.*rand(30,1)
imshow(white)
hold on
voronoi(xx,yy)
for i = 2
    xx(:,i) = yy(:,i-1)
end

[v,c] = voronoin([xx])

% for i = 1:length(c)
%     disp(c{i})
%       
% end
for j = 1:length(c)
    k = 0;
    for i = 1:length(c{j})
        m = c{j}(1,i);
        vx(i) = v(m,1);
        vy(i) = v(m,2);
        if isinf(vx(i))
            k = 1;
            break;
        end
    end
    if k == 1
        continue;
    end
    temp_roipoly = roipoly(white,vx,vy);
    temp_Inew = white.*uint8(temp_roipoly);
    %hold on
    figure,imshow(temp_Inew)
    Ineww = temp_Inew(temp_Inew > 0);
    %%%figure,imhist(Ineww)
    clear temp_roipoly temp_Inew vx vy Ineww;
end





% % % % temp_roipoly = roipoly(white,vx,vy);
% % % % temp_Inew = white.*uint8(temp_roipoly);
% % % % %hold on
% % % % figure,imshow(temp_Inew)
% % % % Ineww = temp_Inew(temp_Inew > 0);
% % % % figure,imhist(Ineww)
