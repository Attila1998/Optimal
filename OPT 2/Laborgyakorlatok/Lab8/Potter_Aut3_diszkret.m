
function [P]=Potter_Aut3_diszkret(Ad,Bd,Q,R)

%% Potter modszer
H = [Ad+Bd*inv(R)*Bd'*inv(Ad')*Q -Bd*inv(R)*Bd'*inv(Ad');
     -inv(Ad')*Q inv(Ad')];

 
[sajat_vector, sajat_ertek]=eig(H); % sajat ertek, sajat vektor szamitas

sajat_vector_rendezett=[];

for i=1:length(sajat_vector)
   if abs(sajat_ertek(i,i))<1
      sajat_vector_rendezett=[sajat_vector(:,i) sajat_vector_rendezett]; %stabilak elore
   else   
      sajat_vector_rendezett=[sajat_vector_rendezett sajat_vector(:,i)]; % instabilak hatra
   end
end
n=length(H)/2;
V11=sajat_vector_rendezett(1:n, 1:n);
V21=sajat_vector_rendezett(n+1:n*2, 1:n);

P=real(V21*V11^-1);

end