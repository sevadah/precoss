function Y_out = compress_signal(Y_in, compression_factor )

    % get dimensions of the signal
    % typically the Y is organized in columns

    [N, L] = size(Y_in);

    newL = floor(L/compression_factor);
    v = 1 : 1 : L;
    vq = L/newL : L/newL : L;

    for i = 1 : N
        Y_out(i, :) = interp1(v, Y_in(i, :), vq);
    end

end
