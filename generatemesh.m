% Generate the mesh
function [Mesh]=generatemesh(Data,ss)


% Element type (4: Linear quadrilateral)
meltyp = 4;

% Number of nodes per element
nnpe = 4;

% Number of nodes per surfaces
nnps = 2;


% Number of dof per node
% u, v, w, theta
dof=4;


% Unique x-positions
xi=unique(Data.X);

% Unique y-positions
yi=unique(Data.Y);

% 
% % Crop the region
% xi = find(xi>crop(1,1) & xi<crop(1,2));
% yi = find(yi>crop(2,1) & yi<crop(2,2));
% 
% 





nx = size(xi,1);
ny = size(yi,1);

% Number of elements
numel = nx*ny;


% Node coordinates (shift the coordinates)
xi=[ xi(1)-ss/2; xi + ss/2];

yi=[ yi(1)-ss/2; yi + ss/2];


% Create mesh grid
[Xi, Yi]=meshgrid(xi,yi);



% Critical distance
cd = 1.01*sqrt(2)*ss/2;


% Assign node numbers to the meshgrid
c=0;
numnod=(nx+1)*(ny+1);
crds=zeros(numnod,2);
for j=1:nx+1
    
    for i=1:ny+1
        c=c+1;
        
        crds(c,1:2) = [Xi(i,j), Yi(i,j)];
        
        
    end
end


% Connectivity
conn=zeros(numel,2);
% Search for the points around the center of element
for i=1:numel
    
    % Center coordinates
    xc = Data.X(i);
    
    yc = Data.Y(i);
    
    
    % Search all the node coordinates
    ind=[];
    for j=1:numnod
       
        xn = crds(j,1);
        yn = crds(j,2);

        d = sqrt((xn-xc)^2+(yn-yc)^2);
        
        if d < cd
            ind = [ind, j];
        end
        
    end
    
    conn(i,1:4)=ind;
    
    
end




% % Number of elements/divisions in x-direction
% nx = max(pts(:,2)) - min(pts(:,2)) + 1;
% % Number of elements/divisions in y-direction
% ny = max(pts(:,1)) - min(pts(:,1)) + 1;

% % Starting node coordinate
% x0 = min(ctr(:,1))-ss/2;
% y0 = min(ctr(:,2))-ss/2;
% 
% x1 = max(ctr(:,1))+ss/2;
% y1 = max(ctr(:,2))+ss/2;
% 
% x = linspace(x0,x1,nx+1);
% y = linspace(y0,y1,ny+1);

% 
% % figure
% % hold on
% 
% 
% % Loop through the cropped region
% 
% % Node coordinates
% count=0;
% 
% % conn=zeros(numel,4);
% for k=1:1:ny+1
%     
%     % Node id of lower left corner 
%     yy = y(k);
%     
%     for l=1:1:nx+1
%     
%         count = count + 1;
%         
%         xx = x(l);
%         
%         crds(count,1:2)=[xx, yy];
%         
% %         
% %         
% %         xc = ctr(count,1);
% %         yc = ctr(count,2);
% %         
% %         
% %         
% %         % Lower left corner
% %         x1=xc-ss/2;
% %         y1=yc-ss/2;
% %         Node1=(k-1)*nx + l;
% %         
% %         crds(Node1,1:2) = [x1, y1];
% %         
% % 
% %         
% % %         
% %         % Lower right corner
% %         x2=xc+ss/2;
% %         y2=yc-ss/2;
% %         Node2=(k-1)*nx + l + 1;
% % 
% %         crds(Node2,1:2) = [x2, y2];
% %         
% %         
% %         
% % %         
% %         % Upper right corner
% %         x3=xc+ss/2;
% %         y3=yc+ss/2;
% %         Node3=k*nx + l + 1;
% %        
% %         crds(Node3,1:2) = [x3, y3];
% %         
% %         
% %         
% %      
% %         % Upper left corner
% %         x4=xc-ss/2;
% %         y4=yc+ss/2;
% %         Node4=k*nx + l;
% %         
% %         crds(Node4,1:2) = [x4, y4];
% %         
% %       
% %         
% %         
% % 
% %         conn(count,1:4) = [Node1, Node2, Node3, Node4];
% %         
% %     
% %         line([crds(Node1,1);crds(Node2,1);crds(Node3,1);crds(Node4,1);crds(Node1,1)], ...
% %              [crds(Node1,2);crds(Node2,2);crds(Node3,2);crds(Node4,2);crds(Node1,2)])
% %          
% %         pause
%     end
%     
%     
%     
%     
% end



% 
% 
% % Connectivity
% count=0;
% for k=1:ny
%     
%     
%     
%     for l=1:nx
%         
%         count=count+1;
%    
%         Node1 = (k-1)*(nx+1) + l;
%         
%         Node2 = (k-1)*(nx+1) + l + 1;
%         
%         Node3 = k*(nx+1) + l + 1;
%         
%         Node4 = k*(nx+1) + l;
%         
%         
%         nodes=[ Node1, Node2, Node3, Node4 ];
%         
%         conn(count,:) =  nodes;
%         
%         xel(count) = mean(crds(nodes,1));
%         
%         yel(count) = mean(crds(nodes,2));
%         
%         
%         
%     end
% end


% Replace the columns for connectivity
conn=[conn(:,2),conn(:,1), conn(:,3), conn(:,4)];


Mesh.numel=numel;
Mesh.meltyp=meltyp;
Mesh.nnpe=nnpe;
Mesh.nnps=nnps;
Mesh.dof=dof;
Mesh.crds=crds;
Mesh.conn=conn;
Mesh.numnod=size(crds,1);
Mesh.X=Xi;
Mesh.Y=Yi;




return

end
