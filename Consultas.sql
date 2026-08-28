-- PASO 4: CONSULTAS SQL PARA ANÁLISIS - VERSIÓN CORREGIDA
-- Estas consultas funcionan correctamente en SQL Server
USE ERPComercial;
GO

-- ============================================================================
-- CONSULTA 1: VALIDAR DATOS EN TODAS LAS TABLAS
-- Propósito: Verificar que cada tabla tiene registros
-- ============================================================================
PRINT '========== CONSULTA 1: VALIDAR DATOS EN TODAS LAS TABLAS =========='
GO
SELECT 'categorias' AS Tabla, COUNT(*) AS TotalRegistros FROM categorias
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

-- ============================================================================
-- CONSULTA 2: PEDIDOS CON CLIENTE, VENDEDOR Y SUCURSAL
-- ============================================================================
PRINT '========== CONSULTA 2: PEDIDOS CON DETALLES =========='
GO
SELECT TOP 15
    p.id_pedido AS IdPedido,
    p.fecha_pedido AS FechaPedido,
    c.nombre_cliente AS Cliente,
    v.nombre_vendedor AS Vendedor,
    s.nombre_sucursal AS Sucursal,
    p.estado_pedido AS Estado
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN vendedores v ON p.id_vendedor = v.id_vendedor
INNER JOIN sucursales s ON p.id_sucursal = s.id_sucursal
ORDER BY p.fecha_pedido DESC;
GO

-- ============================================================================
-- CONSULTA 3: TOTAL VENDIDO POR PEDIDO
-- ============================================================================
PRINT '========== CONSULTA 3: TOTAL VENDIDO POR PEDIDO =========='
GO
SELECT 
    p.id_pedido AS IdPedido,
    c.nombre_cliente AS Cliente,
    SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)) AS TotalVendido
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY p.id_pedido, c.nombre_cliente
ORDER BY TotalVendido DESC;
GO

-- ============================================================================
-- CONSULTA 4: VENTAS ACUMULADAS POR CLIENTE
-- ============================================================================
PRINT '========== CONSULTA 4: VENTAS ACUMULADAS POR CLIENTE =========='
GO
SELECT 
    c.nombre_cliente AS Cliente,
    c.segmento AS Segmento,
    COUNT(DISTINCT p.id_pedido) AS TotalPedidos,
    SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)) AS TotalGastado
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.nombre_cliente, c.segmento
ORDER BY TotalGastado DESC;
GO

-- ============================================================================
-- CONSULTA 5: VENTAS POR PRODUCTO
-- ============================================================================
PRINT '========== CONSULTA 5: VENTAS POR PRODUCTO =========='
GO
SELECT TOP 15
    pr.nombre_producto AS Producto,
    ca.nombre_categoria AS Categoria,
    SUM(dp.cantidad) AS UnidadesVendidas,
    SUM(dp.cantidad * dp.precio_unitario) AS VentasTotal
FROM productos pr
INNER JOIN categorias ca ON pr.id_categoria = ca.id_categoria
LEFT JOIN detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY pr.nombre_producto, ca.nombre_categoria
ORDER BY UnidadesVendidas DESC;
GO

-- ============================================================================
-- CONSULTA 6: UTILIDAD POR PRODUCTO
-- ============================================================================
PRINT '========== CONSULTA 6: UTILIDAD POR PRODUCTO =========='
GO
SELECT TOP 15
    pr.nombre_producto AS Producto,
    pr.precio_unitario AS Precio,
    pr.costo_unitario AS Costo,
    (pr.precio_unitario - pr.costo_unitario) AS MargenUnitario,
    ISNULL(SUM(dp.cantidad), 0) AS UnidadesVendidas,
    ISNULL(SUM((pr.precio_unitario - pr.costo_unitario) * dp.cantidad), 0) AS UtilidadTotal
FROM productos pr
LEFT JOIN detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY pr.nombre_producto, pr.precio_unitario, pr.costo_unitario
ORDER BY UtilidadTotal DESC;
GO

-- ============================================================================
-- CONSULTA 7: VENTAS POR VENDEDOR
-- ============================================================================
PRINT '========== CONSULTA 7: VENTAS POR VENDEDOR =========='
GO
SELECT 
    v.nombre_vendedor AS Vendedor,
    s.nombre_sucursal AS Sucursal,
    COUNT(DISTINCT p.id_pedido) AS TotalPedidos,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)), 0) AS VentasTotal
FROM vendedores v
INNER JOIN sucursales s ON v.id_sucursal = s.id_sucursal
LEFT JOIN pedidos p ON v.id_vendedor = p.id_vendedor
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY v.nombre_vendedor, s.nombre_sucursal
ORDER BY VentasTotal DESC;
GO

-- ============================================================================
-- CONSULTA 8: PEDIDOS PENDIENTES O CANCELADOS
-- ============================================================================
PRINT '========== CONSULTA 8: PEDIDOS PENDIENTES O CANCELADOS =========='
GO
SELECT 
    p.id_pedido AS IdPedido,
    c.nombre_cliente AS Cliente,
    p.estado_pedido AS Estado,
    SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)) AS Monto
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
WHERE p.estado_pedido IN ('Pendiente', 'Cancelado')
GROUP BY p.id_pedido, c.nombre_cliente, p.estado_pedido
ORDER BY p.id_pedido DESC;
GO

-- ============================================================================
-- CONSULTA 9: PRODUCTOS CON BAJO STOCK
-- ============================================================================
PRINT '========== CONSULTA 9: PRODUCTOS CON BAJO STOCK =========='
GO
SELECT 
    pr.nombre_producto AS Producto,
    pr.stock_minimo AS StockMinimo,
    i.stock_actual AS StockActual,
    s.nombre_sucursal AS Sucursal
FROM productos pr
INNER JOIN inventario i ON pr.id_producto = i.id_producto
INNER JOIN sucursales s ON i.id_sucursal = s.id_sucursal
WHERE i.stock_actual < pr.stock_minimo
ORDER BY i.stock_actual ASC;
GO

-- ============================================================================
-- CONSULTA 10: PEDIDOS CON PAGOS PENDIENTES
-- ============================================================================
PRINT '========== CONSULTA 10: PEDIDOS CON PAGOS PENDIENTES =========='
GO
SELECT 
    p.id_pedido AS IdPedido,
    c.nombre_cliente AS Cliente,
    ISNULL(pg.estado_pago, 'Sin Pago') AS EstadoPago,
    SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)) AS Monto
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
LEFT JOIN pagos pg ON p.id_pedido = pg.id_pedido
WHERE pg.estado_pago IN ('Pendiente', 'Cancelado') OR pg.estado_pago IS NULL
GROUP BY p.id_pedido, c.nombre_cliente, pg.estado_pago
ORDER BY p.id_pedido DESC;
GO

-- ============================================================================
-- CONSULTA 11: PEDIDOS CON DEVOLUCIONES
-- ============================================================================
PRINT '========== CONSULTA 11: PEDIDOS CON DEVOLUCIONES =========='
GO
SELECT 
    p.id_pedido AS IdPedido,
    c.nombre_cliente AS Cliente,
    pr.nombre_producto AS Producto,
    d.cantidad_devuelta AS Cantidad,
    d.motivo AS Motivo
FROM devoluciones d
INNER JOIN pedidos p ON d.id_pedido = p.id_pedido
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN productos pr ON d.id_producto = pr.id_producto
ORDER BY p.id_pedido DESC;
GO

PRINT '========== FIN DE CONSULTAS =========='
GO