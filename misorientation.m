% Eralp Demir
% 16 Jan 2022

% Misorientation calculations

% Input 2 orientations
% This code calculates misorientation between two grains having 432 crystal
% symmetry and 4-fold sample symmetry


function [ang, axis, deltag, Type] = misorientation(g1,g2)

Type=0;



% Cubic crystal Symmetry Operators
crysym(1,1:3,1:3)=  [1 0 0;
                    0 1 0;
                    0 0 1];
                
crysym(2,1:3,1:3)= [0 0 1;
                    1 0 0;
                    0 1 0];

crysym(3,1:3,1:3)= [0 1 0;
                    0 0 1;
                    1 0 0];

crysym(4,1:3,1:3)= [0 -1 0;
                    0 0 1;
                    -1 0 0];

crysym(5,1:3,1:3)= [0 -1 0;
                    0 0 -1;
                    1 0 0];

crysym(6,1:3,1:3)= [0 1 0;
                    0 0 -1;
                    -1 0 0];

crysym(7,1:3,1:3)= [0 0 -1;
                    1 0 0;
                    0 -1 0];

crysym(8,1:3,1:3)= [0 0 -1;
                    -1 0 0;
                    0 1 0];

crysym(9,1:3,1:3)= [0 0 1;
                    -1 0 0;
                    0 -1 0];

crysym(10,1:3,1:3)= [-1 0 0;
                    0 1 0;
                    0 0 -1];

crysym(11,1:3,1:3)= [-1 0 0;
                    0 -1 0;
                    0 0 1];

crysym(12,1:3,1:3)= [1 0 0;
                    0 -1 0;
                    0 0 -1];

crysym(13,1:3,1:3)= [0 0 -1;
                    0 -1 0;
                    -1 0 0];

crysym(14,1:3,1:3)= [0 0 1;
                    0 -1 0;
                    1 0 0];

crysym(15,1:3,1:3)= [0 0 1;
                    0 1 0;
                    -1 0 0];

crysym(16,1:3,1:3)= [0 0 -1;
                    0 1 0;
                    1 0 0];

crysym(17,1:3,1:3)= [-1 0 0;
                    0 0 -1;
                    0 -1 0];

crysym(18,1:3,1:3)= [1 0 0;
                    0 0 -1;
                    0 1 0];

crysym(19,1:3,1:3)= [1 0 0;
                    0 0 1;
                    0 -1 0];

crysym(20,1:3,1:3)= [-1 0 0;
                    0 0 1;
                    0 1 0];

crysym(21,1:3,1:3)= [0 -1 0 ;
                    -1 0 0;
                    0 0 -1];

crysym(22,1:3,1:3)= [0 1 0;
                    -1 0 0;
                    0 0 1];

crysym(23,1:3,1:3)= [0 1 0;
                    1 0 0;
                    0 0 -1];

crysym(24,1:3,1:3)= [0 -1 0;
                    1 0 0;
                    0 0 1];

                
                
                
                
% Sample Symmetry operators                
samsym(1,1:3,1:3)= [1 0 0;
                    0 1 0;
                    0 0 1];
samsym(2,1:3,1:3)= [-1 0 0;
                    0 1 0;
                    0 0 -1];
samsym(3,1:3,1:3)= [1 0 0;
                    0 -1 0;
                    0 0 -1];
samsym(4,1:3,1:3)= [-1 0 0;
                    0 -1 0;
                    0 0 1];


% INPUT Crystal orientations   
% ksi1=Euler1(1)*pi/180;
% phi=Euler1(2)*pi/180;
% ksi2=Euler1(3)*pi/180;
% g1(1,1)=cos(ksi1)*cos(ksi2)-sin(ksi1)*sin(ksi2)*cos(phi);
% g1(2,1)=-cos(ksi1)*sin(ksi2)-sin(ksi1)*cos(ksi2)*cos(phi);
% g1(3,1)=sin(ksi1)*sin(phi);
% g1(1,2)=sin(ksi1)*cos(ksi2)+cos(ksi1)*sin(ksi2)*cos(phi);
% g1(2,2)=-sin(ksi1)*sin(ksi2)+cos(ksi1)*cos(ksi2)*cos(phi);
% g1(3,2)=-cos(ksi1)*sin(phi);
% g1(1,3)=sin(ksi2)*sin(phi);
% g1(2,3)=cos(ksi2)*sin(phi);
% g1(3,3)=cos(phi);
% % 
% ksi1=Euler2(1)*pi/180;
% phi=Euler2(2)*pi/180;
% ksi2=Euler2(3)*pi/180;
% g2(1,1)=cos(ksi1)*cos(ksi2)-sin(ksi1)*sin(ksi2)*cos(phi);
% g2(2,1)=-cos(ksi1)*sin(ksi2)-sin(ksi1)*cos(ksi2)*cos(phi);
% g2(3,1)=sin(ksi1)*sin(phi);
% g2(1,2)=sin(ksi1)*cos(ksi2)+cos(ksi1)*sin(ksi2)*cos(phi);
% g2(2,2)=-sin(ksi1)*sin(ksi2)+cos(ksi1)*cos(ksi2)*cos(phi);
% g2(3,2)=-cos(ksi1)*sin(phi);
% g2(1,3)=sin(ksi2)*sin(phi);
% g2(2,3)=cos(ksi2)*sin(phi);
% g2(3,3)=cos(phi);
% %     
    
    
% ___________________________MISORIENTATION EVALUATIONS_____________________
				
				
deltadeltag=pi/2;
counter=0;


% THE LOOPS TO RUN MISORIENTATION DISTANCE
% 1: Crystal Symmetry to 1st Texture Component

for mm=1:24
    g11 = zeros(3);
    for j=1:3
        for k=1:3
            for l=1:3
                g11(j,k)=g11(j,k)+crysym(mm,j,l)*g1(l,k);
            end
        end
    end


% 2: Crystal Symmetry to 2nd Texture Component
    for nn=1:24
        g22 = zeros(3);
        for j=1:3
            for k=1:3
                for l=1:3
                    g22(j,k)=g22(j,k)+crysym(nn,j,l)*g2(l,k);
                end
            end
        end



% NO SAMPLE SYMMETRY IS USED FOR THE TIME BEING!!!
 
 
		
%3: Misorientation*Inverse(OD)

% 3.a. Inverse of OD
        ginv = g11';
						
% 3.b. Multiplication
        gres1=zeros(3);
        for j=1:3
            for k=1:3
                for l=1:3
                    gres1(j,k)=gres1(j,k)+g22(j,l)*ginv(l,k);
                end
            end
        end

% 4: OD*Inverse(MOD)

% 4.a. Inverse of MOD
        ginv=g22';
						
% 4.b. Multiplication
        gres2=zeros(3);
        for j=1:3
            for k=1:3
                for l=1:3
                    gres2(j,k)=gres2(j,k)+g11(j,l)*ginv(l,k);
                end
            end
        end


% 5. CHECK IF THE MISORIENTATION IS IN FUNDAMENTAL ZONE
% 5.a. For 1st result: (gres1)
        sq=sqrt((gres1(2,3)-gres1(3,2))^2+(gres1(1,3)-gres1(3,1))^2 ...
            +(gres1(2,1)-gres1(1,2))^2);
        if not(sq==0)
            x1=(gres1(2,3)-gres1(3,2))/sq;
            x2=(gres1(3,1)-gres1(1,3))/sq;
            x3=(gres1(1,2)-gres1(2,1))/sq;
            if (x1>=0) 
                if (x2>=0) 
                    if (x3>=0) 
                        if (x1<=x2) 
                            if (x2<=x3) 
                                trace=gres1(1,1)+gres1(2,2)+gres1(3,3);
                                ddg=acos((trace-1)/2);
                                if (abs(ddg)<deltadeltag) 
                                    deltadeltag=ddg;
                                    for i=1:3
                                        for j=1:3
                                            delta_g(i,j)=gres1(i,j);
                                            axis=[x1 x2 x3];
                                            Type=1;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end		
 
% 5.b. For 2nd result: (gres2)
        sq=sqrt((gres2(2,3)-gres2(3,2))^2+(gres2(1,3)-gres2(3,1))^2 ...
                +(gres2(2,1)-gres2(1,2))^2);
        if not(sq==0)
            xx1=(gres2(2,3)-gres2(3,2))/sq;
            xx2=(gres2(3,1)-gres2(1,3))/sq;
            xx3=(gres2(1,2)-gres2(2,1))/sq;
            if (xx1>=0) 
                if (xx2>=0) 
                    if (xx3>=0) 
                        if (xx1<=xx2) 
                            if (xx2<=xx3) 
                                trace=gres2(1,1)+gres2(2,2)+gres2(3,3);
                                ddg=acos((trace-1)/2);
                                if (abs(ddg)<deltadeltag) 
                                    deltadeltag=ddg;
                                    for i=1:3
                                        for j=1:3
                                            delta_g(i,j)=gres2(j,i);
                                            axis=[xx1 xx2 xx3];
                                            Type=2;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
% End of 2nd Cystal Symmetry op.      
    end
% End of 1st Crystal Symmetry op.    
end


if deltadeltag==pi/2
    deltag=eye(3,3);
    axis=zeros(3);
    Type=0;
    ang=0;
elseif deltadeltag==0
    deltag=eye(3,3);
    axis=zeros(3);
    Type=0;
    ang=0;    
else
    % Results: 
    ang=deltadeltag*180/pi;
    deltag=delta_g;
end

return

end

