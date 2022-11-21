function [Data] = cleanup(Data, nn, xlim, ylim, CIlim) 


% figure
% contourf(Data.X, Data.Y, Data.CI)
% axis equal
% colorbar
% 
% figure
% contourf(Data.X, Data.Y, Data.GrainID)
% axis equal
% colorbar




% Critical distance
cd=nn*Data.Stepsize*sqrt(2);

% Loop through the data
changed=true;
loop=0;
while changed
    changed=false;
    loop = loop + 1;
    disp(['cleanup - iteration loop: ', num2str(loop)])
    for i=1:1:Data.MaxYPos
    
        for j=1:1:Data.MaxXPos
        
        
            xc=Data.X(i,j);
            
            yc=Data.Y(i,j);
        
        
            if xc<xlim(2)
                
                if xc>xlim(1)
            
                if yc<ylim(2) 
                    
                    if yc>ylim(1)
        
        
                    % If the point is problematic
                    if Data.CI(i,j)<CIlim || Data.GrainID(i,j)==0
            
            
                        neigh=[];
                        weigh=[];
                        % Loop through its nearest neighbors
                        for k=1:1:Data.MaxYPos
                
                            for l=1:1:Data.MaxXPos
                    
                                xn=Data.X(k,l);
                    
                                yn=Data.Y(k,l);
                    
                    
                                dn = sqrt((xn-xc)^2+(yn-yc)^2);
                    
                                % If below critical distance, nearest neighbor
                                if dn<=cd
                        
                                    % If it is not the same point
                                    if k~=i
                                        if l~=j
                                            if Data.CI(k,l)>= CIlim
                                                weigh = [weigh, dn/Data.Stepsize/double(Data.CI(k,l))];
                                                neigh = [neigh; k, l ];
                                            end
                                        end
                                    end
                        
                        
                                end
                    
                    
                            end
                        end
            
            
                
            
                        % Find the nearest point with a non-zero grain ID
                        [val, ind]=max(weigh);
                        if isempty(ind) || val==0
                            disp(['Preserve the point ', num2str(i), ' ', num2str(j)])
                            k=i;
                            l=j;
                            changed=true;
                        else
            

                            
                            % Find the nearest point with smallest weight
                            for x=1:1:size(weigh,2)

                                if val>weigh(x) && weigh(x)~=0


                                    if Data.CI(neigh(x,1),neigh(x,2))>Data.CI(i,j)
                                    
                                        % Assign the value of the neighbor 
                                        k=neigh(x,1);
                                        l=neigh(x,2);
                                    
                                        val=weigh(x);
                                      
                       
                                        
                                        
                                    end
                                        
                                end

                            end

                            
                            
                
                        end
            
                        

                        Data.CI(i,j) =  Data.CI(k,l);
                        Data.Phi1(i,j) =  Data.Phi1(k,l);
                        Data.Phi(i,j) =  Data.Phi(k,l);
                        Data.Phi2(i,j) =  Data.Phi2(k,l);
                        Data.GrainID(i,j) = Data.GrainID(k,l);


            
            
            
                        if Data.GrainID(i,j)==0
                            changed=true;
                        end
            
            
            
            
            
                    end
                    
                    
                    end
                    
                end
                    
                end
            end
        end
    end
    
    
    a = find(Data.GrainID==0);
    size(a,1)
    
    if isempty(a)
        changed=false;
    else
        changed=true;
    end
    
    
end









% figure
% contourf(Data.X, Data.Y, Data.CI)
% axis equal
% colorbar
% 
% figure
% contourf(Data.X, Data.Y, Data.GrainID)
% axis equal
% colorbar



return
end
