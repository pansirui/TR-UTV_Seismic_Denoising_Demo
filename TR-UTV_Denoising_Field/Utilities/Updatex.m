function xnew = Updatex(y,z,b,bx,by,dx,dy,alpha,beta,gamma)
ep = 1e-6;
[conjoDx,conjoDy,num1,Denom1,Denom2] = getC(y);
% conjoDx is 150*400 complex double 文献公式18中的Dx^T
% conjoDy is 150*400 complex double 文献公式18中的Dy^T
%num1 is 150*400 complex double 文献公式18中Dx^T Dx Y
%Denom1 is 150*400 double 文献公式18中Dx^T Dx 
%Denom2 is 150*400 double 文献公式18中Dy^T Dy 
FPsix = fft2( dx - bx );
%FPsix is 150*400 文献公式18中的 Dx-Bx
FPsiy = fft2( dy - by );
%FPsiy is 150*400 文献公式18中的 Dy-By
FGPx = conjoDx .* FPsix; 
% FGPx is 150*400 文献18中的 Dx^T* (Dx-Bx)
FGPy = conjoDy .* FPsiy; 
% FGPy is 150*400 文献18中的 Dy^T* (Dy -By)
Denom = alpha + beta*Denom1 + gamma*Denom2 + fft2(eye(1));   
% Denom is 50*400 文献19中的
% (alpha+beta Dx^T*Dx+gamma*Dy^T*Dy+I)
Fu    = alpha*fft2(z-b) + beta*num1 + beta* FGPx + gamma*FGPy + fft2(y); 
% Fu is 150*400 Complex double
% 文献20中的
% alpha*(z-b)+beta*Dx^T* Dx*y + beta*Dx^T*(Dx-bx) +gamma*Dy^T * (Dy-By)+ y
xnew = real( ifft2(Fu./(Denom+ep)) ); 
% xnew is 150*400
%文献公式19
end