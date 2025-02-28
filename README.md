# PRACTICA-POWER-MBA-SQL-NOEL-SARRIO

Informe de Análisis de Base de Datos de Películas

Resumen Ejecutivo

Este informe presenta un conjunto de consultas SQL diseñadas para analizar una base de datos de películas, actores, alquileres y clientes. Las consultas cubren una amplia gama de escenarios comunes en la gestión de datos de una plataforma de alquiler de películas, proporcionando información clave sobre el comportamiento de los clientes, las películas más populares, los ingresos generados y la distribución de las películas en categorías.

Áreas clave analizadas:

1. Películas: Análisis de películas por clasificación, duración y frecuencia de alquiler.
2. Actores: Análisis de actores por su participación en películas y en categorías específicas.
3. Clientes y Alquileres: Identificación de clientes con más alquileres y análisis de ingresos generados.
4. Estadísticas Agregadas: Cálculos sobre los ingresos, la desviación estándar de los pagos y alquileres mensuales.
5. Consultas Avanzadas: Uso de vistas, tablas temporales y análisis de combinaciones con Cross Join.

Introducción

El análisis de datos es crucial para la toma de decisiones estratégicas, especialmente en el sector de alquiler de películas. Este informe presenta un análisis detallado de una base de datos SQL utilizada en una plataforma de alquiler de películas. El objetivo es proporcionar una comprensión integral de las operaciones de la plataforma mediante consultas SQL, mejorando la gestión de inventarios, precios y marketing.

Metodología

El análisis se basó en la extracción y manipulación de datos mediante SQL, enfocado en las siguientes etapas:

1. Estructura de la Base de Datos: Se utilizó información de las tablas Film, Actor, Rental, y Payment.
2. Extracción de Datos: Se emplearon consultas SELECT, filtros y funciones agregadas para obtener los datos relevantes.
3. Análisis Descriptivo y Estadístico: Se realizaron análisis sobre la frecuencia de alquiler, el comportamiento de los clientes, y los ingresos generados.
4. Creación de Vistas y Tablas Temporales: Se utilizaron para almacenar resultados intermedios y mejorar la eficiencia de las consultas.

Análisis de Consultas SQL

Este conjunto de consultas SQL aborda diversos aspectos de la base de datos, tales como:

- Películas y Clasificación: Filtrado de películas por clasificación y duración.
- Actores: Análisis de actores según su participación y categorías.
- Clientes y Alquileres: Análisis de ingresos y comportamiento de clientes.
- Estadísticas Financieras: Cálculos de métricas como el promedio, la desviación estándar y la varianza de los pagos.

Conclusiones y Recomendaciones

1. Optimización de Consultas: Mejorar el uso de Cross Join mediante Inner Join o Left Join según el contexto.
2. Uso de Funciones de Agregación: Emplear funciones como COUNT, AVG, SUM para obtener información agregada eficiente.
3. Trabajo con Fechas: Optimizar las consultas que involucran fechas, especialmente aquellas relacionadas con la duración de alquileres.
