I = imread('grayImage.jpg');

for x=1:size(I,1)
    for y=1:size(I,2)
        if(I(x,y) <= 67) % set threshold value
            I(x,y) = 0; % I < threshold --> 0
        else
            I(x,y) = 255; % I > threshold --> 255
        end
    end
end

imshow(I);