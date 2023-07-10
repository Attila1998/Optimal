clc;
clear all;
close all;

 x=-15:0.1:10;      
 y=x;
 [xr,yr]=meshgrid(x,y);
zr=xr.^2+yr.^2+xr.*yr+2.*xr;              
f=@(x)(x(1)^2+x(2)^2+x(1)*x(2)+2*x(1));            

  m=menu("modszer","MCa","MCb","MC modositott","Boldsman");
figure;
contour(xr,yr,zr);  
hold on;
[x0,y0]=ginput(1);    
x=[x0 ;y0];
plot(x0,y0,'*r');
R=0.5;
PI=3.14159;
count=0;
val=f(x);
tomb=[x;val];
if m==1
    intX=[-3 3];    
    intY=[-2 2];   
    for i=1:100
       ujx(1,1)=x(1)+(rand(1)*(intX(2)-intX(1))+intX(1))*R;    
       ujx(2,1)=x(2)+(rand(1)*(intY(2)-intY(1))+intY(1))*R;     
       ujx
      if f(ujx)<val   
          count=0;   
          x=ujx;      
          val=f(ujx);  
          tomb=[tomb [x;val]];  
      else              
         count=count+1; 
         plot(ujx(1),ujx(2),'*y'); 
      end
      if count>10          
          break
      end
    end
end


if m==2
    for i=1:1000
        ro=R*rand(1);
       alfa=PI/2+(PI/2)*rand(1); 
       ujx(1,1)=ro*cos(alfa); 
       ujx(2,1)=ro*sin(alfa); 
      if f(ujx)<val
          count=0;
          x=ujx;
          val=f(ujx);
          tomb=[tomb [x;val]];
      else
         count=count+1;
         plot(ujx(1),ujx(2),'*y'); 
      end
      if count>10
          break
      end
    end
    i
end


if m==3
   for i=1:1000
      ujx=x+(rand(2,1)*2-1)*R; 
      if f(ujx)<val
          count=0;
          x=ujx;
          val=f(ujx);
          tomb=[tomb [x;val]];
      else
         count=count+1;
         plot(ujx(1),ujx(2),'*y'); 
      end
      if count>10
          break
      end
   end
end

if m==4
    K=1;
    T0=50;
   for i=1:1000
      ujx=x+(rand(2,1)*2-1)*R; 
      deltaf=abs(f(ujx)-val);
      T0=T0/(1+i);
      P=exp(-deltaf/(K*T0));
      r=rand(1);
      if f(ujx)<val && P<r
          count=0;
          x=ujx;
          val=f(ujx);
          tomb=[tomb [x;val]];
      else
         count=count+1;
         plot(ujx(1),ujx(2),'*y'); 
      end
      if count>10
          break
      end
   end
end

   plot(tomb(1,:),tomb(2,:),'*g');    
   plot(tomb(1,:),tomb(2,:),'r');     
    figure;
    plot(tomb(3,:));                 
