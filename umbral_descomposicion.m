function Bstack = umbral_descomposicion(I_L, L)
% UM BRAL_DESCOMPOSICION
% Realiza la descomposición por umbral de una imagen cuantizada I_L.
%
% ENTRADAS:
%   I_L : imagen de niveles de gris cuantizada en enteros 0..L-1 (tipo double o uint8).
%   L   : número de niveles de gris (por ejemplo, L = 64).
%
% SALIDA:
%   Bstack : arreglo lógico de tamaño [rows, cols, L-1]
%            donde Bstack(:,:,k) corresponde a la imagen binaria b_k,
%            definida como: b_k(x,y) = 1 si I_L(x,y) >= k, 0 en otro caso.
%
% Esta función implementa:
%   b_k(x,y) = (I_L(x,y) >= k),   para k = 1, 2, ..., L-1.
%
% NOTA:
%   Usamos tipo lógico (true/false) para ahorrar memoria y dejar claro
%   que son imágenes binarias.

    % Aseguramos que la imagen sea double (para comparaciones limpias).
    I_L = double(I_L);

    % Dimensiones de la imagen.
    [rows, cols] = size(I_L);

    % Pre-asignación del "cubo" de imágenes binarias.
    % Tendremos L-1 planos: k = 1..L-1.
    Bstack = false(rows, cols, L-1);

    % Recorremos todos los niveles de umbral k.
    for k = 1:(L-1)
        % Imagen binaria para el umbral k:
        % b_k(x,y) = 1 si I_L(x,y) >= k, 0 si no.
        Bstack(:, :, k) = (I_L >= k);
    end
end
