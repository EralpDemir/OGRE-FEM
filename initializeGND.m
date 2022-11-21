
function [A,b,t,alpha_vec]=initializeGND(dgel,numel)



% FINDING GND DENSITIES
% Formation of Nye tensor for each dislocation line direction and Burgers
% vector for FCC metals

% Line directions
t(1,1:3)=[-1 -1 2]/sqrt(6);
t(2,1:3)=[-1 2 -1]/sqrt(6);
t(3,1:3)=[2 -1 -1]/sqrt(6);
t(4,1:3)=[-1 1 -2]/sqrt(6);
t(5,1:3)=[-1 -2 1]/sqrt(6);
t(6,1:3)=[2 1 1]/sqrt(6);
t(7,1:3)=[1 -1 -2]/sqrt(6);
t(8,1:3)=[1 2 1]/sqrt(6);
t(9,1:3)=[-2 -1 1]/sqrt(6);
t(10,1:3)=[1 1 2]/sqrt(6);
t(11,1:3)=[1 -2 -1]/sqrt(6);
t(12,1:3)=[-2 1 -1]/sqrt(6);
t(13,1:3)=[1 1 0]/sqrt(2);
t(14,1:3)=[1 0 1]/sqrt(2);
t(15,1:3)=[0 1 1]/sqrt(2);
t(16,1:3)=[-1 1 0]/sqrt(2);
t(17,1:3)=[1 0 -1]/sqrt(2);
t(18,1:3)=[0 -1 1]/sqrt(2);
    
% Burgers vector
b(1,1:3)=[-1 1 0]/sqrt(2);
b(2,1:3)=[1 0 -1]/sqrt(2);
b(3,1:3)=[0 -1 1]/sqrt(2);
b(4,1:3)=[-1 -1 0]/sqrt(2);
b(5,1:3)=[1 0 1]/sqrt(2);
b(6,1:3)=[0 1 -1]/sqrt(2);
b(7,1:3)=[1 1 0]/sqrt(2);
b(8,1:3)=[-1 0 1]/sqrt(2);
b(9,1:3)=[0 -1 -1]/sqrt(2);
b(10,1:3)=[1 -1 0]/sqrt(2);
b(11,1:3)=[-1 0 -1]/sqrt(2);
b(12,1:3)=[0 1 1]/sqrt(2);
b(13,1:3)=[1 1 0]/sqrt(2);
b(14,1:3)=[1 0 1]/sqrt(2);
b(15,1:3)=[0 1 1]/sqrt(2);
b(16,1:3)=[-1 1 0]/sqrt(2);
b(17,1:3)=[1 0 -1]/sqrt(2);
b(18,1:3)=[0 -1 1]/sqrt(2);


% Permutation Symbol
e=zeros(3,3,3);
e(1,2,3)=1;
e(2,3,1)=1;
e(3,1,2)=1;
e(3,2,1)=-1;
e(1,3,2)=-1;
e(2,1,3)=-1;


% Least square method
% A rho = alpha

% Dislocation tensor for each sliop system
d=zeros(18,3,3);
for k=1:18
    for i=1:3
        for j=1:3
            d(k,i,j)=b(k,i)*t(k,j);
        end
    end
end


% Vectorize A tensor (9x18)
A =zeros(9,18);
for k=1:18
    A(1:9,k)=[  d(k,1,1);d(k,1,2);d(k,1,3);...
                    d(k,2,1);d(k,2,2);d(k,2,3);...
                    d(k,3,1);d(k,3,2);d(k,3,3);];
end



% Compute Nye's tensor
for iele=1:numel
    dg(1:27)=dgel(iele,1:27);
    
    deltag(1:3,1:3,1) = [   dg(1), dg(2), dg(3);
                            dg(4), dg(5), dg(6);
                            dg(7), dg(8), dg(9);];
                        
    deltag(1:3,1:3,2) = [   dg(10), dg(11), dg(12);
                            dg(13), dg(14), dg(15);
                            dg(16), dg(17), dg(18);];
                        
    deltag(1:3,1:3,3) = [   dg(19), dg(20), dg(21);
                            dg(22), dg(23), dg(24);
                            dg(25), dg(26), dg(27);];    
                        
    for p=1:3
        for i=1:3
            % Dummy indices
            Sum=0;
            for k=1:3
                for j=1:3
                    Sum=Sum+(e(p,k,j)*deltag(i,j,k));
                 end
            end
            alpha(p,i)=Sum;              
        end
    end
    alpha_vec(iele,1:9)=[   alpha(1,1) alpha(1,2) alpha(1,3) ...
                            alpha(2,1) alpha(2,2) alpha(2,3) ...
                            alpha(3,1) alpha(3,2) alpha(3,3)];
end





