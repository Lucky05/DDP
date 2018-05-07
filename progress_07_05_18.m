%uiopen('/Users/vamshi/Desktop/3b experiment/white.jpeg',1)
%liver =double(imread('white.jpeg'));
white = imread('white.jpeg');
white = im2bw(white);
white = uint8(white);
white = white.*255
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



for iter = 1:3
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

        white(white == 0) = 1;
        BW = roipoly(white,vx,vy);
        Inew = white.*uint8(BW);
        totpixelsinroi_logic = Inew > 0;
        
        totalnumberOfPixels = sum(totpixelsinroi_logic(:))
%         neww = Inew <=200;
%         noofpixelsless = sum(neww(:))

        totalnumberofwhitepixinroi_logic = Inew >200;
        noofpixelsgreater = sum(totalnumberofwhitepixinroi_logic(:))

        %percentageles = (noofpixelsless/numberOfPixels)*100

        percentagegreater = (noofpixelsgreater/totalnumberOfPixels)*100



        if percentagegreater > 90
            fprintf('outercell')
            x= 'outercell';
        elseif  percentagegreater < 1
            fprintf('innercell')
            x = 'innercell';
        elseif isnan(percentagegreater)
            x = 'Nan';
        else
            fprintf('bordercell')
            x = 'bordercell';
        end
        
%         tot = sum(sum(Inew));
% 
% 
% 
%         if tot == 0
%             %fprintf(tot)
%             d= 'outercell';
%         elseif  tot < x*y*255
%             %fprintf(tot)
%             d = 'innercell';
%         else
%             %fprintf('inner cell')
%             d = 'bordercell';
%         end
%         
        if isequal(x ,'bordercell')
            len_c = length(c{1})
            for ii = 1:len_c-1
                jj = ii+1;
                mx(ii) = (vx(ii)+vx(jj))/2;
                my(ii) = (vy(ii)+vy(jj))/2;
            end
            mx(jj) = (vx(jj)+vx(1))/2;
            my(jj) = (vy(jj)+vy(1))/2;

            mm = [mx; my]';
            sp = [sp;mm]; 
        end
    end
    clear v c
    [v,c] = voronoin([sp]);
end



figure,imshow(white);
hold on

latest_xx = sp(:,1);
latest_yy = sp(:,2);
voronoi(latest_yy,latest_xx);
[v,c] = voronoin([sp]);
        