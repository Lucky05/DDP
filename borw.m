%uiopen('/Users/vamshi/Desktop/3b experiment/white.jpeg',1)
%liver =double(imread('white.jpeg'));
white = imread('borw.jpg');
%white =rgb2gray(white);
siz = size(white)
x = siz(1);
y = siz(2);
tot = x*y;
xx = x.*rand(30,1);
yy = y.*rand(30,1);
imshow(white)
hold on
voronoi(yy,xx)
for i = 2
    xx(:,i) = yy(:,i-1);
end

sp = xx;

[v,c] = voronoin([xx]);



for iter = 1:50
    cell_iter = length(c);
    for cc = 1:cell_iter
        skip_loop = false;
        for i = 1:length(c{cc})
                m = c{cc}(1,i);
                vx(i) = v(m,1);
                vy(i) = v(m,2);
                if isinf(vx(i))
                    fprintf("inf encountered")
                    skip_loop = true;
                    continue
                end
        end
        if skip_loop
            continue
        end


        BW = roipoly(white,vx,vy);
        Inew = white.*uint8(BW);
        %figure,imshow(Inew)
        shimmy = sum(sum(BW));



        if shimmy == 0
            %fprintf('outersell')
            d= 'outercell';
        elseif  shimmy == tot
            %fprintf('boader cell')
            d = 'innercell';
        else
            %fprintf('inner cell')
            d = 'bordercell';
        end
        
        if isequal(d ,'bordercell')
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
voronoi(latest_yy,latest_xx)
[v,c] = voronoin([sp])
        