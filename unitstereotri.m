function [Data] = unitstereotri(Data,nodata)




Data.u = zeros(nodata,1);
Data.v = zeros(nodata,1);
Data.w = zeros(nodata,1);
Data.th = zeros(nodata,1);


% Identity
I3 = eye(3);

% Loop through all the data
for i=1:1:nodata
            
    
    xc=Data.X(i);

    yc=Data.Y(i);
        
        
%         if xc<xlim(2)
%             
%             if xc>xlim(1)
%             
%                 if yc<ylim(2) 
%                 
%                     if yc>ylim(1)
            
    phi1 = Data.phi1(i);
    phi2 = Data.phi2(i);
    Phi = Data.Phi(i);

    [g] = Eulerang2ori(phi1, Phi, phi2);



    [ang, axis, deltag, Type] = misorientation(g,I3);


    Data.u(i) = axis(1);
    Data.v(i) = axis(2);
    Data.w(i) = axis(3);
    Data.th(i) = ang;
                    
                    
                    
%                     end
%                 
%               
%                 end
%             
%             end
%             
%                 
%         end
            
            
            


end



return
end

