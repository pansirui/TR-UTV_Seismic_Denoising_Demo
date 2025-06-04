clear all
close all
clc

% Y = load('peno_250_150_40.mat'); 
% Y = Y.peno_250_150_40;

Y = load('Kerry_40_400_150.mat'); 
Y = Y.Kerry3D_40_400_150;

m_10 = 0;
All_data_Results_2_10 = cell(1,200);   

for j  =  1:1

    for m = 1:1
        
        for n = 1:1
            
            for mm = 1:1
                
                for nn = 1:1
                    
                    for mn = 1:1

randn ('seed',0);

% Parameters setting for Peno dataset
% Tau_Num  = [1.0];
% Alpha_Num = [0.05];
% Beta_Num  = [0.5];
% Gamma_Num = [0.03];
% Lamb_Num1= [10];
% Lamb_Num2 =  [0.5];
% 
% R_Num = [[14 10 10]];

% Parameters setting for Kerry dataset
Tau_Num  = [0.05];
Alpha_Num = [0.01];
Beta_Num  = [0.3];
Gamma_Num = [6];
Lamb_Num1= [3];
Lamb_Num2 =  [0.4];

R_Num = [[14 10 10]];

tau  = Tau_Num(j);
alpha = Alpha_Num(m);
beta = Beta_Num(n);
gamma = Gamma_Num(mm);
lambda1 = Lamb_Num1(nn);
lambda2 =  Lamb_Num2(mn);

r = R_Num(1,:);
iter_g = 25;  

fprintf(['Parameters: tau = %2.2f, alpha = %2.2f, beta = %2.2f, gamma = %2.2f, lambda1 = %2.2f, ' ...
    'lambda2 = %2.2f, TR-rank = [%d %d %d], iter_g = %d\n'], tau,alpha,beta,gamma,lambda1,lambda2,r,iter_g)

% recover = TR_UTV_Peno_Test(Y, tau, alpha, beta, gamma, lambda1, lambda2, r, iter_g); 
recover = TR_UTV_Kerry_Test(Y, tau, alpha, beta, gamma, lambda1, lambda2, r, iter_g); 

[nx, ny, nt] = size(recover);

BRISQUE_ALL = zeros(1,nt);
NIQE_ALL = zeros(1,nt);
PIQE_ALL = zeros(1,nt);

for index = 1:1:nt

    img = squeeze(recover(:,:,index));

    min_value = min(img(:));
    max_value = max(img(:));
    
    img = uint8(255 * (img - min_value) / (max_value - min_value));
    
    brisqueScore = brisque(img);
    
    niqeScore = niqe(img);
    
    piqeScore = piqe(img);

    BRISQUE_ALL(index) = brisqueScore;
    NIQE_ALL(index) = niqeScore;
    PIQE_ALL(index) = piqeScore;

end

BRISQUE_MEAN = mean(BRISQUE_ALL);
NIQE_MEAN = mean(NIQE_ALL);
PIQE_MEAN = mean(PIQE_ALL);

m_10 = m_10 + 1;
All_data_Results_2_10{m_10} = {tau, alpha, beta, gamma, lambda1, lambda2, r(1), r(2), r(3), iter_g,... 
    BRISQUE_MEAN, NIQE_MEAN, PIQE_MEAN};

fprintf('BRISQUE = %2.2f, NIQE = %2.2f, PIQE = %2.2f\n', BRISQUE_MEAN, NIQE_MEAN, PIQE_MEAN)

                    end
                end
            end
        end
    end
end
