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

n_train=length(trainy);%total number of training samples
n_test=length(testy);%total number of test samples

m_data=size(trainx,2);%dimension of original feature vector


trainx=[trainx ones(n_train,1)];%  add dummy feature 1
testx=[testx ones(n_test,1)];%  add dummy feature 1
theta=zeros(m_data+1,1);%initialize theta, dimension is 784+1, where the last entry is b
alpha=0.5;%step size 

% x=-5:1:5;
% y=x.^3-x.^2+1+randn(1,length(x));

theta_s=zeros(m_data+1,1);%initialize theta
alpha_s=0.5;%step size 

sequence=randperm(n_train);

flag=0;
j=1;
while flag==0
    for i=sequence
        if trainy(i)~=sign(trainx(i,:)*theta_s)
            theta_s=theta_s + alpha_s*trainy(i)*trainx(i,:)';
        end

        j=j+1;
        if mod(j,2000)==0
%             j
%             sum(sign(trainx*theta_s)~=trainy)
            if sum(sign(trainx*theta_s)~=trainy)==0
                flag=1;
                break;
            end
        end
           
    end
end
train_error=sum(sign(trainx*theta_s)~=trainy)/2000;
test_error=sum(sign(testx*theta_s)~=testy)/1902;

train_error*100
test_error*100
