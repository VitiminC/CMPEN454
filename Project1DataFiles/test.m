correct = 0;
tabel = zeros(10,10);
for class = 1:10
    inds = find(trueclass==class);
    for i = 1:length(inds)
        result = CNN(imageset(:,:,:,inds(i)),filterbanks,biasvectors);
        pred_class = find(ismember(result, max(result(:))));
        tabel(pred_class,class) = tabel(pred_class,class) + 1;
    end
    
    
end
