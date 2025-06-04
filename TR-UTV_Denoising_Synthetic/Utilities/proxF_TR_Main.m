function [X] = proxF_TR_Main(Y, tau, alpha, par)

r = par.r;  % TR-rank
maxiter = par.maxiter;  % iteration numbers of sovling each core tensor G_i

N = ndims(Y);  % N = 3
S = size(Y);
G = TR_initcoreten(S,r);  

iter = 0;
while iter < maxiter
      iter = iter+1;
      for n = 1:N
      Q = tenmat_sb(Z_neq(G,n),2);  
      Q=Q'; 
	  G{n} = Gfold((alpha*tenmat_sb(Y,n)*Q'+2*tau*Gunfold(G{n},2))/((alpha*(Q*Q')...
            +2*tau*eye(size(Q,1),size(Q,1)))),size(G{n}),2);
      end
end

X = coreten2tr(G);

end

