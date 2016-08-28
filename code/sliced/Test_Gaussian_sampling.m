% script : compare la densit� estim�e � partir d'un nuage de point al�atoire gaussien
% et un nuage de point uniforme param�tr� en coordonn�es polaire

clear all, close all, clc

n = 100;
n2 = n^2; % number of points generated

%% m�thode 1 : al�atoire gaussien � partir de deux variables al�atoires ind�pendantes et uniformes

U = rand(n2,1);
V = rand(n2,1);
X1 = sqrt(-2*log(U)).*cos(2*pi*V);
Y1 = sqrt(-2*log(U)).*sin(2*pi*V);

figure, 
subplot(2,2,1), plot(X1,Y1,'b.'), axis equal, axis off, title('with randn()')

%% m�thode 2 : param�trisation uniforme et polaire d'une gaussienne
u = linspace(1e-2,1,n);
[J,I] = meshgrid(u,u);

I = I(:);
J = J(:);

X2 = sqrt(-2*log(J)).*cos(2*pi*I);
Y2 = sqrt(-2*log(J)).*sin(2*pi*I);

subplot(2,2,2), plot(X2,Y2,'r.'), axis equal, axis off, title('with polar rand()')


%% comparaison des densit�s
N = 1e3; % taille en pixel 
s = N*1/100;

d1 = 255 - uint8( density_estimate([X1';Y1'],N,s) * 255);
d2 = 255 - uint8( density_estimate([X2';Y2'],N,s) * 255);

subplot(2,2,3), imagesc(d1), colormap jet, axis equal, axis off, % colorbar
subplot(2,2,4), imagesc(d2), colormap jet, axis equal, axis off, % colorbar
