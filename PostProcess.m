% Orientation analysis

max_grainId=max(Data.grainId);

avGND=zeros(max_grainId,1);
maxGND=zeros(max_grainId,1);
VF=zeros(max_grainId,1);
mis=zeros(max_grainId,1);

[ind val]=unique(Data.grainId);


for i=1:size(ind,1)
   
    % Calculate the area fraction
    grain = find(Data.grainId==i);
  
    VF(i)=size(grain,1);
    
    
    % Calculate the misorientation of the grains wrto sample ref.
    phi1=Data.phi1(val(i));
    Phi=Data.Phi(val(i));
    phi2=Data.phi2(val(i));
    
    Eulers(i,1:3)=[phi1, Phi, phi2];
    
    g2 = Eulerang2ori(phi1, Phi, phi2);
    g1 = eye(3);
    [ang, ~] = misorientation(g1,g2);

    mis(i)=ang;
    
    % Average GND
    avGND(i) = mean(GND_EM.norm(grain));
    
    % Maximum GND
    maxGND(i) = max(GND_EM.norm(grain));
    
    
end


