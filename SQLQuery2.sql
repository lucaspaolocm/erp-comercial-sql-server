-- PASO 2: CREAR TODAS LAS TABLAS DEL ERP COMERCIAL
-- Primero aseguramos estar en la BD correcta
USE ERPComercial;
GO

-- ============================================================================
-- TABLA 1: CATEGORIAS
-- Propósito: Agrupar productos por tipo (Tecnología, Oficina, etc)
-- Campos: ID único y nombre
-- ============================================================================
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nombre_categoria VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================================================
-- TABLA 2: SUCURSALES
-- Propósito: Diferentes ubicaciones del negocio
-- Campos: ID, nombre, país, ciudad
-- ============================================================================
CREATE TABLE sucursales (
    id_sucursal INT PRIMARY KEY IDENTITY(1,1),
    nombre_sucursal VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

-- ============================================================================
-- TABLA 3: VENDEDORES
-- Propósito: Personas que venden
-- Campos: ID, nombre, sucursal donde trabaja, cargo, fecha de ingreso
-- ============================================================================
CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY IDENTITY(1,1),
    nombre_vendedor VARCHAR(100) NOT NULL,
    id_sucursal INT NOT NULL,
    cargo VARCHAR(50),
    fecha_ingreso DATE,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

-- ============================================================================
-- TABLA 4: CLIENTES
-- Propósito: Quiénes compran
-- Campos: ID, nombre, país, ciudad, segmento (tipo cliente), fecha registro
-- ============================================================================
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre_cliente VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    ciudad VARCHAR(50),
    segmento VARCHAR(30),
    fecha_registro DATE
);

-- ============================================================================
-- TABLA 5: PROVEEDORES
-- Propósito: De dónde compramos nosotros los productos
-- Campos: ID, nombre, país, contacto
-- ============================================================================
CREATE TABLE proveedores (
    id_proveedor INT PRIMARY KEY IDENTITY(1,1),
    nombre_proveedor VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    contacto VARCHAR(100)
);

-- ============================================================================
-- TABLA 6: PRODUCTOS
-- Propósito: Qué vendemos
-- Campos: ID, nombre, categoría, proveedor, precios, stock mínimo
-- ============================================================================
CREATE TABLE productos (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    id_proveedor INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL,
    stock_minimo INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

-- ============================================================================
-- TABLA 7: INVENTARIO
-- Propósito: Stock en cada sucursal
-- Campos: ID, producto, sucursal, cantidad actual, última actualización
-- ============================================================================
CREATE TABLE inventario (
    id_inventario INT PRIMARY KEY IDENTITY(1,1),
    id_producto INT NOT NULL,
    id_sucursal INT NOT NULL,
    stock_actual INT,
    ultima_actualizacion DATETIME,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

-- ============================================================================
-- TABLA 8: PEDIDOS
-- Propósito: Cada compra que hace un cliente
-- Campos: ID, fecha, cliente, vendedor, sucursal, estado, canal de venta
-- ============================================================================
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY IDENTITY(1,1),
    fecha_pedido DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    id_sucursal INT NOT NULL,
    estado_pedido VARCHAR(20),
    canal_venta VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

-- ============================================================================
-- TABLA 9: DETALLE_PEDIDO
-- Propósito: Qué productos van en cada pedido (detalles de la factura)
-- Campos: ID, pedido, producto, cantidad, precio, descuento
-- ============================================================================
CREATE TABLE detalle_pedido (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(4,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================================
-- TABLA 10: PAGOS
-- Propósito: Cómo y cuándo pagan los clientes
-- Campos: ID, pedido, fecha pago, método, monto, estado
-- ============================================================================
CREATE TABLE pagos (
    id_pago INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    fecha_pago DATE,
    metodo_pago VARCHAR(30),
    monto_pagado DECIMAL(10,2),
    estado_pago VARCHAR(20),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- ============================================================================
-- TABLA 11: ENVIOS
-- Propósito: Cómo se entrega el pedido
-- Campos: ID, pedido, fecha envío, empresa, estado, costo
-- ============================================================================
CREATE TABLE envios (
    id_envio INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    fecha_envio DATE,
    empresa_envio VARCHAR(50),
    estado_envio VARCHAR(20),
    costo_envio DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- ============================================================================
-- TABLA 12: DEVOLUCIONES
-- Propósito: Productos retornados o intercambiados
-- Campos: ID, pedido, producto, fecha devolución, cantidad, motivo
-- ============================================================================
CREATE TABLE devoluciones (
    id_devolucion INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    fecha_devolucion DATE,
    cantidad_devuelta INT,
    motivo VARCHAR(100),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

GO

-- Verificar que todas las tablas fueron creadas
SELECT TABLE_NAME AS Tabla
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'dbo'
ORDER BY TABLE_NAME;

GO