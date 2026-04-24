# 📦 Proyecto MySQL — Distribuidora de Gaseosas del Valle S.A.

## 1. Descripción del proyecto
Este proyecto consiste en el diseño e implementación de una base de datos relacional en MySQL para la empresa “Distribuidora de Gaseosas del Valle S.A.”, la cual anteriormente gestionaba sus pedidos y control de stock mediante hojas de cálculo, generando errores, pérdida de información y falta de trazabilidad.

La solución desarrollada permite administrar de forma estructurada los productos, clientes, sedes y pedidos, integrando relaciones entre las tablas para garantizar la integridad de los datos. Además, se implementaron funciones y triggers que automatizan procesos clave como el cálculo del total con IVA, la validación de stock y la actualización automática del inventario.

El sistema también incluye consultas y vistas que facilitan el análisis de la información, permitiendo identificar productos más vendidos, clientes activos, pedidos por rango de fechas y control de inventario en tiempo real.

Con esta implementación, la empresa mejora la organización de sus datos, reduce errores operativos y obtiene una base sólida para la toma de decisiones comerciales y logísticas.

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

## 3. Funciones implementadas
Se implementaron funciones en MySQL para encapsular lógica de negocio y facilitar la reutilización de cálculos dentro del sistema.

### fn_calcular_total_con_iva(id_pedido)

Esta función calcula el total de un pedido incluyendo el IVA del 19%. Para ello, suma los subtotales registrados en la tabla `detalle_pedido` y aplica el porcentaje de impuesto correspondiente.

Su uso permite evitar cálculos manuales y garantiza que el total de los pedidos sea consistente en todo el sistema.

---

### fn_validar_stock(id_producto, cantidad)

Esta función permite verificar si un producto cuenta con suficiente stock para cubrir una cantidad solicitada. Consulta el stock actual en la tabla `productos` y lo compara con la cantidad requerida.

Devuelve un mensaje indicando si el stock es suficiente o insuficiente, lo cual es útil para validar operaciones antes de confirmar un pedido.

## 4. Triggers implementados
Se implementaron triggers para automatizar procesos clave dentro del sistema, reduciendo la intervención manual y garantizando la consistencia de los datos.

### tr_actualizar_stock

Este trigger se ejecuta automáticamente después de insertar un registro en la tabla `detalle_pedido`. Su función es descontar del stock actual del producto la cantidad vendida en el pedido.

De esta manera, el inventario se actualiza en tiempo real sin necesidad de ejecutar instrucciones adicionales, evitando errores humanos y manteniendo la coherencia del sistema.

---

### tr_auditar_cambio_precio

Este trigger se activa después de una actualización en la tabla `productos`. Cuando detecta que el precio de un producto ha cambiado, registra automáticamente la información en la tabla `auditoria_precios`, incluyendo el precio anterior, el nuevo precio y la fecha del cambio.

Esto permite llevar un historial de modificaciones, facilitando la trazabilidad y el control sobre los cambios en los precios.

## 5. Consultas SQL
El sistema incluye diversas consultas SQL que permiten analizar la información almacenada y generar reportes útiles para la toma de decisiones.

### Productos con stock bajo

Permite identificar los productos cuyo stock actual es menor o igual al stock mínimo, facilitando el control de inventario.

```sql
SELECT nombre, stock_actual, stock_minimo
FROM productos
WHERE stock_actual <= stock_minimo;

### Pedidos entre dos fechas

Permite consultar los pedidos realizados dentro de un rango de fechas específico.

SELECT id_pedido, fecha_pedido
FROM pedidos
WHERE fecha_pedido BETWEEN '2026-04-01 00:00:00' AND '2026-04-02 23:59:59';

### Productos más vendidos

Permite identificar los productos con mayor cantidad de ventas.

SELECT pr.nombre, SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
INNER JOIN productos pr ON dp.id_producto = pr.id_producto
GROUP BY pr.nombre
ORDER BY total_vendido DESC;

### Cliente con mayor número de pedidos

Permite identificar el cliente más activo del sistema mediante una subconsulta.

SELECT c.nombre_completo, COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente
HAVING COUNT(p.id_pedido) = (
    SELECT MAX(total_pedidos)
    FROM (
        SELECT COUNT(id_pedido) AS total_pedidos
        FROM pedidos
        GROUP BY id_cliente
    ) sub
);

## 6. Vistas

El sistema incluye vistas que permiten consultar información de manera simplificada, facilitando la generación de reportes sin necesidad de escribir consultas complejas.

### vista_resumen_pedidos_por_sede

Esta vista muestra un resumen de la actividad por cada sede, incluyendo la cantidad de pedidos realizados y el total de ventas. Permite analizar el desempeño de cada punto de distribución.

---

### vista_productos_bajo_stock

Esta vista permite identificar rápidamente los productos que se encuentran en niveles críticos de inventario, es decir, aquellos cuyo stock actual es menor o igual al stock mínimo.

---

### vista_clientes_activos

Esta vista muestra los clientes que han realizado al menos un pedido, permitiendo identificar los clientes activos dentro del sistema.

## 7. Ejecución del proyecto

Para ejecutar correctamente el proyecto, se recomienda seguir los siguientes pasos en un gestor de bases de datos como MySQL Workbench o DBeaver:

1. Crear una base de datos nueva (por ejemplo: `distribuidora_db`).

2. Ejecutar el archivo `database.sql` para crear todas las tablas y relaciones.

3. Ejecutar el archivo `inserts.sql` para cargar los datos de prueba.

4. Ejecutar el archivo `functions.sql` para crear las funciones del sistema.

5. Ejecutar el archivo `triggers.sql` para crear los triggers.

6. Ejecutar el archivo `views_and_queries.sql` para crear las vistas y probar las consultas.

Una vez completados estos pasos, el sistema estará listo para ser utilizado y probado mediante consultas SQL.

## 8. Recomendaciones futuras

Como posibles mejoras futuras para el sistema, se proponen las siguientes:

- Implementar procedimientos almacenados para automatizar la creación de pedidos completos, incluyendo la validación de stock y el cálculo de totales.

- Desarrollar un sistema de usuarios con control de acceso, permitiendo definir roles como administrador, vendedor y supervisor.

- Integrar la base de datos con una aplicación web o interfaz gráfica para facilitar su uso por parte del personal no técnico.

- Optimizar consultas mediante índices en campos clave como `id_cliente`, `id_producto` y `fecha_pedido`.

- Ampliar la auditoría para registrar cambios adicionales, como modificaciones en stock o eliminación de registros.

Estas mejoras permitirían escalar el sistema, mejorar su seguridad y facilitar su uso en un entorno empresarial real.

-- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN -- EXAMEN --

## 1. FUNCION calcular_promedio_pedidos_cliente

Esta funcion permite calcular el promedio de los pedidos realizados por un cliente, al ingresar el id de un cliente

## 2. VISTA vista_resumen_sedes

Esta vista permita tener en cache la consulta que muestra por cada sede, el nombre, la cantidad total de pedidos, el valor total vendido (sin iva), y el valor promedio por pedido (sin iva)

## 3. CONSULTA de productos con precio mayor al promedio general

Esta consulta visualiza los productos que tengan un precio mayor al promedio general de los precios de los productos en lista