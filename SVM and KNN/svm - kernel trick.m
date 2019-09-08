%load data

processdata


%get size of training samples
[m,n]=size(trainx');
 k= zeros(2000:2000);
 ttrainx=trainx;
for i=1:2000
    for j=1:2000
        k(i,j) = exp(-((norm(trainx(i,:) - ttrainx(j,:))).^2)/2) ;
    end
end


%optimize using CVX

one=ones(n,1);
cvx_begin quiet 
    variables alphaa(n) 
    
    minimize( -one'*alphaa + (1/2)*(trainy.*alphaa)'*k*(trainy.*alphaa) )
    subject to
        0<=alphaa
        trainy'*alphaa==0
cvx_end

%get w b value

alphayk = ((alphaa.*trainy)'*k)';
max_neg_ind = find(trainy==-1);
min_pos_ind = find(trainy==1);
b = -(max((alphaa(max_neg_ind).*trainy(max_neg_ind))'*k(max_neg_ind,:))+min((alphaa(min_pos_ind).*trainy(min_pos_ind))'*k(min_pos_ind,:)))/2;

 
%calculate training error
train_calc_y=sign(alphayk+b);

train_error = 0;
for i=1:2000
    
    if trainy(i)~= train_calc_y(i)
        train_error=train_error+1;
    end
end

k_test= zeros(2000:1902);
 ttrainx=trainx;
for i=1:2000
    for j=1:1902
        k_test(i,j) = exp(-((norm(trainx(i,:) - testx(j,:))).^2)/2) ;
    end
end
alphayk_test = ((alphaa.*trainy)'*k_test)';
%doubt
test_calc_y = sign(alphayk_test + b);

test_error = 0;
for i=1:1902
    if testy(i)~= test_calc_y(i)
        test_error=test_error+1;
    end
end

test_percent =(test_error/1902)*100;
train_percent = (train_error/2000)*100;

N= {'Optimal Margin Classifier-Dual-Kernel Trick',train_percent,test_percent};
xlswrite('Compare.xlsx',N,1,'A6');

b
test_percent
train_percent