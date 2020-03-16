
load handel
v = y'/2;
time = 1: length(v);
plot(time/Fs,v);
xlabel('Time [sec]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');
p8 = audioplayer(v,Fs);
L = time(end)/Fs; % seconds 
n = time(end);
k = (2 * pi / L) * [0 : n/2-1 -n/2:-1];
ks = fftshift(k);
t2 = linspace(0,L,n+1);
t = t2(1:n);
vt=fft(v);
plot(abs(fftshift(vt))); % plotting in frequency domain 

playblocking(p8);
%% Gabor window 

figure(2) 
width=[10 1 0.2]; 
for j=1:3
    g=exp(-width(j)*(t-4).^2); 
    subplot(3,1,j)
    plot(time,v,'k'), hold on 
    plot(time,g,'r','Linewidth',[2]) 
    set(gca,'Fontsize',[14]) 
    ylabel('S(t), g(t)')
end
xlabel('time (t)')
% 2pi frequency == radian frequency 


%vt = fft(v);

%Playing the music
%playblocking(p8);
%%  GABOR TRANSFORM

figure(3) 
g=exp(-2*(t-6).^2); 
vg=g.*v; vgt=fft(vg);
vgt = vgt(:,1:end-1);

subplot(3,1,1), plot(t,v,'k'), hold on 
plot(t,g,'r','Linewidth',[2]) 
set(gca,'Fontsize',[14])
ylabel('S(t), g(t)'), xlabel('time (t)')

subplot(3,1,2), plot(t,vg,'k') 
set(gca,'Fontsize',[14]) 
ylabel('S(t)g(t)'), xlabel('time (t)')

subplot(3,1,3), plot(ks,abs(fftshift(vgt))/max(abs(vgt)),'k') 
axis([-50 50 0 1])
set(gca,'Fontsize',[14])
ylabel('FFT(Sg)'), xlabel('frequency (\omega)')
%% SLIDING GABOR WINDOW Gaussian 

figure(4)
vgt_spec=[]; 
tslide=0:0.1:10
for j=1:length(tslide)
    g=exp(-200*(t-tslide(j)).^2); % Gabor 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec=[vgt_spec; 
    abs(fftshift(vgt))]; 
end
%%
figure(5)
vgt_spec = vgt_spec';
temp = vgt_spec(1:end-1,:);
pcolor(tslide,ks,temp), 
shading interp 
set(gca,'Ylim',[-2.5*10^4 2.5*10^4],'Fontsize',[14]) 
colormap(hot)
%title('spectrogram: Guassian filter (5 samples)')
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')
title('spectrogram: Gaussian wavelet - shorter width')

%%
% Plot the fourier transformed version 
val = abs(fftshift(vt));
absval = abs(vt);
plot(ks,abs(fftshift(vt)) / abs(vt), 'k');
axis([-50 50 0 1])

%% Gabor window------------Step function/Haar wavelemt 

figure(2) 
width=[10 1 0.2]; 
for j=1:3
    g=exp(-width(j)*(t-4).^2); 
    subplot(3,1,j)
    plot(time,v,'k'), hold on 
    plot(time,g,'r','Linewidth',[2]) 
    set(gca,'Fontsize',[14]) 
    ylabel('S(t), g(t)')
end
xlabel('time (t)')
% 2pi frequency == radian frequency 


%vt = fft(v);

%Playing the music
%playblocking(p8);
%%  GABOR TRANSFORM

figure(3) 
g=exp(-2*(t-6).^2); 
vg=g.*v; vgt=fft(vg);
vgt = vgt(:,1:end-1);

subplot(3,1,1), plot(t,v,'k'), hold on 
plot(t,g,'r','Linewidth',[2]) 
set(gca,'Fontsize',[14])
ylabel('S(t), g(t)'), xlabel('time (t)')

subplot(3,1,2), plot(t,vg,'k') 
set(gca,'Fontsize',[14]) 
ylabel('S(t)g(t)'), xlabel('time (t)')

subplot(3,1,3), plot(ks,abs(fftshift(vgt))/max(abs(vgt)),'k') 
axis([-50 50 0 1])
set(gca,'Fontsize',[14])
ylabel('FFT(Sg)'), xlabel('frequency (\omega)')
%% SLIDING GABOR WINDOW Gaussian 

figure(4)
vgt_spec=[]; 
tslide=0:0.1:10
for j=1:length(tslide)
    g=exp(-200*(t-tslide(j)).^2); 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec=[vgt_spec; 
    abs(fftshift(vgt))]; 
end
%%
figure(5)
vgt_spec = vgt_spec';
temp = vgt_spec(1:end-1,:);
pcolor(tslide,ks,temp), 
shading interp 
set(gca,'Ylim',[-2.5*10^4 2.5*10^4],'Fontsize',[14]) 
colormap(hot)
title('spectrogram: Haar wavelet (width:1)')
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')
%% Gabor window ----------------Mexican Hat Wavelet 

figure(2) 
width=[1.4 0.8 0.2]; 
for j=1:3
    g=(1-((t-4)./width(j)).^2).* exp(-(((t-4)./width(j)).^2)/2); 
    subplot(3,1,j)
    plot(time,v,'k'), hold on 
    plot(time,g,'r','Linewidth',[2]) 
    set(gca,'Fontsize',[14]) 
    ylabel('S(t), g(t)')
    title(['Bandwidth of ', num2str(width(j))])
end
xlabel('time (t)')

% 2pi frequency == radian frequency 

%Playing the music
%playblocking(p8);
%%  GABOR TRANSFORM ------------Mexican Hat wavelet 

figure(3) 
g=(1-((t-4)./0.2).^2).* exp(-(((t-4)./0.2).^2)/2); 
vg=g.*v; 
vgt=fft(vg);
vgt = vgt(:,1:end-1);

subplot(3,1,1), plot(t,v,'k'), hold on 
plot(t,g,'r','Linewidth',[2]) 
set(gca,'Fontsize',[11])
ylabel('Frequency (Hz)'), xlabel('time (sec)')
legend('Music signal', 'Wavelet')
title('Time-frequency space')

subplot(3,1,2), plot(t,vg,'k') 
set(gca,'Fontsize',[11]) 
ylabel('Frequency (Hz)'), xlabel('time (sec)')
legend('Music signal')
title('Time-frequency space: mutiplied wavelet')

subplot(3,1,3), plot(ks,abs(fftshift(vgt))/max(abs(vgt)),'k') 
axis([-50 50 0 1])
set(gca,'Fontsize',[11])
ylabel('FFT'), xlabel('frequency (\omega)')
legend('Music signal')
title('Fourier space')
%% SLIDING GABOR WINDOW Gaussian 

figure(4)
vgt_spec=[]; 
tslide=0:0.1:10
bandwidth = 200;
for j=1:length(tslide)
    % mexican hat 
    g=(1-((t-tslide(j)).*bandwidth).^2).* exp(-(((t-tslide(j)).*bandwidth).^2)/2); 
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
    pause(0.1)
end
%%
figure(5)
vgt_spec = vgt_spec';
temp = vgt_spec(1:end-1,:);
pcolor(tslide,ks,temp), 
shading interp 
set(gca,'Ylim',[-2.5*10^4 2.5*10^4],'Fontsize',[14]) 
colormap(hot)
title(['spectrogram: Mexican hat wavelet filter'])
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')

%% Gabor window ----------------Step function

figure(2) 
width=[1.4 0.8 0.2]; 
for j=1:3
    g=width(j) * abs(t-4) <= 0.5;
    subplot(3,1,j)
    plot(time,v,'k'), hold on 
    plot(time,g,'r','Linewidth',[2]) 
    set(gca,'Fontsize',[14]) 
    ylabel('S(t), g(t)')
    title(['Bandwidth of ', num2str(width(j))])
end
xlabel('time (t)')

% 2pi frequency == radian frequency 

%Playing the music
%playblocking(p8);
%%  GABOR TRANSFORM ------------Mexican Hat wavelet 

figure(3) 
g=1 * abs(t-4) <= 0.5;
vg=g.*v; 
vgt=fft(vg);
vgt = vgt(:,1:end-1);

subplot(3,1,1), plot(t,v,'k'), hold on 
plot(t,g,'r','Linewidth',[2]) 
set(gca,'Fontsize',[11])
ylabel('Frequency (Hz)'), xlabel('time (sec)')
legend('Music signal', 'Wavelet')
title('Time-frequency space')

subplot(3,1,2), plot(t,vg,'k') 
set(gca,'Fontsize',[11]) 
ylabel('Frequency (Hz)'), xlabel('time (sec)')
legend('Music signal')
title('Time-frequency space: mutiplied wavelet')

subplot(3,1,3), plot(ks,abs(fftshift(vgt))/max(abs(vgt)),'k') 
axis([-50 50 0 0.2])
set(gca,'Fontsize',[11])
ylabel('FFT'), xlabel('frequency (\omega)')
legend('Music signal')
title('Fourier space')
%% SLIDING GABOR WINDOW Gaussian 

figure(4)
vgt_spec=[]; 
tslide=0:0.1:10
bandwidth = 200;
for j=1:length(tslide)
    % mexican hat 
    g=bandwidth * abs(t-tslide(j)) <= 0.5;
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec=[vgt_spec; 
    abs(fftshift(vgt))]; 
    
end
%%
figure(5)
vgt_spec = vgt_spec';
temp = vgt_spec(1:end/2-1,:);
pcolor(tslide,ks,temp), 
shading interp 
set(gca,'Ylim',[-2.5*10^4 2.5*10^4],'Fontsize',[14]) 
colormap(hot)
title(['spectrogram: step-function wavelet filter'])
xlabel('Time location (sec)')
ylabel('Frequency location (Hz)')
