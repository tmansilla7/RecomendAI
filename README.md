# RecomendAI 

## 📌 Descripción general

El objetivo del trabajo fue **diseñar y modelar la base de datos** de una aplicación de
recomendaciones basada en **inteligencia artificial generativa**, capaz de sugerir contenidos
multiformato teniendo en cuenta el **perfil del usuario**, su **historial de uso**, sus
**emociones** y el **feedback acumulado de todos los usuarios**.

El alcance del proyecto abarca el **modelo conceptual, lógico y físico**, junto con consultas
SQL representativas del dominio.

---

## 🎯 Objetivo del sistema

Diseñar un **modelo de datos robusto y escalable** que permita:

- Gestionar un catálogo amplio de contenidos (películas, libros, canciones, juegos, etc.)
- Almacenar perfiles de usuarios y sus preferencias
- Registrar recomendaciones y el contexto emocional de cada interacción
- Guardar el consumo real de contenidos y la opinión del usuario
- Facilitar el análisis de datos para la IA de recomendaciones

---

## 👥 Trabajo en equipo

El trabajo fue realizado en grupo (hasta 5 integrantes), con evaluación **individual y grupal**,
y defensa del modelo ante los docentes.

---

## 🛠️ Tecnologías y herramientas utilizadas

- **Modelado DER** (draw.io)
- **Modelo Relacional**
- **MySQL**
- **SQL (DDL + DML)**
- Scripts SQL para consultas, vistas y carga de datos

---

## 🧠 Diseño del modelo de datos

### Enfoque general

El modelo fue diseñado priorizando:

- **Normalización**
- **Claridad semántica**
- **Escalabilidad**
- **Trazabilidad del historial de recomendaciones**
- **Flexibilidad para nuevos formatos y características**

Se contemplan relaciones **muchos a muchos**, uso de **entidades intermedias** y
atributos derivados cuando corresponde.

---

## 📚 Contenidos

El sistema permite almacenar un catálogo amplio de contenidos de distintos formatos, cada uno
con su **ficha técnica completa**, incluyendo:

- Título
- Formato
- Duración / tiempo estimado
- Año de publicación
- Origen
- Géneros
- Temáticas
- Participantes y roles (actor, director, autor, entrevistado, etc.)
- Contenidos relacionados (sagas, secuelas, adaptaciones, etc.)

---

## 😊 Emociones y características

El modelo contempla:

- Emociones y sensaciones del usuario detectadas durante la recomendación
- Características de los contenidos (divertido, conmovedor, atrapante, etc.)
- Puntuación de cada característica de 1 a 10
- Registro de combinaciones emoción–característica–contenido para análisis posterior

---

## 👤 Usuarios y perfiles

Cada usuario posee un perfil identificado por:

- Email y contraseña
- Datos personales relevantes para la recomendación (edad, género, idiomas, origen, etc.)
- Ranking inicial (Top 10) de características preferidas en los contenidos

---

## 🕘 Historial de recomendaciones

Por cada recomendación se registra:

- Usuario
- Emociones detectadas
- Características, géneros y temáticas identificadas
- Contenidos recomendados
- Feedback posterior del usuario:
  - Si la recomendación fue acertada
  - Si consumió el contenido
  - Puntuación (1 a 5 estrellas)
  - Comentario opcional

Esta información es clave para el **sistema de ponderación global** del algoritmo de IA.

---

## 🗂️ Estructura del trabajo entregado

### A) Modelo Conceptual
- DER completo
- Restricciones no expresables indicadas en lenguaje natural

### B) Modelo Lógico
- Modelo relacional
- Claves primarias y foráneas
- Todas las relaciones derivadas del DER

### C) Modelo Físico
- Script SQL con:
  - Creación de tablas (DDL)
  - Inserción de datos de prueba (DML)

### D) Consultas SQL

Se resolvieron las siguientes consultas:

1. Top 10 de contenidos con al menos 100 puntuaciones
2. Por formato:
   - Cantidad de contenidos
   - Cantidad de recomendaciones
   - Cantidad consumidas
   - Promedio de puntuación global
3. Playlist de canciones emocionantes para cuando el usuario está aburrido
4. Saga de películas más “atrapante” del catálogo
5. Personas que participen en contenidos de todos los formatos
6. Consulta adicional propuesta por el grupo (enunciada en lenguaje natural y SQL)
7. Vista SQL de la ficha técnica completa de un contenido

---

## ✅ Estado del trabajo

✔ Modelo conceptual completo  
✔ Modelo lógico correctamente normalizado  
✔ Modelo físico funcional en MySQL  
✔ Consultas SQL alineadas al dominio  
✔ Cumple con todos los requisitos del enunciado  
