correct = 0;
for i = 1:50
    result = CNN(imageset(:,:,:,i),filterbanks,biasvectors);
    pred_class = find(ismember(result, max(result(:))));
    if pred_class == trueclass(i)
        correct = correct + 1;
    end
    
end