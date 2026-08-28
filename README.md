# ERP Comercial - Proyecto SQL Server Intermedio

## 📋 Descripción del Proyecto

Este proyecto implementa una **base de datos relacional completa** en SQL Server para simular el funcionamiento de un **ERP comercial**. Incluye todas las operaciones típicas de un negocio: clientes, vendedores, productos, pedidos, pagos, inventario, envíos y devoluciones.

### Objetivo
Desarrollar una solución integral de base de datos que permita:
- Gestionar información de clientes, productos y vendedores
- Registrar pedidos y detalles de venta
- Controlar inventario en múltiples sucursales
- Registrar pagos y envíos
- Trackear devoluciones
- Generar análisis y reportes de negocio

---

## 🏗️ Estructura de la Base de Datos

### Tablas Principales

| Tabla | Propósito | Registros |
|-------|-----------|-----------|
| **categorias** | Clasificar productos | 4 |
| **sucursales** | Ubicaciones del negocio | 3 |
| **vendedores** | Personal de ventas | 4 |
| **clientes** | Quiénes compran | 8 |
| **proveedores** | De dónde compramos | 4 |
| **productos** | Catálogo de ventas | 12 |
| **inventario** | Stock por sucursal | 36 |
| **pedidos** | Transacciones de venta | 18 |
| **detalle_pedido** | Líneas de cada pedido | 36 |
| **pagos** | Registro de cobros | 18 |
| **envios** | Distribución de pedidos | 18 |
| **devoluciones** | Productos retornados | 4 |

**Total: 12 tablas con 161 registros de datos**

---

## 📊 Diagrama Relacional
categorias (1) ─── (N) productos ─── (N) detalle_pedido ─── (1) pedidos
│
proveedores (1) ─── (N) productos │
├─── (1) clientes
sucursales (1) ─── (N) vendedores ├─── (1) vendedores
│ ├─── (1) sucursales
└─── (N) inventario ─── (1) productos │
├─── (1) pagos
├─── (1) envios
└─── (1) devoluciones


---

## 🚀 Cómo Usar Este Proyecto

### Requisitos
- SQL Server 2016 o superior
- SQL Server Management Studio (SSMS)
- Acceso de administrador a SQL Server

### Instalación

#### 1. Crear la Base de Datos
```sql
-- Ejecutar en SQL Server
USE master;
GO
CREATE DATABASE ERPComercial;
GO
```

#### 2. Crear Tablas
- Abre el archivo `01_CrearTablas.sql`
- Ejecuta en SSMS (F5)
- Verifica que se crean 12 tablas

#### 3. Insertar Datos
- Abre el archivo `02_InsertarDatos.sql`
- Ejecuta en SSMS
- Verifica 161 registros insertados

#### 4. Ejecutar Consultas de Análisis
- Abre el archivo `03_ConsultasAnalisis.sql`
- Ejecuta para ver análisis comerciales

#### 5. Ver Respuestas a Preguntas
- Abre el archivo `04_PreguntasAnalisis.sql`
- Ejecuta para obtener respuestas estratégicas

---

## 📈 Análisis Incluidos

El proyecto incluye **11 análisis SQL** que responden preguntas clave:

### Preguntas Respondidas

1. **¿Qué cliente realizó el mayor total de compras?**
   - Respuesta: Global Market con $3,258.50

2. **¿Qué vendedor generó más ventas?**
   - Respuesta: Felipe Rojas con $2,157.50 en 3 pedidos

3. **¿Qué producto tuvo más unidades vendidas?**
   - Respuesta: Pack Papelería con 38 unidades

4. **¿Qué pedido tuvo el mayor monto vendido?**
   - Respuesta: Pedido #8 con $2,137.50

5. **¿Qué canal de venta generó más ingresos?**
   - Respuesta: Ejecutivo con $6,101.50

6. **¿Qué sucursal realizó más ventas?**
   - Respuesta: Sucursal Santiago con $9,382.00

7. **¿Qué productos presentan stock crítico?**
   - Respuesta: 3 productos en Bogotá necesitan reorden

8. **¿Qué pedidos siguen pendientes o cancelados?**
   - Respuesta: 3 pedidos por $1,865.00

9. **¿Qué pedidos tuvieron devoluciones?**
   - Respuesta: 4 pedidos con 5 unidades devueltas

10. **¿Cuántos pagos siguen pendientes o cancelados?**
    - Respuesta: 3 pagos sin procesar

---

## 📁 Estructura de Archivos


---

## 🔧 Conceptos SQL Utilizados

✅ **DDL (Data Definition Language)**
- CREATE DATABASE
- CREATE TABLE
- PRIMARY KEY, FOREIGN KEY
- IDENTITY

✅ **DML (Data Manipulation Language)**
- INSERT INTO
- SELECT
- JOIN (INNER, LEFT)
- GROUP BY, HAVING
- ORDER BY
- WHERE, UNION

✅ **Funciones de Agregación**
- SUM()
- COUNT()
- COUNT(DISTINCT)
- ISNULL()

✅ **Cálculos Complejos**
- Totales con descuento: `cantidad * precio * (1 - descuento)`
- Utilidades: `(precio - costo) * cantidad`
- Agregaciones multi-tabla

---

## 💡 Casos de Uso Reales

Este proyecto simula un **negocio real** con:

### Escenarios Comerciales
- **Clientes múltiples** comprando en diferentes sucursales
- **Vendedores** con diferentes niveles de productividad
- **Canales de venta** (Web, Tienda, Ejecutivo)
- **Productos variados** en 4 categorías
- **Inventario distribuido** en 3 sucursales

### Operaciones Típicas
- Crear pedidos con múltiples líneas
- Aplicar descuentos por volumen
- Registrar pagos (pendientes, completados, cancelados)
- Trackear envíos
- Registrar devoluciones con motivos
- Controlar stock mínimo

---

## 📊 Métricas del Proyecto

| Métrica | Valor |
|---------|-------|
| Tablas | 12 |
| Registros Totales | 161 |
| Período de Datos | Enero - Junio 2024 |
| Países Cubiertos | 4 (Chile, Perú, Colombia, México) |
| Sucursales | 3 |
| Vendedores | 4 |
| Clientes | 8 |
| Productos | 12 |
| Pedidos | 18 |
| Devoluciones | 4 |
| Pagos Pendientes | 3 |

---

## 🎯 Habilidades Desarrolladas

Al completar este proyecto aprenderás:

✅ Diseño de bases de datos relacionales  
✅ Normalización y estructura de datos  
✅ JOINs y relaciones entre tablas  
✅ Agregaciones y GROUP BY  
✅ Cálculos complejos con descuentos  
✅ Análisis de datos para negocio  
✅ Identificación de problemas operacionales  
✅ Responder preguntas estratégicas con SQL  

---

## 📝 Autor

Proyecto desarrollado como ejercicio intermedio de SQL Server y análisis de datos.

## 📅 Fecha

Agosto 2026

---

## 🤝 Contribuciones

Este proyecto es educativo. Siéntete libre de:
- Modificar consultas
- Agregar más datos
- Crear nuevos análisis
- Proponer mejoras

---

## 📞 Preguntas Frecuentes

### P: ¿Puedo usar este proyecto en producción?
**R:** No. Este es un proyecto educativo. Para producción, necesita validaciones adicionales, auditoría, transacciones y seguridad.

### P: ¿Qué versión de SQL Server necesito?
**R:** SQL Server 2016 o superior (2019, 2022 funcionan perfectamente).

### P: ¿Cuánto tiempo toma completar el proyecto?
**R:** 4-6 horas (dependiendo del nivel de experiencia).

### P: ¿Puedo agregar más datos?
**R:** Sí. Los scripts están diseñados para ser extensibles. Solo respeta las relaciones.

