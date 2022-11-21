function [GND_EM]=EM_GND(A,b,alpha_vec,nodata,Burger,SF)



% Pick the combinations that are geometrically linearly independent
Possibilities=nchoosek(1:18,9);
no=size(Possibilities);
LI_solns=0;
for count=1:no(1)
    i=Possibilities(count,1);j=Possibilities(count,2);k=Possibilities(count,3);...
    l=Possibilities(count,4);m=Possibilities(count,5);n=Possibilities(count,6);...
    o=Possibilities(count,7);p=Possibilities(count,8);r=Possibilities(count,9);

    D=[ A(1:9,i) A(1:9,j) A(1:9,k) ...
        A(1:9,l) A(1:9,m) A(1:9,n) ...
        A(1:9,o) A(1:9,p) A(1:9,r)];
    
    if abs(det(D))>1e-3
        LI_solns=LI_solns+1;
        % No need for least square fit
        %Coeff(LI_solns,1:9,1:9)=inv(D'*D)*D';
        
        % Take the inverse afterwards
        % Coeff(LI_solns,1:9,1:9)=inv(D);
        Coeff(LI_solns,1:9,1:9)=D;
        GNDSystems(LI_solns,1:9)=[i j k l m n o p r];
    end
%     % Output the increment
%     if mod(count,10)==0
%         disp([num2str(count*100/no(1)) ' % of linearly independent solutions completed']);
%     end
end



% Find the minimum energy solutions for each element
for iele=1:nodata

    % Nye's tensor
    alphav(1:9,1)=alpha_vec(iele,:)';
    
    rhoGND=zeros(LI_solns,9);
    rhoGND_norm=zeros(1,LI_solns);
    for i=1:LI_solns

        dummy_coeff(1:9,1:9)=Coeff(i,1:9,1:9);

        % Take the inverse of the transformed coefficient matrix
        coefficient=inv(dummy_coeff);
        
        % find the densities
        rhoGND(i,1:9)=coefficient*alphav/Burger*SF;
        
        % Identify the systems
        Systems=GNDSystems(i,1:9);
        
        % Total vectorial length of the dislocation
        rhoGNDvec=zeros(1,3);
        for j=1:9
            rhoGNDvec = rhoGNDvec + b(Systems(j),:)*rhoGND(i,j);
        end
        
        % Sum absolute value of the densities
        rhoGND_norm(i)=norm(rhoGNDvec);
        
        
        
    end

    % The minimum amount of total GND and corresponding index among
    % LI-solutions
    [GND_EM.norm(iele), GND_EM.LI_index(iele)]=min(rhoGND_norm);

    % The corresponding slip systems for min-GND solution
    GND_EM.Systems(iele,1:9)=GNDSystems(GND_EM.LI_index(iele),1:9);

    % The corresponding densities to slip systems for min-GND solution
    GND_EM.all(iele,1:18)=zeros(1,18);
    GND_EM.all(iele,GND_EM.Systems(iele,1:9)) = rhoGND(GND_EM.LI_index(iele),1:9);
                
        
    % Output the increment
    if mod(iele,10)==0
        disp([num2str(iele*100/nodata) ' % of energy minimization method is completed!']);
    end
    
end


return
end
