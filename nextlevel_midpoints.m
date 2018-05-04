%uiopen('/Users/vamshi/Desktop/3b experiment/white.jpeg',1)
%liver =double(imread('white.jpeg'));
whit = imread('white.jpeg');
white =rgb2gray(whit);
[x, y] = size(white)
xx = x.*rand(100,1)
yy = y.*rand(100,1)
imshow(white)
hold on
voronoi(xx,yy)
for i = 2
    xx(:,i) = yy(:,i-1)
end

sp = xx

[v,c] = voronoin([xx])

for i = 1:length(c)
    disp(c{i})
      
end
for i = 1:length(c{1})
        m = c{1}(1,i);
        vx(i) = v(m,1);
        vy(i) = v(m,2);
end


BW = roipoly(white,vx,vy);
Inew = white.*uint8(BW);
%hold on
figure,imshow(Inew)
Ineww = Inew(Inew > 0);
figure,imhist(Ineww)
%imhist(Inew)
numberOfPixels = numel(Ineww)

%sumofpixel = sum(Inew)
neww = Ineww <=200;
noofpixelsless = sum(neww(:))

new = Ineww >=200;
noofpixlesgreater = sum(new(:))

percentageles = noofpixelsless/numberOfPixels*100

percentagegreater = noofpixlesgreater/numberOfPixels*100



if percentagegreater > 60
    fprintf('outersell')
    x= 'outercell';
elseif  percentagegreater > 40
    fprintf('boader cell')
    x = 'boadercell';
else
    fprintf('inner cell')
    x = 'innercell';
end

len_c = length(c{1})
for i = 1:len_c-1
    j = i+1;
    mx(i) = (vx(i)+vx(j))/2;
    my(i) = (vy(i)+vy(j))/2;
end
mx(j) = (vx(j)+vx(1))/2;
my(j) = (vy(j)+vy(1))/2;

mm = [mx; my]'
sp = [sp;mm]

figure,imshow(white)
hold on
latest_xx = sp(:,1)
latest_yy = sp(:,2)
voronoi(latest_xx,latest_yy)
[v,c] = voronoin([sp])
        