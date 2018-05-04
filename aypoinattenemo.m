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

sp = xx

[v,c] = voronoin([xx])

for i = 1:length(c)
    disp(c{i})
      
end

for iter = 1:50
    cell_iter = length(c);
    for cc = 1:cell_iter
        skip_loop = false;
        for i = 1:length(c{cc})
                m = c{cc}(1,i);
                vx(i) = v(m,1);
                vy(i) = v(m,2);
                if isinf(vx(i))
                    skip_loop = true;
                    continue
                end
        end
        if skip_loop
            continue
        end


        BW = roipoly(white,vx,vy);
        Inew = white.*uint8(BW);
        %hold on
        %%%%%%%%%%figure,imshow(Inew)
        Ineww = Inew(Inew > 0);
        %%%%%%%%%%figure,imhist(Ineww)
        %imhist(Inew)
        numberOfPixels = numel(Ineww);

        %sumofpixel = sum(Inew)
        neww = Ineww <=200;
        noofpixelsless = sum(neww(:));

        new = Ineww >=200;
        noofpixlesgreater = sum(new(:));

        percentageles = noofpixelsless/numberOfPixels*100;

        percentagegreater = noofpixlesgreater/numberOfPixels*100;



        if percentagegreater > 60
            fprintf('outersell')
            x= 'outercell';
        elseif  percentagegreater > 40
            fprintf('boader cell')
            x = 'bordercell';
        else
            fprintf('inner cell')
            x = 'innercell';
        end
        
        if isequal(x ,'bordercell')
            len_c = length(c{1})
            for ii = 1:len_c-1
                jj = ii+1;
                mx(ii) = (vx(ii)+vx(jj))/2;
                my(ii) = (vy(ii)+vy(jj))/2;
            end
            mx(jj) = (vx(jj)+vx(1))/2;
            my(jj) = (vy(jj)+vy(1))/2;

            mm = [mx; my]'
            sp = [sp;mm]
        end
end
end



figure,imshow(white)
hold on
latest_xx = sp(:,1)
latest_yy = sp(:,2)
voronoi(latest_xx,latest_yy)
[v,c] = voronoin([sp])
        