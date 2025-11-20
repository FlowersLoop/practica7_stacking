# P7 - Stacking de Imágenes Binarias

**Procesamiento Digital de Imágenes**  
*Ernesto Armando Gaytán Brieño y Fernando Flores López*  
*Fecha: 20 de noviembre de 2025*

---

## Descripción

Este proyecto implementa y compara dos métodos para aplicar el **filtro de mediana** a imágenes en escala de grises:

1. **Método Directo**: Aplicación del filtro mediano directamente sobre la imagen cuantizada
2. **Método de Stacking**: Descomposición por umbrales → Filtrado binario → Reconstrucción por apilamiento

### Características

-  Cuantización de imágenes de 256 a L niveles (configurable)
-  Descomposición por umbral en imágenes binarias
-  Filtrado mediano 3×3 sobre planos binarios
-  Comparación cuantitativa (MSE y píxeles diferentes)
-  Visualizaciones comparativas completas

---

## Estructura del Proyecto
```
  P7-Stacking/
├──   P7_stacking_main.m          # Script principal
├──   umbral_descomposicion.m     # Descomposición por umbral
├──   stacking_mediana.m          # Filtrado y apilamiento
├──   blackmidi.png               # Imagen de ejemplo
└──   README.md                    
```

---

## Uso

### Ejecución Principal
```matlab
% Ejecutar el script principal
P7_stacking_main
```

### Parámetros Configurables
```matlab
L = 64;                    % Número de niveles de gris (2-256)
nombreImagen = 'tu_imagen.png';  % Imagen a procesar (máx 640×480)
```

---

## Metodología

### 1. Cuantización

La imagen original (256 niveles) se reduce a **L niveles**:
```matlab
delta = 256 / L;
I_L = floor(Igray / delta);  % Valores en [0, L-1]
```

### 2. Descomposición por Umbral

Se generan **L-1 imágenes binarias** donde:
```
b_k(x,y) = 1  si  I_L(x,y) ≥ k
b_k(x,y) = 0  en otro caso
```

### 3. Filtrado y Stacking

Cada plano binario se filtra con mediana 3×3 y se suman todos los resultados:
```
Gstack(x,y) = Σ mediana_3×3(b_k(x,y))
              k=1 to L-1
```

---

## Resultados

El programa genera **3 figuras**:

### Figura 1: Cuantización
- Imagen original vs cuantizada
- Histogramas comparativos

### Figura 2: Planos Binarios
- Ejemplos de descomposición por umbral (k=1, k=L/2, k=L-1)

### Figura 3: Comparación de Métodos
- **GA**: Mediana directa
- **Gstack**: Mediana por stacking
- **Diferencia absoluta**: Error visual

### Métricas Cuantitativas
```
Comparación GA vs Gstack:
  MSE             = 0.XXXXXX
  Píxeles distintos = XXXX
```

---

## 🔧 Funciones Auxiliares

### `umbral_descomposicion(I_L, L)`

**Entrada:**
- `I_L`: Imagen cuantizada [0, L-1]
- `L`: Número de niveles

**Salida:**
- `Bstack`: Arreglo lógico [rows × cols × (L-1)]

---

### `stacking_mediana(Bstack)`

**Entrada:**
- `Bstack`: Planos binarios [rows × cols × K]

**Salida:**
- `Gstack`: Imagen reconstruida por suma de medianas

---

## Fundamentos Teóricos

### Filtro de Mediana

El filtro de mediana es **no lineal** y efectivo para eliminar ruido sal y pimienta manteniendo bordes.

### Propiedad de Umbral-Superposición
```
mediana{I_L} = Σ umbral_k{mediana{I_L ≥ k}}
                k=1 to L-1
```

Esta propiedad permite que el **método de stacking reproduzca exactamente** el resultado del filtro mediano directo (en teoría).

---

## Requisitos

- MATLAB R2016b o superior
- Image Processing Toolbox
- Imagen de entrada ≤ 640×480 píxeles

---

## Ejemplos de Uso

### Cambiar nivel de cuantización
```matlab
L = 32;   % Menos niveles = más agresiva cuantización
L = 128;  % Más niveles = mayor fidelidad
```

### Procesar diferentes imágenes
```matlab
nombreImagen = 'lena.png';
nombreImagen = 'cameraman.tif';
nombreImagen = 'tu_foto.jpg';
```

---

## Preguntas Clave

1. **¿Por qué GA y Gstack son casi idénticos?**  
   Por la propiedad matemática del filtro mediano con descomposición por umbral.

2. **¿Cuándo difieren?**  
   Efectos de borde o redondeo numérico pueden causar pequeñas diferencias.

3. **¿Ventajas del stacking?**  
   - Procesamiento paralelo de planos binarios
   - Operaciones más simples (solo 0s y 1s)
   - Base teórica para filtros morfológicos

---

## Notas Importantes

-  Las imágenes se visualizan reescaladas a [0, 255] para mejor apreciación
-  El MSE cercano a cero confirma la equivalencia teórica
-  Para imágenes grandes, el método directo es más eficiente computacionalmente
-  L=64 es un buen balance entre calidad y costo computacional

---

## Autores

- **Ernesto Armando Gaytán Brieño**
- **Fernando Flores López**

---

## Licencia

Este proyecto fue desarrollado con fines académicos para la materia de **Procesamiento Digital de Imágenes**.

---

<div align="center">

** Si te sirvió este proyecto, considera darle una estrella **

*Hecho con 💙 y MATLAB*

</div>
