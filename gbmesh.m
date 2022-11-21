function [MeshGB]=gbmesh(Mesh,Data)

% Loop throgh the nodes

MeshGB=Mesh;


% Plot grain boundaries
figure
hold on
Z=zeros(size(Mesh.X));
surf(Mesh.X,Mesh.Y,Z);
axis equal

for i=1:1:Mesh.numnod
    
   
    % find the elements that are connected to that node
    [elno,nodeno] = find(Mesh.conn==i);
  
    
    % host GrainID
    hgrainId = Data.grainId(elno(1));
    
    
    
    
    % For all of the elements add a new node to the list except the host
    % element (that is why -1 is subtracted!)
    if size(elno,1)-1>0
        
        % Flag for plotting nodes
        for j=1:size(elno,1)-1






           iele=elno(j+1);
           inode=nodeno(j+1);
            
           
           if Data.grainId(iele)~=hgrainId

%                 plot(Mesh.crds(Mesh.conn(iele,inode),1),Mesh.crds(Mesh.conn(iele,inode),2),'ro')
                plot(Mesh.crds(i,1),Mesh.crds(i,2),'ro')
                
%                 plot(Mesh.crds(Mesh.conn(elno(1),nodeno(1)),1),Mesh.crds(Mesh.conn(elno(1),nodeno(1)),2),'bo')
               
               
                MeshGB.numnod = MeshGB.numnod + 1;

                % Change connectivity
                MeshGB.conn(iele,inode)=  MeshGB.numnod;

                % Change coordinates
                MeshGB.crds(MeshGB.numnod,:) = Mesh.crds(i,:);

           end




        end
        
    end
    
    
    
end











return

end
