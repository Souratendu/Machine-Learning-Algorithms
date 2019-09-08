%run this script to load data, and normalize data
clear all
load('hw1_mnist35.mat')
%show 4 training samples
subplot(2,2,1)
image(reshape(trainx(12,:),28,28)');
subplot(2,2,2)
image(reshape(trainx(992,:),28,28)');
subplot(2,2,3)
image(reshape(trainx(1012,:),28,28)');
subplot(2,2,4)
image(reshape(trainx(1112,:),28,28)');
%%normalize  data
trainx=double(trainx)/255;
testx=double(testx)/255;
trainy(trainy==1) = 1;
trainy(trainy==-1) =0;
testy(testy==1) = 1;
testy(testy==-1) =0;
n_train=length(trainy);%total number of training samples
n_test=length(testy);%total number of test samples

m_data=size(trainx,2);%dimension of original feature vector
index = randperm(2000);



trainx=[trainx ones(n_train,1)];%  add dummy feature 1
testx=[testx ones(n_test,1)];%  add dummy feature 1
strainx = trainx(index,:);
strainy = trainy(index,:);
theta=zeros(m_data+1,1);%initialize theta, dimension is 784+1, where the last entry is b
alpha=0.5;%step size 
count=1;
thetaX=trainx*theta;
h=1./(1+exp(-thetaX));
grad = (trainx'*(trainy-h));
flag=0;
while flag==0
    for i=1:n_train
        rtheta = strainx(i,:)*theta;
        rh = 1/(1+exp(-rtheta));
        theta = theta + alpha*(strainx(i,:)'*(strainy(i) -rh));
        if rem(i,200)==0
            thetaX=strainx*theta;
            h=1./(1+exp(-thetaX));
            grad = (strainx'*(strainy-h));
            if norm(grad,2) < 0.01
                flag=1;
                break;
            end
        end
       
    end
    count=count+1;
end


trainThetaX = trainx*theta;
trainH=1./(1+exp(-trainThetaX));


testThetaX = testx*theta;
testH=1./(1+exp(-testThetaX));

trainH(trainH>0.5) = 1;
trainH(trainH<0.5) =0;
testH(testH>0.5) =1;
testH(testH<0.5) =0;

error_train= sum(trainy~=trainH);
error_test = sum(testy~=testH);

disp((error_train/2000)*100);
disp(((error_test)/1902)*100);
