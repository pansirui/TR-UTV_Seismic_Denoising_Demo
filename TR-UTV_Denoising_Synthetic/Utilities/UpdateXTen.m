function Xnew = UpdateXTen(Y,Z,Dx,Dy,B,Bx,By,alpha,beta,gamma)
% Y is 150*400*40
% Z is 150*400*40
% Dx is 150*400*40
% Dy is 150*400*40
% B is 150*400*40
% Bx is 150*400*40
% By is 150*400*40
% alpha is 10
% beta is 100
% gamma is 100

Xnew = zeros(size(Y));
% Xnew is 150*400*40


for i = 1:size(Y,3)
    y = Y(:,:,i); 
    % y is 150*400    
    z = Z(:,:,i);
    % z is 150*400
    
    dx = Dx(:,:,i); 
    % dx is150*400
    
    dy = Dy(:,:,i);
    %dy is 150*400    
    
    b  = B(:,:,i); 
    % b is 150*400
    
    bx = Bx(:,:,i); 
    % bx is 150*400
    
    by = By(:,:,i);
    % by is 150*400
    
    xnew = Updatex(y,z,b,bx,by,dx,dy,alpha,beta,gamma);
    
    Xnew(:,:,i) = xnew;
end
end