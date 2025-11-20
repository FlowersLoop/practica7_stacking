%% P7 - Stacking: Parte 1
% Lectura de imagen, conversión a gris y cuantización a L niveles.
% Ernesto Armando Gaytán Brieño y Fernando Flores López
% Fecha: 20 de noviembre de 2025

clear; close all; clc; 

%% 1) Parámetros generales
L = 64;          % Número de niveles de gris deseados (64 en vez de 256)

%% 2) Lectura de la imagen
% Imagen que no sea mayor a 640x480.
nombreImagen = 'blackmidi.png'; 

I = imread(nombreImagen);         % Lee la imagen desde disco (RGB o gris).
% imshow(I)

% Si la imagen es de color (3 canales), la convertimos a niveles de gris.
if size(I, 3) == 3
    % rgb2gray hace una combinación ponderada de R, G y B.
    Igray = rgb2gray(I);
else
    % Si ya viene en gris (1 canal), solo la copiamos.
    Igray = I;
end

% Convertimos a double para operar cómodamente (valor en [0,255]).
Igray = double(Igray);

%% 3) Cuantización de 256 niveles a L niveles
% De 0..255 a 0..(L-1).
% El tamaño del escalón de cuantización es:
delta = 256 / L;         % Ancho de cada nivel de cuantización.

% Aplicamos cuantización uniforme:
% I_L = floor( Igray / delta ) produce valores enteros en 0..(L-1).
I_L = floor(Igray / delta);   % Ahora I_L toma valores enteros entre 0 y L-1.

% Aseguramos de que nunca se pase de L-1.
I_L(I_L < 0)     = 0;
I_L(I_L > L - 1) = L - 1;

%% 4) Visualización básica
figure;
subplot(2,2,1);
imshow(uint8(Igray));        % Imagen original en gris (0..255).
title('Imagen original en gris (0-255)');

subplot(2,2,2);
imshow(uint8(I_L * (256/L))); 
% Multiplicamos por (256/L) solo para visualizarla "bien" en rango visual.
title(sprintf('Imagen cuantizada a L = %d niveles', L));

subplot(2,2,3);
imhist(uint8(Igray));
title('Histograma original (0-255)');

subplot(2,2,4);
imhist(uint8(I_L * (256/L)));
title(sprintf('Histograma cuantizado (L = %d)', L));

sgtitle('P7 - Parte 1: Lectura y cuantización de la imagen');

%% 5) Descomposición por umbral
% Llamamos a la función que genera las imágenes binarias b_k:
%   Bstack(:,:,k) = b_k = (I_L >= k),  para k = 1..L-1.
Bstack = umbral_descomposicion(I_L, L);   % Dimensiones -> Bstack es [rows x cols x (L-1)]

% Visualizamos tres planos:
%   k = 1   -> casi todo "encendido".
%   k = L/2 -> intensidades medias y altas.
%   k = L-1 -> solo los pixeles más brillantes.
k1   = 1;
kmed = L/2;
kmax = L-1;

figure;
subplot(1,3,1);
imshow(Bstack(:,:,k1));
title(sprintf('b_{%d}: I_L >= %d', k1, k1));

subplot(1,3,2);
imshow(Bstack(:,:,kmed));
title(sprintf('b_{%d}: I_L >= %d', kmed, kmed));

subplot(1,3,3);
imshow(Bstack(:,:,kmax));
title(sprintf('b_{%d}: I_L >= %d', kmax, kmax));

sgtitle('Ejemplos de imágenes binarias b_k (descomposición por umbral)');

%% 6) Filtrado mediano directo en niveles de gris
% Aplicamos un filtro mediano 3x3 directamente a la imagen cuantizada I_L.
GA = medfilt2(I_L, [3 3]);   % GA = "Gray Median Direct"

%% 7) Filtrado vía descomposición + stacking (CAMINO B)
    %   1) Descomposición: ya tenemos Bstack(:,:,k) = b_k.
    %   2) A cada b_k le aplicamos el filtro mediano 3x3.
    %   3) Sumamos todos los planos filtrados -> Gstack.
Gstack = stacking_mediana(Bstack);  % GB = "Gray via Binary Stacking"

%% 8) Comparación cuantitativa entre GA y Gstack
% Calculamos la imagen de diferencia absoluta.
diffImg = abs(GA - Gstack);

% MSE (Error cuadrático medio).
MSE = mean(diffImg(:).^2);

% Número de píxeles distintos (donde GA ~= Gstack).
num_diff = nnz(diffImg);   % nnz = "number of non-zeros"

fprintf('Comparación GA vs Gstack:\n');
fprintf('  MSE            = %.6f\n', MSE);
fprintf('  Pixeles distintos = %d\n', num_diff);

%% 9) Visualización comparativa
% Para visualizar GA y Gstack en rango 0..255, los re-escalamos multiplicando por delta.
% MATLAB interpreta imshow en uint8 (valores de 0 a 255)
GA_vis     = uint8(GA * (256 / L));
Gstack_vis = uint8(Gstack * (256 / L));

% Para la imagen de error, también usamos escala similar para notar diferencias.
diff_vis   = uint8(diffImg * (256 / L));   

figure;
subplot(1,3,1);
imshow(GA_vis);
title('GA: Mediana directa sobre I\_L');

subplot(1,3,2);
imshow(Gstack_vis);
title('Gstack: Mediana vía Stacking');

subplot(1,3,3);
imshow(diff_vis, []);
title('|GA - Gstack| (imagen de error)');

sgtitle('P7 - Comparación Mediana Directa vs. Mediana por Stacking');