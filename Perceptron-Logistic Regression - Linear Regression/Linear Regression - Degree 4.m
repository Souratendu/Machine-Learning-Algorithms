load('3C.mat');
p = polyfit(x,y,4); 

N=randn(1);
x1=[-7 -6 x 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
y1=power(x1,3)-power(x1,2)+1+N;
f = polyval(p,x1); 
plot(x,y,'o',x1,f,'-',x1,y1,'--') ;
legend('data','linear fit','underlying truth') ;
title('Degree: 4');