function [Data] = cleanup(Data, nn, ss, nodata) 


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
cd=nn*ss*sqrt(2);






% Loop through these points
keep=true;
iter=0;

while keep
    
    keep=false;
   
    iter=iter+1;
    
    % Find the bad conditioned data points
    [is]=find(Data.grainId==0 );%& Data.X>xlim(1) & Data.X<xlim(2) & Data.Y>ylim(1) & Data.Y<ylim(2));% | Data.CI<CIlim);
    

    
    [is_]=find(Data.phi1==0 & Data.Phi==0 & Data.phi2==0 );%& Data.X>xlim(1) & Data.X<xlim(2) & Data.Y>ylim(1) & Data.Y<ylim(2));% | Data.CI<CIlim);
    
    
    [is__]=find(isnan(Data.grainId) ==1 );%& Data.X>xlim(1) & Data.X<xlim(2) & Data.Y>ylim(1) & Data.Y<ylim(2));% | Data.CI<CIlim);
    
    
    is=[is; is_; is__];
    
    

    
    % Number of bad conditioned points
    npts=size(is,1);
    
    
    % If number of points greater than 0
    if npts~=0 %&&  npts~=npts_old
        
        keep=true;
    
        for ipt=1:npts



            % point index
            i=is(ipt);



%             % Condition to check
%             if (Data.GrainID(i)==0) %| Data.CI(i,j)<CIlim)


                % Coordinates of the point of concern
                xc=Data.X(i);        
                yc=Data.Y(i);


                % List the nearest neighbors of that point
                neigh=[];
                weigh=[];
                % Loop through its nearest neighbors
                for k=1:1:nodata
                   
                    xn=Data.X(k);

                    yn=Data.Y(k);


                    dn = sqrt((xn-xc)^2+(yn-yc)^2);

                    % If below critical distance, nearest neighbor
                    if dn<=cd

                        % If it is not the same point
                        if k~=i
%                             if Data.CI(k,l)>= CIlim
                            weigh = [weigh, dn/ss];
                            neigh = [neigh; k];
%                             end
                        end
                    end




                end


%             end



            % Process nearest neighbors
            [val, ind]=max(weigh);
            if isempty(ind) || val==0
                disp(['Preserve the point ', num2str(i)])
                k=i;
            else



                % Find the nearest point with smallest weight
                for x=1:1:size(weigh,2)

                    if val>weigh(x) && weigh(x)~=0


%                         if Data.CI(neigh(x,1),neigh(x,2))>Data.CI(i,j)

                            % Assign the value of the neighbor 
                            k=neigh(x,1);

                            val=weigh(x);




%                         end

                    end

                end




                Data.phi1(i) =  Data.phi1(k);
                Data.Phi(i) =  Data.Phi(k);
                Data.phi2(i) =  Data.phi2(k);
                Data.grainId(i) = Data.grainId(k);





      
            





            end
            
    
        end

        disp([num2str(ipt/npts*100), ' % is of iteration no. ', num2str(iter), ' is complete!' ])
            
            
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
