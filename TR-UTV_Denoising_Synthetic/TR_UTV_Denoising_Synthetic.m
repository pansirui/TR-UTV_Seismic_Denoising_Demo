clear all
close all
clc

m_10=0; 
m_20=0; 
m_30=0;    
m_40=0;  
m_50=0; 
m_60=0; 
m_70=0; 

All_data_Results_2_10 = cell(1,200);  
All_data_Results_2_20 = cell(1,200);  
All_data_Results_2_30 = cell(1,200);
All_data_Results_2_40 = cell(1,200);
All_data_Results_2_50 = cell(1,200);
All_data_Results_2_60 = cell(1,200);
All_data_Results_2_70 = cell(1,200);


for i = 2  
    
    ImageNum = i;
  
    % F = [0.1, 0.2, 0.5];   
    % G = [0.01, 0.02, 0.03, 0.04];

    F = 0.2;   
    G = 0.02;

    for f = F

        for g = G

            switch ImageNum

                case 1
                    filename_clear = 'clear_40_200_400';
                    filename_noisy = sprintf('noisy_40_200_400_%d_%d',f*100,g*100);
                    fn_clear = [filename_clear, '.mat'];
                    fn_noisy = [filename_noisy, '.mat'];

                    ori = load (fn_clear);  
                    ori = ori.clear_40_200_400;
                    ori = permute(ori, [2 3 1]);
                    
                    Y = load(fn_noisy); 
                    Y = Y.noisy_40_200_400;
                    Y = permute(Y, [2 3 1]);

                case 2
                    filename_clear = 'clear_100_200_400';
                    filename_noisy = sprintf('noisy_100_200_400_%d_%d',f*100,g*100);
                    fn_clear = [filename_clear, '.mat'];
                    fn_noisy = [filename_noisy, '.mat'];

                    ori = load (fn_clear);  
                    ori = ori.clear_100_200_400;
                    ori = permute(ori, [2 3 1]);
                    
                    Y = load(fn_noisy); 
                    Y = Y.noisy_100_200_400;
                    Y = permute(Y, [2 3 1]);

                case 3
                    filename_clear = 'clear_200_200_400';
                    filename_noisy = sprintf('noisy_200_200_400_%d_%d',f*100,g*100);
                    fn_clear = [filename_clear, '.mat'];
                    fn_noisy = [filename_noisy, '.mat'];

                    ori = load (fn_clear);  
                    ori = ori.clear_200_200_400;
                    ori = permute(ori, [2 3 1]);
                    
                    Y = load(fn_noisy); 
                    Y = Y.noisy_200_200_400;
                    Y = permute(Y, [2 3 1]);

                case 4
                    filename_clear = 'clear_400_200_400';
                    filename_noisy = sprintf('noisy_400_200_400_%d_%d',f*100,g*100);
                    fn_clear = [filename_clear, '.mat'];
                    fn_noisy = [filename_noisy, '.mat'];

                    ori = load (fn_clear);  
                    ori = ori.clear_400_200_400;
                    ori = permute(ori, [2 3 1]);
                    
                    Y = load(fn_noisy); 
                    Y = Y.noisy_400_200_400;
                    Y = permute(Y, [2 3 1]);

            end

% calculate initial PSNR
dc = ori;
df = Y;
dc = ((dc - min(dc,[],'all')) / (max(dc,[],'all') - min(dc,[],'all')))*255;
df = ((df - min(df,[],'all')) / (max(df,[],'all') - min(df,[],'all')))*255;
PSNR_Initial = PSNR3D(dc, df);
clear dc df 

fprintf('filename_noisy = %s\n', filename_noisy)
fprintf('Initial PSNR = %2.2f\n', PSNR_Initial)

for j  =  1:1

    for m = 1:1
        
        for n = 1:1
            
            for mm = 1:1
                
                for nn = 1:1
                    
                    for mn = 1:1

                        for nm = 1:1
    
 
randn ('seed',0);

Tau_Num  = [0.1];
Alpha_Num = [0.1];
Beta_Num  = [0.5];
Gamma_Num = [0.1];
Lamb_Num1= [0.2];
Lamb_Num2 =  [2];
R_Num = [[14 10 10]];

tau  = Tau_Num(j);
alpha = Alpha_Num(m);
beta = Beta_Num(n);
gamma = Gamma_Num(mm);
lambda1 = Lamb_Num1(nn);
lambda2 =  Lamb_Num2(mn);
r = R_Num(nm,:);
iter_g = 25;  % iteration numbers of solving each core tensor G_i

fprintf('tau = %2.2f, alpha = %2.2f, beta = %2.2f, gamma = %2.2f, lambda1 = %2.2f, lambda2 = %2.2f, TR-rank = [%d %d %d], iter_g = %d\n', tau,alpha,beta,gamma,lambda1,lambda2,r,iter_g)

% quality assess
[PSNR_Final,FSIM_Final,SSIM_Final, ERGAS_Final, SAM_Final, Iters, Time_s] = TR_UTV_Denoising_Test (ori, Y, tau, alpha, beta, gamma, lambda1, lambda2, r, iter_g); 

% PSNR gain
PSNR_Gain = PSNR_Final - PSNR_Initial;

m_10 = m_10 + 1;
All_data_Results_2_10{m_10} = {filename_noisy, tau, alpha, beta, gamma, lambda1, lambda2, r(1), r(2), r(3), iter_g, PSNR_Final,FSIM_Final,SSIM_Final, ERGAS_Final, SAM_Final, Iters, Time_s, PSNR_Initial, PSNR_Gain};
 
% save results
writecell( All_data_Results_2_10{m_10}, 'TR_UTV_Denoising_Test_1.xls','Sheet',1,'WriteMode','append');
 
 clearvars -except ImageNum F G f g filename_noisy ori Y i j m n mm nn mn PSNR_Initial m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
                        end

 clearvars -except ImageNum F G f g filename_noisy ori Y i j m n mm nn PSNR_Initial m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
                    end
                    
 clearvars -except ImageNum F G f g filename_noisy ori Y i j m n mm PSNR_Initial m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
                end
                
 clearvars -except ImageNum F G f g filename_noisy ori Y i j m n PSNR_Initial m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
            end
            
 clearvars -except ImageNum F G f g filename_noisy ori Y i j m PSNR_Initial m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
        end
        
 clearvars -except ImageNum F G f g filename_noisy ori Y i j PSNR_Initial m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
    end

 clearvars -except ImageNum F G f g filename_noisy ori Y i PSNR_Initial m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
end

 clearvars -except ImageNum F G f m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
        end

 clearvars -except ImageNum F G m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
    end  
 
 clearvars -except m_20 All_data_Results_2_20 m_30 All_data_Results_2_30 m_40 All_data_Results_2_40...
    m_10 All_data_Results_2_10 m_50 All_data_Results_2_50 m_60 All_data_Results_2_60 m_70 All_data_Results_2_70
end
