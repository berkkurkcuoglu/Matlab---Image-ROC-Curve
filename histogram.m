I = imread('grayImage.jpg');
hist = zeros(256,1);

for x=1:size(I,1)
    for y=1:size(I,2)
        hist(I(x,y)) = hist(I(x,y)) + 1;
    end
end

plot(hist);