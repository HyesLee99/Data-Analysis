function result = preprocessing(name_of_audio)
    [y, Fs] = audioread(name_of_audio);
    y = mean(y,2);
    [m,n]=size(y);
    dt = 1/Fs;
    t = dt*(0:m-1);
    temp = max(t)/5;
    rounded_number = floor(temp);
    t1 = 0;
    t2 = 5;
    idx = (t>=t1) & (t<t2);
    result = y(idx);
    for i = 2:rounded_number
        t1 = t1 + 5;
        t2 = t2 + 5;
        idx = (t>=t1) & (t<t2);
        result = [result y(idx)];
    end
end
