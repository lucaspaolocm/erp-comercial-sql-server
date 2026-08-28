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
