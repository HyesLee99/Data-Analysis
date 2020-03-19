clc; close all; clear all; second = 220500;
%% native speakers of pacific asian vs. western european language 

path_str = ['recordings/recordings/'];
Asian_pacific_str = [path_str,'continent/Asia_pacific'];
Eastern_europe_str = [path_str,'continent/Eastern Europe'];
Western_europe_str = [path_str, 'continent/Western Europe'];
diff_nations_str = [path_str, 'Nationality'];
Asian_pacific_dir = dir(Asian_pacific_str);
Asian_pacific_dir = Asian_pacific_dir(3:end);
song_title = [Asian_pacific_str, '/', Asian_pacific_dir(1).name];
[y,Fs]=audioread(song_title);
time  = 1:length(y);
seconds = time(end)/Fs;
y_sample = y(1:220500);
value = [y_sample];
%playblocking(audioplayer(y,Fs));
%%
for i = 1:length(Asian_pacific_dir)
    song_title = [Asian_pacific_str, '/', Asian_pacific_dir(i).name];
    [y,Fs]=audioread(song_title);
    y_sample = y(1:220500);
    value = [value, y_sample];
end
save Asian_pacific.dat value -ascii;
value = zeros(220500,1);
Eastern_europe_dir = dir(Eastern_europe_str);
Eastern_europe_dir = Eastern_europe_dir(3:end);
for i = 1:length(Eastern_europe_dir)
    song_title = [Eastern_europe_str, '/', Eastern_europe_dir(i).name];
    [y,Fs]=audioread(song_title);
    y_sample = y(1:220500);
    value = [value, y_sample];
end
value = value(:, 2:end);
save Eastern_europe.dat value -ascii;
value = zeros(220500,1);
Western_europe_dir = dir(Western_europe_str);
Western_europe_dir = Western_europe_dir(3:end);
for i = 1:length(Western_europe_dir)
    song_title = [Western_europe_str, '/', Western_europe_dir(i).name];
    [y,Fs]=audioread(song_title);
    y_sample = y(1:220500);
    value = [value, y_sample];
end
value = value(:, 2:end);
save Western_europe.dat value -ascii;
%%
value = zeros(220500,1);
diff_nations_dir = dir(diff_nations_str);
diff_nations_dir = diff_nations_dir(3:end);
for i = 1:length(diff_nations_dir)
    str = [diff_nations_str, '/',diff_nations_dir(i).name, '/'];
    nations = dir(str);
    test = [diff_nations_str,'/',diff_nations_dir(i).name, '/',nations(i).name];
    samples = dir(test);
    samples = samples(3:end);
    for j = 1:length(samples)
        song_title = [diff_nations_str,'/',diff_nations_dir(i).name, '/',nations(i).name,'/', samples(j).name];
        [y,Fs]=audioread(song_title);
        y_sample = y(1:220500);
        value = [value, y_sample];
    end
end
value = value(:, 2:end);
save diff_nations.dat value -ascii;
%% 
%1. Make a frequency and turn into spectrogram using gaussian 
%2. build a matrix and call the svd 
%3. find the singular value energy 
%4. use the singular value to only plot specific things 
%5. Project the value onto those vectors         
%6. Then use the classify & find the statistical value 

%% native language of estern european vs. Eastern european languages 
clear all; close all; clc; 
load Eastern_europe.dat; 
load Western_europe.dat;
%%
v = Eastern_europe(:,1);
t2 = linspace(0,5,length(v));
t = t2(1:length(v));
tslide=0:0.1:5
vgt_spec=[];
n = 220500;
k = (2 * pi / 5) * [0 : n/2-1 -n/2:-1];
ks = fftshift(k);
ks = ks(:,1:end-1);
eastern_europe_spectro = [];
for i = 1:length(Eastern_europe(1,:))
    v = Eastern_europe(:,i);
    v = v';
    vgt_spec=[];
    for j=1:length(tslide)
        g=exp(-10*(t-tslide(j)).^2); % Gabor 
        vg=g.*v; 
        vgt=fft(vg); 
        vgt_spec=[vgt_spec; 
        abs(fftshift(vgt))]; 
        %subplot(3,1,1), plot(t,v,'k',t,g,'r')
        %subplot(3,1,2), plot(t,vg,'k')
        %temp = abs(fftshift(vgt));
        %temp = temp(:,1:end-1);
        %subplot(3,1,3), plot(ks,temp/max(abs(vgt))) 
        %axis([-5 5 0 1])
        %drawnow
        %pause(0.05)
    end
    vgt_spec = vgt_spec';
    temp = vgt_spec(1:end-1,:);
    check = temp(end/2:end,:);
    temp = reshape(check, 110250* 51, 1);
    eastern_europe_spectro = [eastern_europe_spectro temp];
end 
save Ee_parsed.dat eastern_europe_spectro -ascii;

%%
v = Western_europe(:,1);
t2 = linspace(0,5,length(v));
t = t2(1:length(v));
tslide=0:0.1:5
vgt_spec=[];
n = 220500;
k = (2 * pi / 5) * [0 : n/2-1 -n/2:-1];
ks = fftshift(k);
ks = ks(:,1:end-1);
western_europe_spectro = [];
for i = 1:length(Western_europe(1,:))
    v = Western_europe(:,i);
    v = v';
    vgt_spec=[];
    for j=1:length(tslide)
        g=exp(-10*(t-tslide(j)).^2); % Gabor 
        vg=g.*v; 
        vgt=fft(vg); 
        vgt_spec=[vgt_spec; 
        abs(fftshift(vgt))]; 
        %subplot(3,1,1), plot(t,v,'k',t,g,'r')
        %subplot(3,1,2), plot(t,vg,'k')
        %temp = abs(fftshift(vgt));
        %temp = temp(:,1:end-1);
        %subplot(3,1,3), plot(ks,temp/max(abs(vgt))) 
        %axis([-5 5 0 1])
        %drawnow
        %pause(0.05)
    end
    vgt_spec = vgt_spec';
    temp = vgt_spec(1:end-1,:);
    check = temp(end/2:end,:);
    temp = reshape(check, 110250* 51, 1);
    western_europe_spectro = [western_europe_spectro temp];
end 
save We_parsed.dat western_europe_spectro -ascii;
%%
western_europe_spectro = western_europe_spectro(:, 1:50);
eastern_europe_spectro = eastern_europe_spectro(:, 1:50);
%%
load Ee_parsed.dat;
save We_parsed.dat western_europe_spectro -ascii;
%% 
figure(2)
vgt_spec = vgt_spec';
%%
figure(3)
temp = vgt_spec(1:15000,:);

%% Making spectrogram with asian countries accent %%%%%%%%%%%%%%%%%%%%%%5555555
load Asian_pacific.dat;
%%
v = Asian_pacific(:,1);
t2 = linspace(0,5,length(v));
t = t2(1:length(v));
tslide=0:0.1:5
vgt_spec=[];
n = 220500;
k = (2 * pi / 5) * [0 : n/2-1 -n/2:-1];
ks = fftshift(k);
ks = ks(:,1:end-1);
Asian_pacific_spectro = [];
for i = 1:length(Asian_pacific(1,:))
    v = Asian_pacific(:,i);
    v = v';
    vgt_spec=[];
    for j=1:length(tslide)
        g=exp(-10*(t-tslide(j)).^2); % Gabor 
        vg=g.*v; 
        vgt=fft(vg); 
        vgt_spec=[vgt_spec; 
        abs(fftshift(vgt))]; 
        %subplot(3,1,1), plot(t,v,'k',t,g,'r')
        %subplot(3,1,2), plot(t,vg,'k')
        %temp = abs(fftshift(vgt));
        %temp = temp(:,1:end-1);
        %subplot(3,1,3), plot(ks,temp/max(abs(vgt))) 
        %axis([-5 5 0 1])
        %drawnow
        %pause(0.05)
    end
    vgt_spec = vgt_spec';
    temp = vgt_spec(1:end-1,:);
    check = temp(end/2:end,:);
    temp = reshape(check, 110250* 51, 1);
    Asian_pacific_spectro = [Asian_pacific_spectro temp];
end 
save AP_parsed.dat Asian_pacific_spectro -ascii;
%% graphing spectrogram 
check = temp;%(end/2:end,:);
ks_check = ks(:,(end/2):(end/2)+14999);
pcolor(tslide,ks_check,check), 
shading interp 
set(gca,'Ylim',[0 2.5*10^4],'Fontsize',[14]) 
colormap(hot)
title('spectrogram: one eastern1')
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')
%%
figure(3)
pcolor(tslide,ks,temp), 
shading interp 
set(gca,'Ylim',[0 10^4],'Fontsize',[14]) 
colormap(hot)
title('spectrogram: one eastern2')
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')
%%
q1 = randperm(length(eastern_europe_spectro(1,:)));
q2 = randperm(length(western_europe_spectro(1,:)));

x1 = eastern_europe_spectro(:, q1(1:40));
x2 = western_europe_spectro(:, q2(1:40));
%%
x1 = x1(1:500000, :);
x2 = x2(1:500000, :);
western_europe_spectro = western_europe_spectro(1:500000, :);
eastern_europe_spectro = eastern_europe_spectro(1:500000, :);
%%
X = [x1, x2];
[u s v] = svd(X, 'econ');
S = diag(s)
figure(1)
plot(S/sum(S), 'ro', 'LineWidth', [2])
xlabel('Eastern/Western Europe singular values')
ylabel('Singular value energy level')
title('Singular value spectrum for Eastern/Western Europe comparison')
%%
%Eastern = Ee_parsed(:,1:50);
%Western = western_europe_spectro(:, 1:50);
% find the good energy level 
energy = sum(S(1:30))/sum(S);
singular_values = 30;% 87.71%
projected_value = u(:, 1:singular_values)' * [eastern_europe_spectro western_europe_spectro];
xtrain = [projected_value(:, q1(1:40)) projected_value(:, q1(1:40))+50];

c_train = [ones(40,1) ; 2 * ones(40,1)];
true_value = [ones(10,1); 2* ones(10,1)];
cross_validate = [];
past_success = 0;
times = 1000;
for j = 1: times
    q1 = randperm(50);
    q2 = randperm(50);
    past_success = 0;
    xtest = [projected_value(:,q1(41:50)) projected_value(:, q2(41:50)+50)];
    result=classify(xtest', xtrain', c_train);
    indeces = result == true_value;
    success =nnz(indeces) / 20 * 100;
    if past_success < success 
        figure(2)
        bar(classify(xtest', xtrain', c_train))
        past_success = success;
    end
    cross_validate = [cross_validate, success];
end
average_success = sum(cross_validate) / 1000;
figure(3)
hist(cross_validate)
xlabel('Success rate(%)');
ylabel('Number of cases');
title('Success rate distribution: native language of same continent')
pd = fitdist(cross_validate','Normal');
printing = ['The mean of ', num2str(times), 'cross-validation is ', num2str(pd.mu)];
printing2 = ['The std is ', num2str(pd.sigma)];
disp(printing);
disp(printing2);

%% compare japanese / German
c

%% compare japanese / cantonese 
cantonese = Asian_pacific_spectro(:, 1:20);
japanese = Asian_pacific_spectro(:,25:44);

q1 = randperm(length(cantonese(1,:)));
q2 = randperm(length(japanese(1,:)));
x1 = cantonese(:, q1(1:15));
x2 = japanese(:, q2(1:15));
%%
X = [x1, x2];
[u s v] = svd(X, 'econ');
S = diag(s)
figure(1)
plot(S/sum(S), 'ro', 'LineWidth', [2])
xlabel('Japanese/Cantonese singular values')
ylabel('Singular value energy level')
title('Singular value spectrum for Japanese/Cantonese')

energy = sum(S(1:20))/sum(S);
singular_values = 20;% 80.75%
projected_value = u(:, 1:singular_values)' * [cantonese japanese];
xtrain = [projected_value(:, q1(1:15)) projected_value(:, q1(1:15))+20];

c_train = [ones(15,1) ; 2 * ones(15,1)];
true_value = [ones(5,1); 2* ones(5,1)];
cross_validate = [];
past_success = 0;
times = 1000;
%%
xtrain = abs(xtrain(:,:));
for j = 1: times
    q1 = randperm(20);
    q2 = randperm(20);
    past_success = 0;
    xtest = [projected_value(:,q1(16:20)) projected_value(:, q2(16:20)+20)];
    result=classify(xtest', xtrain', c_train);
    indeces = result == true_value;
    success =nnz(indeces) / 10 * 100;
    if past_success < success 
        figure(2)
        bar(classify(xtest', xtrain', c_train))
        past_success = success;
    end
    cross_validate = [cross_validate, success];
end
average_success = sum(cross_validate) / 1000;
figure(3)
hist(cross_validate)
xlabel('Success rate(%)');
ylabel('Number of cases');
title('Success rate distribution: native language of same continent')
pd = fitdist(cross_validate','Normal');
printing = ['The mean of ', num2str(times), 'cross-validation is ', num2str(pd.mu)];
printing2 = ['The std is ', num2str(pd.sigma)];
disp(printing);
disp(printing2);