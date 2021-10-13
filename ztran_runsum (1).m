
function runsum = ztran_runsum(n)
    z = tf('z');
    fil=[ones(1,n)];
    sum=1;
    for i=1:n
        sum=sum+fil(i)*z^(-(i));
    end 
    runsum=minreal(sum); 
end 




