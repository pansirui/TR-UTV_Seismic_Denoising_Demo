function [S] = proxF_GSM_sparsity_3D_W(y, mu1)

    [m, n, p]     = size(y);  % ��ȡ���� y �ĳߴ�
    
    W              =    20./abs(y);
     
    mu             =    mu1./(W.^2);  
    
    
    theta0        = sqrt(sum(y.^2, 2) / n);  % ����ÿ����Ƭ��theta0���õ� m x 1 x p
    theta0        = repmat(theta0, [1, n, 1]);  % �� theta0 ���Ƶ��������ϣ��õ� m x n x p

    alpha         = y ./ (theta0 + eps);  % �� theta0 ���й㲥���������0
    a             = alpha.^2;
    b             = -2 * alpha .* y;
    c             = 4 * mu;

    tmp1          = -b ./ (4 * a + eps);
    tmp2          = b.^2 ./ (16 * a.^2) - c ./ (2 * a);
    idx           = tmp2 >= 0;
    tmp1(idx == 0) = 0;
    tmp2(idx == 0) = 0;

    t1            = tmp1 + sqrt(tmp2);
    t2            = tmp1 - sqrt(tmp2);

    f0            = c * log(eps);
    f1            = a .* t1.^2 + b .* t1 + c .* log(t1 + eps);
    f2            = a .* t2.^2 + b .* t2 + c .* log(t2 + eps);

    ind           = f2 < f1;
    f1(ind)       = f2(ind);
    t1(ind)       = t2(ind);
    ind           = f0 < f1;
    t1(ind)       = 0;
    theta         = t1;

    aa            = y ./ (theta + eps);
    thr           = 2 * sqrt(2) * mu ./ (theta.^2 + eps);
    alpha         = soft(aa, thr);  % ʹ�� soft ������������ֵ����
    S             = theta .* alpha;
end
