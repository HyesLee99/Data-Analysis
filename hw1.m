clear all; close all; clc;
load Testdata

L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); 
x=x2(1:n); y=x; z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; % frequency components of FFT 
ks=fftshift(k);% unshifted counter parts 

[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);
total = zeros(n,n,n);

% finding filter by taking average 
for j=1:20
    Un(:,:,:)=reshape(Undata(j,:),n,n,n); 
    total = total+fftn(Un);
end
signal = abs(fftshift(total))/20;

[val,idx] = max(abs(signal(:)));
[fx,fy,fz] = ind2sub([64,64,64], idx);
kx = ks(fx); % fourier domain filter frequency placement
ky = ks(fy); % fourier domain filter frequency placement
kz = ks(fz); % fourier domain filter frequency placement
tau = 2; % bandwidth
filter = exp(-tau*((Kx - ky).^2+(Ky - kx).^2+(Kz - kz).^2));
layer = [0,0,0];

for j = 1:20
    % filtering data in frequency domain.
    Un(:,:,:)=reshape(Undata(j,:),n,n,n);
    Unt = fftshift(fftn(Un));
    Untf = filter .* Unt;
    Untfp = ifftn(ifftshift(Untf));
    figure(1);
    isosurface(X,Y,Z,abs(Untfp)./max(abs(Untfp(:))),0.8)
    title('Marble trajectory');
    xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
    axis([-20 20 -20 20 -20 20]), grid on, drawnow
    hold on
    [val,indx] = max(abs(Untfp(:)));
    [yidx, xidx, zidx] = ind2sub([n,n,n], indx);
    x = Y(xidx,yidx, zidx); 
    y = X(xidx,yidx, zidx);
    z = Z(xidx,yidx, zidx);
    layer = [layer; [x y z]];
end

figure(2);
layer = layer(2:end, :);
plot3(layer(:,1),layer(:,2),layer(:,3),'--ko');
axis([-20 20 -20 20 -20 20]), grid on
title('Marble trajectory');
xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');