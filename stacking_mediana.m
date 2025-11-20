function Gstack = stacking_mediana(Bstack)
% STACKING_MEDIANA
% Aplica filtro mediano 3x3 a cada imagen binaria b_k y luego hace el
% apilado (stacking) sumando todos los planos filtrados.
%
% ENTRADA:
%   Bstack : arreglo lógico [rows, cols, K] con las imágenes binarias b_k.
%            Normalmente K = L-1 (por ejemplo, 63 si L = 64).
%
% SALIDA:
%   Gstack : imagen en niveles "cuantizados" obtenida como:
%            Gstack(x,y) = sum_k mediana_3x3( b_k(x,y) ).
%
% NOTA:
%   - Cada plano b_k representa la condición I_L(x,y) >= k.
%   - La mediana en binario (0/1) actúa como una operación de "mayoría".
%   - El stacking reconstruye una imagen de niveles de gris
%     que, idealmente, coincide con la mediana directa en I_L.

    % Obtenemos las dimensiones del cubo binario.
    [rows, cols, K] = size(Bstack);

    % Inicializamos la imagen de salida como doble.
    Gstack = zeros(rows, cols);

    % Recorremos todos los planos b_k.
    for k = 1:K
        % Extraemos el plano k-ésimo (imagen binaria).
        Bk = Bstack(:, :, k);      % lógico 0/1

        % Aplicamos filtro mediano 3x3.
        % medfilt2 devolverá double, pero solo con valores 0 ó 1
        % porque la mediana de una ventana impar de píxeles 0/1
        % siempre es 0 ó 1.
        Bk_f = medfilt2(Bk, [3 3]);

        % Acumulamos en la imagen de salida (stacking).
        Gstack = Gstack + double(Bk_f);
    end
end
