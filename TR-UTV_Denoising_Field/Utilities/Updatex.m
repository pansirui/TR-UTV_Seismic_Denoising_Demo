function xnew = Updatex(y,z,b,bx,by,dx,dy,alpha,beta,gamma)
ep = 1e-6;
[conjoDx,conjoDy,num1,Denom1,Denom2] = getC(y);
% conjoDx is 150*400 complex double ���׹�ʽ18�е�Dx^T
% conjoDy is 150*400 complex double ���׹�ʽ18�е�Dy^T
%num1 is 150*400 complex double ���׹�ʽ18��Dx^T Dx Y
%Denom1 is 150*400 double ���׹�ʽ18��Dx^T Dx 
%Denom2 is 150*400 double ���׹�ʽ18��Dy^T Dy 
FPsix = fft2( dx - bx );
%FPsix is 150*400 ���׹�ʽ18�е� Dx-Bx
FPsiy = fft2( dy - by );
%FPsiy is 150*400 ���׹�ʽ18�е� Dy-By
FGPx = conjoDx .* FPsix; 
% FGPx is 150*400 ����18�е� Dx^T* (Dx-Bx)
FGPy = conjoDy .* FPsiy; 
% FGPy is 150*400 ����18�е� Dy^T* (Dy -By)
Denom = alpha + beta*Denom1 + gamma*Denom2 + fft2(eye(1));   
% Denom is 50*400 ����19�е�
% (alpha+beta Dx^T*Dx+gamma*Dy^T*Dy+I)
Fu    = alpha*fft2(z-b) + beta*num1 + beta* FGPx + gamma*FGPy + fft2(y); 
% Fu is 150*400 Complex double
% ����20�е�
% alpha*(z-b)+beta*Dx^T* Dx*y + beta*Dx^T*(Dx-bx) +gamma*Dy^T * (Dy-By)+ y
xnew = real( ifft2(Fu./(Denom+ep)) ); 
% xnew is 150*400
%���׹�ʽ19
end