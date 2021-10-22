function [ACF] = myACF(sp)
fs=12500;
t=(0:length(sp)-1)/fs;
N=length(sp);

M=N-1;
ACF=zeros(M,1);

for k=1:1:M
     for n=1:1:N-k+1 
         ACF(k)=ACF(k)+sp(n)*sp(n+k-1);
     end
end

ACF=ACF./max(ACF);

end
