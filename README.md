# 📦 Proyecto MySQL — Distribuidora de Gaseosas del Valle S.A.

## 1. Descripción del proyecto
Este proyecto consiste en el diseño e implementación de una base de datos relacional en MySQL para la empresa “Distribuidora de Gaseosas del Valle S.A.”, la cual anteriormente gestionaba sus pedidos y control de stock mediante hojas de cálculo, generando errores, pérdida de información y falta de trazabilidad.

La solución desarrollada permite administrar de forma estructurada los productos, clientes, sedes y pedidos, integrando relaciones entre las tablas para garantizar la integridad de los datos. Además, se implementaron funciones y triggers que automatizan procesos clave como el cálculo del total con IVA, la validación de stock y la actualización automática del inventario.

El sistema también incluye consultas y vistas que facilitan el análisis de la información, permitiendo identificar productos más vendidos, clientes activos, pedidos por rango de fechas y control de inventario en tiempo real.

Con esta implementación, la empresa mejora la organización de sus datos, reduce errores operativos y obtiene una base sólida para la toma de decisiones comerciales y logísticas.

Permite ampliar las funcionalidades del sistema de base de datos, enfoca ndote en consultas de ana lisis y funciones
intermedias que permitan tomar decisiones comerciales mas precisas.

## 2. Modelo de base de datos
El modelo de base de datos está diseñado bajo un enfoque relacional, permitiendo representar las operaciones principales de la distribuidora mediante tablas interconectadas.

### Tablas principales

- **productos**: almacena la información de los productos, incluyendo nombre, categoría, precio, volumen y control de stock.
- **clientes**: registra los datos de los clientes, como nombre, identificación y datos de contacto.
- **sedes**: representa las diferentes sedes de distribución de la empresa.
- **pedidos**: almacena la información general de cada pedido, incluyendo fecha, cliente, sede y totales.
- **detalle_pedido**: tabla intermedia que relaciona pedidos con productos, permitiendo registrar múltiples productos por pedido.
- **auditoria_precios**: almacena el historial de cambios de precio de los productos.

### Relaciones

- Un cliente puede realizar varios pedidos (relación 1:N).
- Una sede puede despachar múltiples pedidos (relación 1:N).
- Un pedido puede contener varios productos, y un producto puede estar en varios pedidos, lo cual se resuelve mediante la tabla `detalle_pedido` (relación N:N).
- Un producto puede tener múltiples registros de auditoría de precio (relación 1:N).

Este modelo garantiza la integridad de los datos mediante el uso de claves primarias y claves foráneas, evitando duplicidad de información y permitiendo consultas eficientes.

## 1. Funciones implementadas
Se implementaron funciones en MySQL para encapsular lógica de negocio y facilitar la reutilización de cálculos dentro del sistema.

## FUNCION calcular_promedio_pedidos_cliente

Esta funcion permite calcular el promedio de los pedidos realizados por un cliente, al ingresar el id de un cliente

## 2. Vistas

El sistema incluye vistas que permiten consultar información de manera simplificada, facilitando la generación de reportes sin necesidad de escribir consultas complejas.

## VISTA vista_resumen_sedes

Esta vista permita tener en cache la consulta que muestra por cada sede, el nombre, la cantidad total de pedidos, el valor total vendido (sin iva), y el valor promedio por pedido (sin iva)

## 3. Consultas SQL
El sistema incluye diversas consultas SQL que permiten analizar la información almacenada y generar reportes útiles para la toma de decisiones.

## CONSULTA de productos con precio mayor al promedio general

Esta consulta visualiza los productos que tengan un precio mayor al promedio general de los precios de los productos en lista

## 4. Triggers implementados
Se implementaron triggers para automatizar procesos clave dentro del sistema, reduciendo la intervención manual y garantizando la consistencia de los datos.

### tr_auditar_cambio_precio

Este trigger se activa después de una actualización en la tabla `productos`. Cuando detecta que el precio de un producto ha cambiado, registra automáticamente la información en la tabla `auditoria_precios`, incluyendo el precio anterior, el nuevo precio y la fecha del cambio.

Esto permite llevar un historial de modificaciones, facilitando la trazabilidad y el control sobre los cambios en los precios.

