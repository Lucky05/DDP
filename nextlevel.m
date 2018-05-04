%uiopen('/Users/vamshi/Desktop/3b experiment/white.jpeg',1)
%liver =double(imread('white.jpeg'));
whit = imread('white.jpeg');
white =rgb2gray(whit);
[x, y] = size(white)
xx = x.*rand(200,1)
yy = y.*rand(200,1)
imshow(white)
hold on
voronoi(xx,yy)
for i = 2
    xx(:,i) = yy(:,i-1)
end

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
for i = 1:length(c{i})
    j = i +1;
    m = c{1}(1,i);
    vx(i) = v(m,1);
    vy(i) = v(m,2);
    mx(i) = (vx(i)+vx(j))/2;
    if i == length(c{i})
        j =1;
        mx(i) = (vx(i)+vx(j))/2;
    end 
end



        