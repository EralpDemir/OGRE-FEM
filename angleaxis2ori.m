function [R]=angleaxis2ori(r,th)


% Calculations
% Normalize vector
r = r /norm(r);

% Identity matrix - Kronecker delta
I = eye(3);

% Permutation symbol - Levi-Civita operator
e=zeros(3,3,3);
e(1,2,3)=1;
e(2,3,1)=1;
e(3,1,2)=1;
e(3,2,1)=-1;
e(1,3,2)=-1;
e(2,1,3)=-1;





u=r(1);
v=r(2);
w=r(3);




R = [cosd(th) + u^2 * (1-cosd(th)), u * v * (1-cosd(th)) + w * sind(th), u * w * (1-cosd(th)) - v * sind(th) ;
    u * v * (1-cosd(th)) - w * sind(th), cosd(th) + v^2 * (1-cosd(th)) , v * w * (1-cosd(th)) + u * sind(th);
    u * w * (1-cosd(th)) + v * sind(th) , v * w * (1-cosd(th)) - u * sind(th) , cosd(th) + w^2 * (1-cosd(th));];


% R
% 
% R_=zeros(3);
% for i=1:3
%     
%     for j=1:3
%         
%         sum=0;
%         for k=1:3
%         
%             sum = sum + e(i,j,k)*sind(th)*r(k);
%         
%         
%         end
%         
%         R_(i,j) = I(i,j)*cosd(th) + sum  + (1-cosd(th))*r(i)*r(j);
%         
%         
%     end
% end
% 
% R_

% Recalculate angle
th_=acosd((trace(R)-1)/2);


