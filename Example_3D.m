% clear all;
load Data_CR3.mat

figure(3);clf;
plot3(Data_3D(Y_3D==0,1),Data_3D(Y_3D==0,2),Data_3D(Y_3D==0,3),'b.','MarkerSize',24);
hold on;
plot3(Data_3D(Y_3D==1,1),Data_3D(Y_3D==1,2),Data_3D(Y_3D==1,3),'r.','MarkerSize',24);

bL3 = LinFit(Data_3D,Y_3D);
xm = (1-.1*sign(min(Data_3D(:,1))))*min(Data_3D(:,1));
xM = (1+.1*sign(max(Data_3D(:,1))))*max(Data_3D(:,1));
ym = (1-.1*sign(min(Data_3D(:,2))))*min(Data_3D(:,2));
yM = (1+.1*sign(max(Data_3D(:,2))))*max(Data_3D(:,2));
[xx,yy] = meshgrid(linspace(xm,xM,101),linspace(ym, yM, 101));
zz = -(bL3(2)*xx+bL3(3)*yy+bL3(1)-1/2)/bL3(4);
h = surf(xx,yy,zz);
shading interp
axis off
plot3(Classify_Data3D(:,1),Classify_Data3D(:,2),Classify_Data3D(:,3),'kx','MarkerSize',24);
zlim([0.05 .2])

figure(4);clf;
plot3(Data_3D(Y_3D==0,1),Data_3D(Y_3D==0,2),Data_3D(Y_3D==0,3),'b.','MarkerSize',24);
hold on;
plot3(Data_3D(Y_3D==1,1),Data_3D(Y_3D==1,2),Data_3D(Y_3D==1,3),'r.','MarkerSize',24);

bN3 = NonLinFit(Data_3D,Y_3D);
zz = -(bN3(2)*xx+bN3(3)*yy+bN3(1))/bN3(4);
h = surf(xx,yy,zz);
shading interp
axis off
zlim([0.05 .2])

plot3(Classify_Data3D(:,1),Classify_Data3D(:,2),Classify_Data3D(:,3),'kx','MarkerSize',24);
