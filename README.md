# Práctica 7 — Filtros No Lineales  
## Descomposición por Umbral y Apilación (Stacking)

**Autor:** Fernando Flores López  
**Materia:** Procesamiento de Imágenes  
**Fecha:** Otoño 2025

---

## 📘 Descripción

Esta práctica implementa y compara dos métodos diferentes para aplicar un **filtro mediano 3×3** sobre una imagen en niveles de gris:

1. **Método A — Mediana directa:**  
   Se aplica el filtro mediano sobre la imagen cuantizada \(I_L\) usando `medfilt2`.

2. **Método B — Threshold Decomposition + Stacking:**  
   - Se cuantiza la imagen a **L = 64** niveles (0–63), siguiendo la indicación del profesor en clase.  
   - Se realiza la **descomposición por umbral**, generando 63 imágenes binarias \(b_k\).  
   - A cada plano binario se le aplica también un filtro mediano 3×3.  
   - Finalmente, se reconstruye la imagen sumando todos los planos filtrados (**stacking**).

La práctica revisa experimentalmente si ambos métodos producen **el mismo resultado**.

---

## 🎯 Objetivo

- Implementar la descomposición por umbral y la técnica de stacking.  
- Aplicar el filtro mediano de forma directa y mediante stacking.  
- Comparar ambos resultados usando:
  - **MSE (Mean Squared Error)**  
  - **Conteo de píxeles distintos**  
- Visualizar las imágenes de salida y la imagen de error.

---

## 📂 Estructura de archivos

