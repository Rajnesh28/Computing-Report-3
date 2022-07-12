% clear all;
load Data_CR3.mat

bL3 = LinFit(Data_30D,Y_30D);
bN3 = NonLinFit(Data_30D,Y_30D);

figure(3);clf;
plot3(Data_30D(Y_30D==0,1),Data_30D(Y_30D==0,2),Data_30D(Y_30D==0,3),'b.','MarkerSize',24);
hold on;
plot3(Data_30D(Y_30D==1,1),Data_30D(Y_30D==1,2),Data_30D(Y_30D==1,3),'r.','MarkerSize',24);

Classify_Data30D = Classify_Data30D(:,[1,2,3]);

xm = (1-.1*sign(min(Data_30D(:,1))))*min(Data_30D(:,1));
xM = (1+.1*sign(max(Data_30D(:,1))))*max(Data_30D(:,1));
ym = (1-.1*sign(min(Data_30D(:,2))))*min(Data_30D(:,2));
yM = (1+.1*sign(max(Data_30D(:,2))))*max(Data_30D(:,2));
[xx,yy] = meshgrid(linspace(xm,xM,101),linspace(ym, yM, 101));
zz = -(bL3(2)*xx+bL3(3)*yy+bL3(1)-1/2)/bL3(4);
h = surf(xx,yy,zz);
shading interp
axis off
plot3(Classify_Data30D(:,1),Classify_Data30D(:,2),Classify_Data30D(:,3),'kx','MarkerSize',24);

figure(4);clf;
plot3(Data_30D(Y_30D==0,1),Data_30D(Y_30D==0,2),Data_30D(Y_30D==0,3),'b.','MarkerSize',24);
hold on;
plot3(Data_30D(Y_30D==1,1),Data_30D(Y_30D==1,2),Data_30D(Y_30D==1,3),'r.','MarkerSize',24);


zz = -(bN3(2)*xx+bN3(3)*yy+bN3(1))/bN3(4);
h = surf(xx,yy,zz);
shading interp
axis off
zlim([0.05 .2])

plot3(Classify_Data30D(:,1),Classify_Data30D(:,2),Classify_Data30D(:,3),'kx','MarkerSize',24);

%%%%% CODE BELOW HAS BEEN ADDED MY RAJNESH

%%
%%Solve the classification of the linear and non-linear data
%%Use a vector element to hold the classifications for each row, 1 if A, 0
%%if B
Err_lin = [];
Err_nonlin = []; 

classification_vector_linear = [];
classification_vector_non_linear = [];

for i = 1:10
    x = bL3(1) + bL3(2)*Classify_Data30D(i,1)+ bL3(3)*Classify_Data30D(i,2)+ bL3(4)*Classify_Data30D(i,3);
    if x>0.5
        classification_vector_linear(i) = 1;
    else 
        classification_vector_linear(i) = 0;
    end
end


for j = 1:10
    x = bN3(1) + bN3(2)*Classify_Data30D(j,1)+ bN3(3)*Classify_Data30D(j,2)+ bN3(4)*Classify_Data30D(j,3);
    f = (1./(1+exp(x)));
    
    if f > 0.5
        classification_vector_non_linear(j) = 1;
    else 
        classification_vector_non_linear(j) = 0;
    end
end

%%
%%Calculate the error produced by each fitting type

err_lin_vec = [];
err_non_lin_vec = [];

for h = 1:10
    x = bL3(1) + bL3(2)*Classify_Data30D(h,1)+ bL3(3)*Classify_Data30D(h,2) + bL3(4)*Classify_Data30D(h,3);
    err_lin = (x - classification_vector_linear(h))^2;
    err_lin_vec(h) = err_lin;
end

for a = 1:10
    y = 1./(1+exp(bN3(1) + bN3(2)*Classify_Data30D(a,1)+ bN3(3)*Classify_Data30D(a,2) + bN3(4)*Classify_Data30D(a,3)));
    err_non_lin = (y - classification_vector_non_linear(a))^2;
    err_non_lin_vec(a) = err_non_lin;
end

err_lin_sum_3d = sum(err_lin_vec, 'all')
err_non_lin_sum_3d = sum(err_non_lin_vec, 'all')


figure(5);clf;
plot3(Data_30D(Y_30D==0,1),Data_30D(Y_30D==0,2),Data_30D(Y_30D==0,3),'b.','MarkerSize',24);
hold on;
plot3(Data_30D(Y_30D==1,1),Data_30D(Y_30D==1,2),Data_30D(Y_30D==1,3),'r.','MarkerSize',24);
hold on;
plot3(Classify_Data30D(classification_vector_linear==0,1),Classify_Data30D(classification_vector_linear==0,2),Classify_Data30D(classification_vector_linear==0,3),'g.','MarkerSize',24);
hold on;
plot3(Classify_Data30D(classification_vector_linear==1,1),Classify_Data30D(classification_vector_linear==1,2),Classify_Data30D(classification_vector_linear==1,3),'m.','MarkerSize',24);
hold on;
plot3(Classify_Data30D(classification_vector_non_linear==0,1),Classify_Data30D(classification_vector_non_linear==0,2),Classify_Data30D(classification_vector_non_linear==0,3),'g.','MarkerSize',24);
hold on
plot3(Classify_Data30D(classification_vector_non_linear==1,1),Classify_Data30D(classification_vector_non_linear==1,2),Classify_Data30D(classification_vector_non_linear==1,3),'m.','MarkerSize',24);
hold on;

xm = (1-.1*sign(min(Classify_Data30D(:,1))))*min(Classify_Data30D(:,1));
xM = (1+.1*sign(max(Classify_Data30D(:,1))))*max(Classify_Data30D(:,1));
ym = (1-.1*sign(min(Classify_Data30D(:,2))))*min(Classify_Data30D(:,2));
yM = (1+.1*sign(max(Classify_Data30D(:,2))))*max(Classify_Data30D(:,2));
[xx,yy] = meshgrid(linspace(xm,xM,101),linspace(ym, yM, 101));
zz = -(bL3(2)*xx+bL3(3)*yy+bL3(1)-1/2)/bL3(4);
h = surf(xx,yy,zz);
shading interp