%load data
processdata

%get size of training samples
[m,n]=size(trainx);

%optimize using CVX
cvx_begin quiet 
    variables w(n) b(1)
    minimize( norm(w))
    subject to
        1<=trainy.*((trainx*w)+b);
cvx_end

%calculate training error and test error
train_calc_y=sign((trainx*w)+b);
test_calc_y = sign((testx*w)+b);
train_error = 0;
test_error = 0;
for i=1:1902
      if testy(i)~= test_calc_y(i)
          test_error=test_error+1;
     end
end
  
  for i=1:2000
       if trainy(i)~= train_calc_y(i)
          train_error=train_error+1;
       end
  end



test_percent =(test_error/1902)*100;
train_percent = (train_error/2000)*100;
M = {'Problem','Train Error Percentage','Test Error Percentage'};
N= {'Optimal Margin Classifier',train_percent,test_percent};
csvwrite("D:\Study\DA\p1W.csv",w)
xlswrite('Compare.xlsx',M,1,'A1');
xlswrite('Compare.xlsx',N,1,'A2');
b
train_percent
test_percent