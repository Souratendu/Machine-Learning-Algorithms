load("hw3_data.mat");
figure;

title('raw data');
k= [2,3,4];
for i=1:3
    grp = K_Means(X,k(i));
    subplot(2,2,i);
    gscatter(X(:,1),X(:,2),grp);
    title("K = "+k(i));
end


function y = K_Means(X,k)
   
    randInd = floor((599).*rand(k,1) + 1);
    centroid = X(randInd,:) ;
    centroid1=centroid;
    flag =0;
    diff=zeros(600,k);
    y=zeros(600);
   while flag==0
         for i = 1:k
             diff(:,i)= sqrt((X(:,1)-centroid(i,1)).^2 + (X(:,2)-centroid(i,2)).^2);
             
         end
        [val,y]= min(diff,[],2);
        
        for i=1:k
            y1=y;
            
            y1(y1~=i) = 0;
            y1(y1==i) = 1;
            centroid1(i,1) = (y1'*X(:,1))/(sum(y==i));
            centroid1(i,2) = (y1'*X(:,2))/(sum(y==i));
        end
         if(centroid == centroid1)
            flag = 1;
         end
         centroid = centroid1;
         
   end   
    
    
end