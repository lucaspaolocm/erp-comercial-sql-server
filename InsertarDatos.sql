-- PASO 3: INSERTAR DATOS EN TODAS LAS TABLAS
-- Primero aseguramos estar en la BD correcta
USE ERPComercial;
GO

-- ============================================================================
-- INSERTAR CATEGORIAS
-- Propósito: Definir los tipos de productos que vendemos
-- ============================================================================
INSERT INTO categorias (nombre_categoria)
VALUES
('Tecnología'),
('Oficina'),
('Mobiliario'),
('Software');

-- Verificar que se insertaron
SELECT * FROM categorias;
GO

-- ============================================================================
-- INSERTAR SUCURSALES
-- Propósito: Las ubicaciones de nuestro negocio en Latinoamérica
-- ============================================================================
INSERT INTO sucursales (nombre_sucursal, pais, ciudad)
VALUES
('Sucursal Santiago', 'Chile', 'Santiago'),
('Sucursal Lima', 'Perú', 'Lima'),
('Sucursal Bogotá', 'Colombia', 'Bogotá');

SELECT * FROM sucursales;
GO

-- ============================================================================
-- INSERTAR VENDEDORES
-- Propósito: Personas que venden en cada sucursal
-- Campos: nombre, sucursal donde trabaja, cargo, fecha ingreso
-- ============================================================================
INSERT INTO vendedores (nombre_vendedor, id_sucursal, cargo, fecha_ingreso)
VALUES
('Camila Torres', 1, 'Ejecutiva Comercial', '2023-01-10'),
('Felipe Rojas', 1, 'Ejecutivo Comercial', '2023-03-15'),
('María Quispe', 2, 'Ejecutiva Comercial', '2022-11-01'),
('Andrés Gómez', 3, 'Ejecutivo Comercial', '2024-02-05');

SELECT * FROM vendedores;
GO

-- ============================================================================
-- INSERTAR CLIENTES
-- Propósito: Quiénes compran nuestros productos
-- Campos: nombre, país, ciudad, segmento (tipo de cliente), fecha registro
-- ============================================================================
INSERT INTO clientes (nombre_cliente, pais, ciudad, segmento, fecha_registro)
VALUES
('Comercial Andes', 'Chile', 'Santiago', 'Empresa', '2023-01-05'),
('Retail Express', 'Chile', 'Valparaíso', 'Retail', '2023-02-12'),
('Inversiones Norte', 'Perú', 'Lima', 'Empresa', '2023-04-20'),
('Global Market', 'Colombia', 'Bogotá', 'Empresa', '2023-06-15'),
('Emprende Fácil', 'Chile', 'Concepción', 'Pyme', '2023-07-09'),
('Distribuidora Lima', 'Perú', 'Lima', 'Distribuidor', '2023-08-18'),
('Servicios Patagonia', 'Chile', 'Puerto Montt', 'Pyme', '2023-10-02'),
('Tech Solutions', 'México', 'Ciudad de México', 'Empresa', '2024-01-11');

SELECT * FROM clientes;
GO

-- ============================================================================
-- INSERTAR PROVEEDORES
-- Propósito: De dónde compramos nosotros los productos que vendemos
-- Campos: nombre, país, contacto (email)
-- ============================================================================
INSERT INTO proveedores (nombre_proveedor, pais, contacto)
VALUES
('Importadora Tech', 'Chile', 'contacto@importech.cl'),
('OfiProveedores', 'Perú', 'ventas@ofipro.pe'),
('Muebles Latam', 'Colombia', 'comercial@muebleslatam.co'),
('SoftCloud', 'México', 'soporte@softcloud.mx');

SELECT * FROM proveedores;
GO

-- ============================================================================
-- INSERTAR PRODUCTOS
-- Propósito: Qué vendemos
-- Campos: nombre, categoría, proveedor, precio de venta, costo, stock mínimo
-- ============================================================================
INSERT INTO productos (nombre_producto, id_categoria, id_proveedor, precio_unitario, costo_unitario, stock_minimo)
VALUES
('Notebook Ejecutivo', 1, 1, 950.00, 620.00, 5),
('Monitor 24 pulgadas', 1, 1, 220.00, 140.00, 8),
('Teclado Inalámbrico', 1, 1, 45.00, 25.00, 15),
('Mouse Ergonomico', 1, 1, 30.00, 14.00, 20),
('Silla Oficina Pro', 3, 3, 180.00, 105.00, 6),
('Escritorio Modular', 3, 3, 260.00, 160.00, 4),
('Pack Papelería', 2, 2, 35.00, 18.00, 20),
('Impresora Multifuncional', 1, 1, 320.00, 210.00, 5),
('Licencia CRM Mensual', 4, 4, 80.00, 35.00, 10),
('Licencia BI Mensual', 4, 4, 120.00, 50.00, 10),
('Archivador Corporativo', 2, 2, 22.00, 11.00, 25),
('Router Empresarial', 1, 1, 150.00, 85.00, 6);

SELECT * FROM productos;
GO

-- ============================================================================
-- INSERTAR INVENTARIO
-- Propósito: Cuánto stock hay en cada sucursal de cada producto
-- Campos: producto, sucursal, cantidad actual, fecha última actualización
-- ============================================================================
INSERT INTO inventario (id_producto, id_sucursal, stock_actual, ultima_actualizacion)
VALUES
-- Sucursal Santiago (id_sucursal = 1)
(1, 1, 14, '2024-01-01'),
(2, 1, 20, '2024-01-01'),
(3, 1, 45, '2024-01-01'),
(4, 1, 60, '2024-01-01'),
(5, 1, 12, '2024-01-01'),
(6, 1, 8, '2024-01-01'),
(7, 1, 80, '2024-01-01'),
(8, 1, 9, '2024-01-01'),
(9, 1, 30, '2024-01-01'),
(10, 1, 25, '2024-01-01'),
(11, 1, 90, '2024-01-01'),
(12, 1, 10, '2024-01-01'),
-- Sucursal Lima (id_sucursal = 2)
(1, 2, 8, '2024-01-01'),
(2, 2, 14, '2024-01-01'),
(3, 2, 30, '2024-01-01'),
(4, 2, 35, '2024-01-01'),
(5, 2, 7, '2024-01-01'),
(6, 2, 5, '2024-01-01'),
(7, 2, 55, '2024-01-01'),
(8, 2, 6, '2024-01-01'),
(9, 2, 18, '2024-01-01'),
(10, 2, 15, '2024-01-01'),
(11, 2, 60, '2024-01-01'),
(12, 2, 7, '2024-01-01'),
-- Sucursal Bogotá (id_sucursal = 3)
(1, 3, 6, '2024-01-01'),
(2, 3, 10, '2024-01-01'),
(3, 3, 24, '2024-01-01'),
(4, 3, 28, '2024-01-01'),
(5, 3, 5, '2024-01-01'),
(6, 3, 4, '2024-01-01'),
(7, 3, 40, '2024-01-01'),
(8, 3, 4, '2024-01-01'),
(9, 3, 12, '2024-01-01'),
(10, 3, 10, '2024-01-01'),
(11, 3, 50, '2024-01-01'),
(12, 3, 5, '2024-01-01');

SELECT COUNT(*) AS TotalInventario FROM inventario;
GO

-- ============================================================================
-- INSERTAR PEDIDOS
-- Propósito: Cada compra que hace un cliente
-- Campos: fecha, cliente, vendedor, sucursal, estado, canal de venta
-- ============================================================================
INSERT INTO pedidos (fecha_pedido, id_cliente, id_vendedor, id_sucursal, estado_pedido, canal_venta)
VALUES
('2024-01-05', 1, 1, 1, 'Entregado', 'Web'),
('2024-01-12', 2, 2, 1, 'Entregado', 'Tienda'),
('2024-01-20', 3, 3, 2, 'Entregado', 'Ejecutivo'),
('2024-02-03', 4, 4, 3, 'Entregado', 'Ejecutivo'),
('2024-02-10', 5, 1, 1, 'Entregado', 'Web'),
('2024-02-18', 6, 3, 2, 'Entregado', 'Tienda'),
('2024-03-02', 7, 2, 1, 'Entregado', 'Ejecutivo'),
('2024-03-09', 8, 4, 3, 'Entregado', 'Web'),
('2024-03-14', 1, 1, 1, 'Entregado', 'Tienda'),
('2024-03-25', 3, 3, 2, 'Entregado', 'Ejecutivo'),
('2024-04-04', 4, 4, 3, 'Entregado', 'Web'),
('2024-04-12', 5, 2, 1, 'Entregado', 'Tienda'),
('2024-04-19', 6, 3, 2, 'Entregado', 'Ejecutivo'),
('2024-05-03', 2, 1, 1, 'Entregado', 'Web'),
('2024-05-10', 7, 2, 1, 'Pendiente', 'Ejecutivo'),
('2024-05-18', 8, 4, 3, 'Entregado', 'Web'),
('2024-06-07', 1, 1, 1, 'Pendiente', 'Tienda'),
('2024-06-15', 4, 4, 3, 'Cancelado', 'Ejecutivo');

SELECT COUNT(*) AS TotalPedidos FROM pedidos;
GO

-- ============================================================================
-- INSERTAR DETALLE_PEDIDO
-- Propósito: Qué productos van en cada pedido (líneas de factura)
-- Campos: pedido, producto, cantidad, precio unitario, descuento
-- ============================================================================
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario, descuento)
VALUES
(1, 1, 1, 950, 0.05),
(1, 3, 2, 45, 0.00),
(2, 5, 3, 180, 0.10),
(2, 7, 5, 35, 0.00),
(3, 10, 4, 120, 0.05),
(3, 12, 2, 150, 0.00),
(4, 2, 5, 220, 0.08),
(4, 4, 10, 30, 0.00),
(5, 8, 1, 320, 0.00),
(5, 11, 6, 22, 0.00),
(6, 6, 2, 260, 0.05),
(6, 7, 8, 35, 0.00),
(7, 9, 5, 80, 0.00),
(7, 10, 3, 120, 0.00),
(8, 1, 2, 950, 0.10),
(8, 12, 3, 150, 0.05),
(9, 2, 4, 220, 0.00),
(9, 3, 6, 45, 0.00),
(10, 5, 2, 180, 0.00),
(10, 6, 1, 260, 0.00),
(11, 8, 2, 320, 0.05),
(11, 4, 8, 30, 0.00),
(12, 7, 10, 35, 0.00),
(12, 11, 12, 22, 0.00),
(13, 10, 6, 120, 0.10),
(13, 9, 4, 80, 0.00),
(14, 1, 1, 950, 0.00),
(14, 2, 2, 220, 0.05),
(15, 12, 2, 150, 0.00),
(15, 4, 5, 30, 0.00),
(16, 8, 1, 320, 0.00),
(16, 10, 2, 120, 0.00),
(17, 3, 10, 45, 0.00),
(17, 7, 15, 35, 0.00),
(18, 6, 1, 260, 0.00),
(18, 5, 1, 180, 0.00);

SELECT COUNT(*) AS TotalDetalles FROM detalle_pedido;
GO

-- ============================================================================
-- INSERTAR PAGOS
-- Propósito: Registrar cómo y cuándo pagan los clientes
-- Campos: pedido, fecha pago, método, monto, estado
-- ============================================================================
INSERT INTO pagos (id_pedido, fecha_pago, metodo_pago, monto_pagado, estado_pago)
VALUES
(1, '2024-01-06', 'Transferencia', 992.50, 'Pagado'),
(2, '2024-01-13', 'Tarjeta', 661.00, 'Pagado'),
(3, '2024-01-22', 'Transferencia', 756.00, 'Pagado'),
(4, '2024-02-05', 'Transferencia', 1312.00, 'Pagado'),
(5, '2024-02-11', 'Tarjeta', 452.00, 'Pagado'),
(6, '2024-02-20', 'Transferencia', 774.00, 'Pagado'),
(7, '2024-03-04', 'Transferencia', 760.00, 'Pagado'),
(8, '2024-03-10', 'Tarjeta', 2137.50, 'Pagado'),
(9, '2024-03-15', 'Transferencia', 1150.00, 'Pagado'),
(10, '2024-03-26', 'Transferencia', 620.00, 'Pagado'),
(11, '2024-04-05', 'Tarjeta', 848.00, 'Pagado'),
(12, '2024-04-13', 'Transferencia', 614.00, 'Pagado'),
(13, '2024-04-20', 'Transferencia', 968.00, 'Pagado'),
(14, '2024-05-04', 'Tarjeta', 1368.00, 'Pagado'),
(15, NULL, 'Transferencia', 0.00, 'Pendiente'),
(16, '2024-05-20', 'Tarjeta', 560.00, 'Pagado'),
(17, NULL, 'Transferencia', 0.00, 'Pendiente'),
(18, NULL, 'Transferencia', 0.00, 'Cancelado');

SELECT COUNT(*) AS TotalPagos FROM pagos;
GO

-- ============================================================================
-- INSERTAR ENVIOS
-- Propósito: Registrar cómo se entregan los pedidos
-- Campos: pedido, fecha envío, empresa, estado, costo
-- ============================================================================
INSERT INTO envios (id_pedido, fecha_envio, empresa_envio, estado_envio, costo_envio)
VALUES
(1, '2024-01-06', 'Chilexpress', 'Entregado', 18),
(2, '2024-01-13', 'Starken', 'Entregado', 22),
(3, '2024-01-22', 'DHL', 'Entregado', 35),
(4, '2024-02-05', 'DHL', 'Entregado', 40),
(5, '2024-02-11', 'Chilexpress', 'Entregado', 16),
(6, '2024-02-20', 'DHL', 'Entregado', 30),
(7, '2024-03-04', 'Starken', 'Entregado', 20),
(8, '2024-03-10', 'DHL', 'Entregado', 45),
(9, '2024-03-15', 'Chilexpress', 'Entregado', 24),
(10, '2024-03-26', 'DHL', 'Entregado', 32),
(11, '2024-04-05', 'DHL', 'Entregado', 38),
(12, '2024-04-13', 'Starken', 'Entregado', 18),
(13, '2024-04-20', 'DHL', 'Entregado', 34),
(14, '2024-05-04', 'Chilexpress', 'Entregado', 25),
(15, NULL, 'Starken', 'Pendiente', 0),
(16, '2024-05-20', 'DHL', 'Entregado', 36),
(17, NULL, 'Chilexpress', 'Pendiente', 0),
(18, NULL, 'DHL', 'Cancelado', 0);

SELECT COUNT(*) AS TotalEnvios FROM envios;
GO

-- ============================================================================
-- INSERTAR DEVOLUCIONES
-- Propósito: Registrar productos retornados o intercambiados
-- Campos: pedido, producto, fecha devolución, cantidad, motivo
-- ============================================================================
INSERT INTO devoluciones (id_pedido, id_producto, fecha_devolucion, cantidad_devuelta, motivo)
VALUES
(4, 4, '2024-02-12', 2, 'Producto defectuoso'),
(8, 12, '2024-03-18', 1, 'Cambio solicitado'),
(11, 8, '2024-04-11', 1, 'Falla de equipo'),
(14, 2, '2024-05-12', 1, 'Producto no requerido');

SELECT COUNT(*) AS TotalDevoluciones FROM devoluciones;
GO

-- ============================================================================
-- RESUMEN FINAL: CONTAR TODOS LOS REGISTROS
-- Propósito: Validar que todos los datos se insertaron correctamente
-- ============================================================================
PRINT '========== RESUMEN DE DATOS INSERTADOS =========='
SELECT 'categorias' AS Tabla, COUNT(*) AS Total FROM categorias
UNION ALL
SELECT 'sucursales', COUNT(*) FROM sucursales
UNION ALL
SELECT 'vendedores', COUNT(*) FROM vendedores
UNION ALL
SELECT 'clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'proveedores', COUNT(*) FROM proveedores
UNION ALL
SELECT 'productos', COUNT(*) FROM productos
UNION ALL
SELECT 'inventario', COUNT(*) FROM inventario
UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido
UNION ALL
SELECT 'pagos', COUNT(*) FROM pagos
UNION ALL
SELECT 'envios', COUNT(*) FROM envios
UNION ALL
SELECT 'devoluciones', COUNT(*) FROM devoluciones
ORDER BY Tabla;

GO