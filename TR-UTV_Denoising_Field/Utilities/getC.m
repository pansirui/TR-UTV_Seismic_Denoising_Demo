function [conjoDx,conjoDy,num1,Denom1,Denom2] = getC(g)
% compute fixed quantities
sizeI = size(g);
% otfDx = psf2otf([1,0;0 0;0 0;0 0;0 0;0 0;0 -1],sizeI);
% otfDy = psf2otf([0 0 0 0 0 0 -1;1 0 0 0 0 0 0],sizeI);
% otfDx = psf2otf([0,1;0 0;-1 0],sizeI);
% otfDy = psf2otf([1 0 0;0 0 -1],sizeI);
% otfDx = psf2otf([0,1;-1,0],sizeI);
% otfDy = psf2otf([1 0;0 -1],sizeI);
otfDx = psf2otf([1,-1],sizeI); % 水平方向差分滤波器
otfDy = psf2otf([1;-1],sizeI);% 垂直方向差分滤波器
%计算 x 和 y 方向的离散傅里叶变换的光学传递函数 (OTF) 的傅里叶逆：
conjoDx = conj(otfDx);
conjoDy = conj(otfDy);
%计算 otfDx 和 otfDy 的复共轭。这些量将在后续的频域操作中使用。
num1 = abs(otfDx).^2.*fft2(g);
%abs(otfDx).^2 计算 otfDx 的绝对值的平方，这是频域中差分滤波器的能量。
%fft2(g) 是对输入图像 g 进行二维傅里叶变换。
%num1 是这两者的乘积，结果是频域中经过滤波器后的图像表示。
Denom1 = abs(otfDx).^2;
Denom2 = abs(otfDy).^2;
%Denom1 是 otfDx 的绝对值平方，表示 x 方向差分滤波器的能量。
%Denom2 是 otfDy 的绝对值平方，表示 y 方向差分滤波器的能量。
end