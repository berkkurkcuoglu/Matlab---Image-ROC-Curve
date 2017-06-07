groundTruth = imread('ground_truth.png'); 

sensitivityValues = zeros(256,1); % array to hold sensitivity values for different thresholds
specifityValues = zeros(256,1); % array to hold specifity values for different thresholds

for thresh = 0:1:255  % loop for every threshold value
    I = imread('grayImage.jpg');
    %thresholding image
    for x=1:size(I,1)
        for y=1:size(I,2)
            if(I(x,y) <= thresh)
                I(x,y) = 0;
            else
                I(x,y) = 255;
            end
        end
    end
    
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    
    %counting negatives and positives
    for x=1:size(I,1)
        for y=1:size(I,2)
            if(I(x,y) == 0) %negative                
                if(groundTruth(x,y) == 0)% check if it is true negative using ground truth
                    TN = TN + 1;
                else
                    FN = FN + 1;
                end
            else % positive                
                if(groundTruth(x,y) == 255)% check if it is true positive using ground truth
                    TP = TP + 1;
                else
                    FP = FP + 1;
                end                
            end       
        end
    end
   
    sensitivity = 1.0 * TP / (TP+FN); % calculate sensitivity
    specifity = 1.0 * FP / (FP+TN); % calculate specificty

    sensitivityValues(thresh+1) = sensitivity; %add to array
    specifityValues(thresh+1) = specifity; %add to array
end

%calculate nearest point to the left corner which is the best threshold value
%according to ROC
min = 1;
for a= 1:256
    dist = sqrt((1-sensitivityValues(a))^2 + (0-specifityValues(a))^2);
    if(dist < min)
        min = dist;
        mina = a;
    end
end
disp(mina-1); % print best threshold value

%plot ROC
figure('Name','ROC','NumberTitle','off'),plot(specifityValues,sensitivityValues,'x');
xlabel('FP Fraction');
ylabel('TP Fraction');

