function [conjoDx,conjoDy,num1,Denom1,Denom2] = getC(g)
% compute fixed quantities
sizeI = size(g);
% otfDx = psf2otf([1,0;0 0;0 0;0 0;0 0;0 0;0 -1],sizeI);
% otfDy = psf2otf([0 0 0 0 0 0 -1;1 0 0 0 0 0 0],sizeI);
% otfDx = psf2otf([0,1;0 0;-1 0],sizeI);
% otfDy = psf2otf([1 0 0;0 0 -1],sizeI);
% otfDx = psf2otf([0,1;-1,0],sizeI);
% otfDy = psf2otf([1 0;0 -1],sizeI);
otfDx = psf2otf([1,-1],sizeI); % ˮƽ�������˲���
otfDy = psf2otf([1;-1],sizeI);% ��ֱ�������˲���
%���� x �� y �������ɢ����Ҷ�任�Ĺ�ѧ���ݺ��� (OTF) �ĸ���Ҷ�棺
conjoDx = conj(otfDx);
conjoDy = conj(otfDy);
%���� otfDx �� otfDy �ĸ������Щ�����ں�����Ƶ�������ʹ�á�
num1 = abs(otfDx).^2.*fft2(g);
%abs(otfDx).^2 ���� otfDx �ľ���ֵ��ƽ��������Ƶ���в���˲�����������
%fft2(g) �Ƕ�����ͼ�� g ���ж�ά����Ҷ�任��
%num1 �������ߵĳ˻��������Ƶ���о����˲������ͼ���ʾ��
Denom1 = abs(otfDx).^2;
Denom2 = abs(otfDy).^2;
%Denom1 �� otfDx �ľ���ֵƽ������ʾ x �������˲�����������
%Denom2 �� otfDy �ľ���ֵƽ������ʾ y �������˲�����������
end