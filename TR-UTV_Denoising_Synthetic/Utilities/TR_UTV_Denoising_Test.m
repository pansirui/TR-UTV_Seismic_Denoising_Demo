function [PSNR_Final,FSIM_Final,SSIM_Final,ERGAS_Final, SAM_Final, iter, Time_s] = TR_UTV_Denoising_Test(ori, Y, tau, alpha, beta, gamma, lambda1, lambda2, r, iter_g)

randn('seed',0);

par = Parset_TR_UTV(tau, alpha, beta, gamma, lambda1, lambda2, r, iter_g);

time0 = clock;
 
[Denoising, iter] = TR_UTV_Denoising(ori, Y, par);  
% iter = iter - 1;

Time_s = (etime(clock,time0));

Xnew = Denoising{iter}; 

% save('Denoised_TR_LSM_100_200_400_20_2.mat','Xnew','-v7.3') ;

output_image = ((Xnew - min(Xnew(:))) / (max(Xnew(:)) - min(Xnew(:))))*255;

Ori_Image = ((ori - min(ori(:))) / (max(ori(:)) - min(ori(:))))*255;

% [PSNR_all] = evaluate1(Ori_Image,output_image);

[PSNR_Final, SSIM_Final, FSIM_Final, ERGAS_Final, SAM_Final] = MSIQA(Ori_Image, output_image);

end

