clc; close all; clear all;
tr_piano=16; % record time in seconds
[y,Fs] = audioread('music1.wav'); 
Fs=length(y)/tr_piano;
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); 
ylabel('Amplitude');
title('Mary had a little lamb (piano)'); drawnow
%p8 = audioplayer(y,Fs); playblocking(p8);

figure(2)

v = y'/2;
time = 1: length(v);
L = time(end)/Fs; % seconds 
n = time(end);
k = (2 * pi / L) * [0 : n/2-1 -n/2:-1];
ks = fftshift(k);
ks = ks(:,1:end-1);
t2 = linspace(0,L,n+1);
t = t2(1:n);
vt=fft(v);
plot(abs(fftshift(vt))); % plotting in frequency domain 
xlabel('time (seconds)')
ylabel('FFT')
title('Fourier domain: Mary had a little lamb (piano)')




%%
figure(4)
vgt_spec=[]; 
tslide=0:0.1:L;
for j=1:length(tslide)
    g=200*exp(-5*(t-tslide(j)).^2); % Gabor 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec=[vgt_spec; 
    abs(fftshift(vgt))]; 
end
%%
figure(5)
ks = ks(:,1:end/2-1);
%vgt_spec = vgt_spec';
temp = vgt_spec(1:end,1:end-1);
temp2 = log(temp);

%%
subplot(3, 1, 1);
temp = vgt_spec(:,1:end-1);
%%
pcolor(tslide, ks, temp.');
caxis([0 800])
shading interp
colormap(hot);
set(gca,'Ylim',[-1000, 0]);
title('With Overtones','fontsize',11, 'fontweight', 'normal');
%%
% 
tau = 0.1;
n = size(vgt_spec, 1);
center = zeros(1, n);
for j = 1:n
    vgt_window = vgt_spec(j, :); 
    [fmax, idx] = max(abs(vgt_window)); 
    center(j) = ks(idx); 
end
overtones_removed = zeros(size(vgt_spec)); 
for j = 1:length(center)
    vgt_window = vgt(j, :);
    filter = exp(-tau*((ks-abs(center(j))).^2)) + exp(-tau*((ks-center(j)).^2));
    overtones_removed(j, :) = filter.*vgt_window;
end
save('c_freqs_p');

subplot(3, 1, 2);
pcolor(tau_vec, ks, overtones_removed.');
shading interp
colormap(hot);
set(gca, 'Ylim', [-1000 1000]);
title('No Overtones', 'fontsize', 11, 'fontweight', 'normal');
ylabel('Frequency (Hz)', 'fontsize', 11);

% zooms in on the spectrogram without overtones to more clearly 
% see the music score produced by the piano
subplot(3, 1, 3);
pcolor(tau_vec, ks, overtones_removed.');
shading interp
colormap(hot);
set(gca, 'Ylim', [200 350]);
title('No Overtones (Zoomed)', 'fontsize', 11, 'fontweight', 'normal');
xlabel('Time (sec)', 'fontsize', 11);
%%
pcolor(tslide,ks, temp2'), 
shading interp 
set(gca,'Ylim',[-2.5*10^4  2.5*10^4],'Fontsize',[14]) 
colormap(hot)
title('spectrogram:piano (Logged)')
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')

%  playblocking(p8);

%%
figure(2)
tr_rec=14; % record time in seconds
[y,Fs]=audioread('music2.wav'); 
Fs=length(y)/tr_rec;
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); 
ylabel('Amplitude');
title('Mary had a little lamb (recorder)');
%p8 = audioplayer(y,Fs); playblocking(p8);

figure(2)

v = y'/2;
time = 1: length(v);
L = time(end)/Fs; % seconds 
n = time(end);
k = (2 * pi / L) * [0 : n/2-1 -n/2:-1];
ks = fftshift(k);
ks = ks(:,1:end-1);
t2 = linspace(0,L,n+1);
t = t2(1:n);
vt=fft(v);
plot(abs(fftshift(vt))); % plotting in frequency domain 
xlabel('time (seconds)')
ylabel('FFT')
title('Fourier domain: Mary had a little lamb (recorder)')

%%
figure(4)
vgt_spec=[]; 
tslide=0:0.1:L
for j=1:length(tslide)
    g=exp(-1*(t-tslide(j)).^2); % Gabor 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec=[vgt_spec; 
    abs(fftshift(vgt))]; 
    subplot(3,1,1), plot(t,v,'k',t,g,'r')
    subplot(3,1,2), plot(t,vg,'k')
    temp = abs(fftshift(vgt));
    temp = temp(:,1:end-1);
    subplot(3,1,3), plot(ks,temp/max(abs(vgt))) 
    axis([-5 5 0 1])
    drawnow
    pause(0.05)
end

figure(5)
vgt_spec = vgt_spec';
temp = vgt_spec(1:end-1,:);
pcolor(tslide,ks,temp), 
shading interp 
set(gca,'Ylim',[-2.5*10^4 2.5*10^4],'Fontsize',[14]) 
colormap(hot)
title('spectrogram: recorder')
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')

 