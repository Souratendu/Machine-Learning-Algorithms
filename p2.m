%load data

processdata

%get size of training samples
[m,n]=size(trainx');

%optimize using CVX
one=ones(n,1);
cvx_begin quiet 
    variables alphaa(n) 
    
    minimize( -one'*alphaa + (1/2)*(trainy.*alphaa)'*(trainx*(trainx)')*(trainy.*alphaa) )
    subject to
        0<=alphaa
        trainy'*alphaa==0
cvx_end

%get w b value
w = ((alphaa.*trainy)'*trainx)';
twithw=trainx*w;
b = -( max(twithw(trainy==-1))  +    min(twithw(trainy==1))  ) /2;
 
%calculate training error
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

csvwrite("D:\Study\DA\p2W.csv",w)

N= {'Optimal Margin Classifier-Dual',train_percent,test_percent};
xlswrite('Compare.xlsx',N,1,'A3');
b
test_percent
train_percent