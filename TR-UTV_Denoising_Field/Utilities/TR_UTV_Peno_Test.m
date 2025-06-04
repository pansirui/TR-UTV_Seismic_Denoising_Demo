function [recover] = TR_UTV_Peno_Test(Y, tau, alpha, beta, gamma, lambda1, lambda2, r, iter_g)

randn ('seed',0);

par = Parset_TR_UTV(tau, alpha, beta, gamma, lambda1, lambda2, r, iter_g);

Y = permute(Y, [2 1 3]);

Y = ((Y - min(Y,[],'all')) / (max(Y,[],'all') - min(Y,[],'all')));
Y = 2 * Y - 1;
 
randn ('seed',0);

[Nx,Ny,Nt] = size(Y);

Bx = zeros(Nx,Ny,Nt); 
By = zeros(Nx,Ny,Nt); 
B = zeros(Nx,Ny,Nt);

Dx = zeros(Nx,Ny,Nt); 
Dy = zeros(Nx,Ny,Nt); 

Z = Y; 
X = Y; 

Iter=20;

for k = 1: Iter

    % Update X
    Xnew = UpdateXTen(Y,Z,Dx,Dy,B,Bx,By,alpha,beta,gamma);
    X = Xnew;    
    
    % Update Z
    [Znew] = proxF_TR_Main(X+B, tau, alpha, par);
    Z = Znew;

    % Update Dx
    Dxx = zeros(Nx,Ny,Nt);
    for i = 1:Nt 
        temp = diff(X(:,:,i)-Y(:,:,i),1,2);
        dx = [temp temp(:,Ny-1)];  
        Dxx(:,:,i) = dx;
    end
    Dx_new = proxF_GSM_sparsity_3D_W(Dxx+Bx,lambda1/beta);   

    % Update Dy
    Dyy = zeros(Nx,Ny,Nt);
    for i = 1:Nt
        temp1 = diff(X(:,:,i),1,1);
        dy = [temp1;temp1(Nx-1,:)];
        Dyy(:,:,i) = dy;
    end
    Dy_new = proxF_GSM_sparsity_3D_W(Dyy+By,lambda2/gamma);
 
    Dx = Dx_new;      
    Dy = Dy_new;

    % Update B, Bx, and By
    B_new  = B+(X-Z);
    Bx_new = zeros(Nx,Ny,Nt);
    By_new = zeros(Nx,Ny,Nt);
    for i = 1:Nt
        Bx_new(:,:,i) = Bx(:,:,i) + (X(:,[2:Ny,Ny],i) - X(:,:,i)) - (Y(:,[2:Ny,Ny],i)- Y(:,:,i)) - Dx(:,:,i);
        By_new(:,:,i) = By(:,:,i) +   X([2:Nx,Nx],:,i)- X(:,:,i) - Dy(:,:,i);
    end

    B = B_new;    
    Bx = Bx_new;     
    By = By_new;
 

end

recover = X; 
% noise = Y - X;

% save('peno_recover.mat','recover','-v7.3');
% save('peno_noise.mat','noise','-v7.3');
