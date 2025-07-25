function [U, S, V] = takeSVDs(U,S,V,A,endI,runPar)

if ~exist('runPar','var')
    runPar = false;
end
    
if ~runPar || parpool('size') == 0

    for i=1:endI
        [U1,S1,V1]=svd(A(:,:,i));

        U(:,:,i)=U1; S(:,:,i)=S1; V(:,:,i)=V1;
    end
else
    
    parfor i=1:endI
        [U1,S1,V1]=svd(A(:,:,i));
        U(:,:,i)=U1; S(:,:,i)=S1; V(:,:,i)=V1;
    end
end

end