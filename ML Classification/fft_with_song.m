function spec_result = fft_with_song(song)
    spec_result = [];
    for i = 1:90
        ft = fft(song(:,i));
        spec = abs(fftshift(ft));
        spec_result = [spec_result spec];
    end
    [m,n] = size(spec_result);
    mn = mean(spec_result,2);
    spec_result = spec_result-repmat(mn,1,n);
end
