function output(Data,Mesh,GND_EM,GND_L2)


xi=Data.X;
yi=Data.Y;
nx = size(Mesh.X,1)-1;
ny = size(Mesh.X,2)-1;

X=reshape(xi,nx,ny);
Y=reshape(yi,nx,ny);

Z1= reshape(GND_L2.norm',nx,ny);
figure
axis equal
surf(X,Y,Z1,'LineStyle','none')
colorbar
title('L2 - |rhoGND|')


Z2= reshape(GND_EM.norm',nx,ny);
figure
axis equal
surf(X,Y,Z2,'LineStyle','none')
colorbar
title('EM - |rhoGND|')



% aa = log10(GND_EM.norm);
% 
% % Grain-A: 26
% % Grain-B: 28
% 
% for i=1:size(aa,2)
%     
%    if Data.grainId(i)==26
%        
%       
%        
%    else
%        aa(i)=nan;
%        
%    end
%     
% end
% 
% 
% Z2= reshape(aa',nx,ny);
% figure
% axis equal
% surf(X,Y,Z2,'LineStyle','none')
% colorbar
% title('EM - |rhoGND|')



% 
% xi=Data.X;
% yi=Data.Y;
% 
% 
% % xi = unique(xel) ; yi = unique(yel) ;
% [X,Y] = meshgrid(xi,yi) ;
% 
% 
% 
% nx=size(X,1);
% ny=size(X,2);
% 
% zi = Data.grainId;
% 
% Z = griddata(xi,yi,zi,X,Y);
% 
% 
% figure
% surf(X,Y,Z)
% title('Grain-ID')
% 
% 
% % Plot results of L2 method
% z1=GND_L2.norm';
% 
% Z = griddata(xi,yi,z1,X,Y);
% 
% figure
% surf(X,Y,Z)
% title('L2 - |rhoGND|')
% 
% % Plot results of L2 method
% z2=GND_EM.norm;
% Z = reshape(z2,size(X)) ;
% figure
% surf(X,Y,Z)
% title('EM - |rhoGND|')