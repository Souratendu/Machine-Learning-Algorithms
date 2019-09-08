%load data
processdata

%get size of training samples
train_rows = (1999*2000)/2 ;
l2_distance = zeros(train_rows,5);
c=1;
for i=1:1999
    for j=i+1:2000
        l2_distance(c,1) = norm(trainx(i,:)-trainx(j,:));
        l2_distance(c,2) = i;
        l2_distance(c,3) = j;
        l2_distance(c,4) = trainy(i);
        l2_distance(c,5) = trainy(j);
        c=c+1;
    end
end
predict_Y=0;
train_error3=0;
train_error5=0;
for i=1:2000
    predict_Y=0;
    mat1=l2_distance(find(l2_distance(:,2)==i),:);
    mat2=l2_distance(find(l2_distance(:,3)==i),:);
    mat3=[mat1;mat2];
    [~,idx] = sort(mat3(:,1)); % sort just the first column
    sortedmat = mat3(idx,:);
    
    
    if(sortedmat(1,2)==i)
        predict_Y = predict_Y+mat3(1,5);
    else
        predict_Y = predict_Y+mat3(1,4);
    end
    
    if(sortedmat(2,2)==i)
        predict_Y = predict_Y+mat3(2,5);
    else
        predict_Y = predict_Y+mat3(2,4);
    end
    
    if(sortedmat(3,2)==i)
        predict_Y = predict_Y+mat3(3,5);
    else
        predict_Y = predict_Y+mat3(3,4);
    end
    if(sign(predict_Y)~=trainy(i))
        train_error3 = train_error3 + 1;
    end
    
    if(sortedmat(4,2)==i)
        predict_Y = predict_Y+mat3(4,5);
    else
        predict_Y = predict_Y+mat3(4,4);
    end
    
    if(sortedmat(5,2)==i)
        predict_Y = predict_Y+mat3(5,5);
    else
        predict_Y = predict_Y+mat3(5,4);
    end
    
    if(sign(predict_Y)~=trainy(i))
        train_error5 = train_error5 + 1;
    end
end
train_percentage3 = (train_error3/1999)*100;
train_percentage5 = (train_error5/1999)*100;

test_error3=0;
test_error5=0;
for i=1:1902
    l2_test_distance = zeros(2000,2);
    for j=1:2000
        l2_test_distance(j,1) = norm(testx(i,:)-trainx(j,:));
        l2_test_distance(j,2) = trainy(j);
    end
    [~,idx] = sort(l2_test_distance(:,1)); % sort just the first column
    sortedmat = l2_test_distance(idx,:);
    predict_Y=sortedmat(1,2)+sortedmat(2,2)+sortedmat(3,2);
    if(sign(predict_Y)~=testy(i))
        test_error3 = test_error3 + 1;
    end
    predict_Y=predict_Y+ sortedmat(4,2)+sortedmat(5,2);
    if(sign(predict_Y)~=testy(i))
        test_error5 = test_error5 + 1;
    end
end

test_percentage3 =(test_error3/1902)*100;
test_percentage5 = (test_error5/1902)*100;

N= {'3-NN Classifier',train_percentage3,test_percentage3;'5-NN Classifier',train_percentage5,test_percentage5};
xlswrite('Compare.xlsx',N,1,'A4');
train_percentage3
train_percentage5
test_percentage3
test_percentage5
