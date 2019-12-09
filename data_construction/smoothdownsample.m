function y = smoothdownsample(x,n)
%y = smoothdownsample(x,n) is like y = downsample( smooth(x,n), n)
%but much faster
%runs over lines (dim 2)

L = ceil(size(x,2)/n);
y = nan(size(x,1), L);
for i=1:L-1,
    y(:,i) = sum( x(:, (i-1)*n+(1:n)), 2);
end
y = y/n;

y(:,L) = mean( x(:, (L-1)*n+1:end ), 2);
