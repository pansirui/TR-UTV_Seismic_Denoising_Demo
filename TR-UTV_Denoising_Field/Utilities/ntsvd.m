%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [U,S,V] = ntsvd(A,fftOP,parOP)
% Nth order tension SVD
% Purpose:  Factors any higher order tensors into its component
%
% Inputs:   A - 3+ order tensor MxNx...
%
%           fftOP (optional) - boolean that determines if outputs have fft
%           Applied along each dimensions
%
%           1 ---- apply fft
%           0 ---- not apply fft
%
%           parOP (optional) - boolean, runs algorithm in parallel.
%
% Output:   U,S,V - (if fftOp true) where U*S*Vt = A.
%
%           or
%
%           U,S,V - (if fftOp false) ifft_T(U)*ifft_T(S)*ifft_T(V)^T = A
%
% Original author :  Misha Kilmer, Ning Hao
% Edited by       :  G. Ely, S. Aeron, Z. Zhang, ECE, Tufts Univ. 03/16/2015
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [U,S,V] = ntsvd(A,fftOP,parOP)
% A is 150*400*40
%fftOP is 1
% parOP is 0


% determine size of tensor
sa = size(A);
% sa is [150 400 40]


la = length(sa);
% la is 3

[n1,n2,n3]=size(A);
% n1 is 150
% n2 is 400
% n3 is 40

fl=0;


if ~exist('parOP','var')
    parOP = false;
end

if ~exist('fftOP','var')
   fftOP = false; 
end

%% Perform FFT along 3 to P axeses of Tensor


% conjugate symetric trick.
if la == 3
    if n2 > n1
        transflag=1;
        A=tran(A);
        % A is 400*150*40
        nn1=n1;
        %nn1 is 150
        n1=n2;
        % n1 is 400
        n2=nn1;
        %n2 is 150
    end
    U = zeros(n1,n1,n3);
    % U is 400*400*40
    S = zeros(n1,n2,n3);
    % S is 400*150*40
    V = zeros(n2,n2,n3);
    % V is 150*150*40
    % for P orders
else
    sU =sa;         %determines proper size
    sU(2) = sU(1);
    sV = sa;        %determines proper size
    sV(1) = sV(2);
    U = zeros(sU);  %pre allocated
    S = zeros(sa);
    V = zeros(sV);
end

for i = 3:la
    A = fft(A,[],i);
end
% A is 400*150*40 Complex double

faces = prod(sa(3:la));     %determine # of faces
% faces is 40

if la == 3
    % Do the conjugate symetric trick here.
    if isinteger(n3/2)
        endValue = int16(n3/2 + 1);
        [U, S, V] = takeSVDs(U,S,V,A,endValue,parOP);
        
        for j =n3:-1:endValue+1
            U(:,:,j) = conj(U(:,:,n3-j+2));
            V(:,:,j) = conj(V(:,:,n3-j+2));
            S(:,:,j) = S(:,:,n3-j+2);
        end

    else % if isinteger(n3/2)
        endValue = int16(n3/2 + 1);        
        [U,S,V] = takeSVDs(U,S,V,A,endValue,parOP);
        % U is 400*400*40
        % S is 400*150*40
        %V is 150*150*40
        
        for j =n3:-1:endValue+1
            U(:,:,j) = conj(U(:,:,n3-j+2));
            V(:,:,j) = conj(V(:,:,n3-j+2));
            S(:,:,j) = S(:,:,n3-j+2);
 %����δ����У����ڳߴ�Ϊ 400*150*40 ������ A��
 %�ֽ�ǰ21��ά�Ƚ�������������ֵ�ֽ⣨SVD����
 %�������ά��ʹ�ù���ԳƲ�����conj����
 %�������ڿ��ٸ���Ҷ�任��FFT�����ض������²����Ľ���ĶԳ��ԡ�
% ����� U(:,:,j), V(:,:,j), �� S(:,:,j) ��ͨ������Գ����Ƶ��ġ�������˵��
%�� 22 ����� U �ǵ� 20 ����Ĺ��
%�� 23 ����� U �ǵ� 19 ����Ĺ��
%�Դ�����ֱ���� 40 ���档       
        end
    end %if isinteger(n3/2)
%% for 4+ dimensional tensors do not perform the
% the conjugate trick.
else % if la == 3  
    [U, S, V] = takeSVDs(U,S,V,A,faces,parOP);
end

%%

if ~fftOP
    [U S V] = ifft_T(U,S,V);
end

if exist('transflag','var')
    Uold =U;
    % Uold is 400*400*40 complex double    
    U=V; 
% U is 150*150*40 complex double    
    S=tran(S);
% S is 150*400*40  complex double 
    V=Uold;  
% V is 400*400*40 complex double
end


end
