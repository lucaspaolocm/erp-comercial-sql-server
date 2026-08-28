-- PASO 5: RESPONDER LAS 10 PREGUNTAS DE ANÁLISIS (VERSIÓN CORREGIDA)
USE ERPComercial;
GO

PRINT '========== RESPUESTAS A LAS PREGUNTAS DE ANÁLISIS =========='
GO

-- ============================================================================
-- PREGUNTA 1: ¿Qué cliente realizó el mayor total de compras?
-- ============================================================================
PRINT '--- P1: Cliente con mayor total de compras ---'
GO
SELECT TOP 1
    c.nombre_cliente AS Cliente,
    c.segmento AS Segmento,
    COUNT(DISTINCT p.id_pedido) AS TotalPedidos,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)), 0) AS TotalCompras
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.nombre_cliente, c.segmento
ORDER BY TotalCompras DESC;
GO

-- ============================================================================
-- PREGUNTA 2: ¿Qué vendedor generó más ventas?
-- ============================================================================
PRINT '--- P2: Vendedor con más ventas ---'
GO
SELECT TOP 1
    v.nombre_vendedor AS Vendedor,
    s.nombre_sucursal AS Sucursal,
    COUNT(DISTINCT p.id_pedido) AS TotalPedidos,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)), 0) AS TotalVentas
FROM vendedores v
INNER JOIN sucursales s ON v.id_sucursal = s.id_sucursal
LEFT JOIN pedidos p ON v.id_vendedor = p.id_vendedor
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY v.nombre_vendedor, s.nombre_sucursal
ORDER BY TotalVentas DESC;
GO

-- ============================================================================
-- PREGUNTA 3: ¿Qué producto tuvo más unidades vendidas?
-- ============================================================================
PRINT '--- P3: Producto con más unidades vendidas ---'
GO
SELECT TOP 1
    pr.nombre_producto AS Producto,
    ca.nombre_categoria AS Categoria,
    ISNULL(SUM(dp.cantidad), 0) AS TotalUnidadesVendidas,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario), 0) AS VentasTotal
FROM productos pr
INNER JOIN categorias ca ON pr.id_categoria = ca.id_categoria
LEFT JOIN detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY pr.nombre_producto, ca.nombre_categoria
ORDER BY TotalUnidadesVendidas DESC;
GO

-- ============================================================================
-- PREGUNTA 4: ¿Qué pedido tuvo el mayor monto vendido?
-- ============================================================================
PRINT '--- P4: Pedido con mayor monto vendido ---'
GO
SELECT TOP 1
    p.id_pedido AS IdPedido,
    p.fecha_pedido AS Fecha,
    c.nombre_cliente AS Cliente,
    v.nombre_vendedor AS Vendedor,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)), 0) AS MontoTotal
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN vendedores v ON p.id_vendedor = v.id_vendedor
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY p.id_pedido, p.fecha_pedido, c.nombre_cliente, v.nombre_vendedor
ORDER BY MontoTotal DESC;
GO

-- ============================================================================
-- PREGUNTA 5: ¿Qué canal de venta generó más ingresos?
-- ============================================================================
PRINT '--- P5: Canal de venta con más ingresos ---'
GO
SELECT TOP 1
    p.canal_venta AS CanalVenta,
    COUNT(DISTINCT p.id_pedido) AS TotalPedidos,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)), 0) AS IngresoTotal
FROM pedidos p
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY p.canal_venta
ORDER BY IngresoTotal DESC;
GO

-- ============================================================================
-- PREGUNTA 6: ¿Qué sucursal realizó más ventas?
-- ============================================================================
PRINT '--- P6: Sucursal con más ventas ---'
GO
SELECT TOP 1
    s.nombre_sucursal AS Sucursal,
    s.ciudad AS Ciudad,
    COUNT(DISTINCT p.id_pedido) AS TotalPedidos,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)), 0) AS VentasTotal
FROM sucursales s
LEFT JOIN pedidos p ON s.id_sucursal = p.id_sucursal
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY s.nombre_sucursal, s.ciudad
ORDER BY VentasTotal DESC;
GO

-- ============================================================================
-- PREGUNTA 7: ¿Qué productos presentan stock crítico?
-- ============================================================================
PRINT '--- P7: Productos con stock crítico ---'
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
-- PREGUNTA 8: ¿Qué pedidos siguen pendientes o cancelados?
-- ============================================================================
PRINT '--- P8: Pedidos pendientes o cancelados ---'
GO
SELECT 
    p.id_pedido AS IdPedido,
    p.fecha_pedido AS Fecha,
    c.nombre_cliente AS Cliente,
    v.nombre_vendedor AS Vendedor,
    p.estado_pedido AS Estado,
    ISNULL(SUM(dp.cantidad * dp.precio_unitario * (1 - dp.descuento)), 0) AS Monto
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN vendedores v ON p.id_vendedor = v.id_vendedor
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
WHERE p.estado_pedido IN ('Pendiente', 'Cancelado')
GROUP BY p.id_pedido, p.fecha_pedido, c.nombre_cliente, v.nombre_vendedor, p.estado_pedido
ORDER BY p.id_pedido DESC;
GO

-- ============================================================================
-- PREGUNTA 9: ¿Qué pedidos tuvieron devoluciones?
-- ============================================================================
PRINT '--- P9: Pedidos con devoluciones ---'
GO
SELECT 
    p.id_pedido AS IdPedido,
    c.nombre_cliente AS Cliente,
    pr.nombre_producto AS Producto,
    d.cantidad_devuelta AS CantidadDevuelta,
    d.fecha_devolucion AS FechaDevolucion,
    d.motivo AS Motivo
FROM devoluciones d
INNER JOIN pedidos p ON d.id_pedido = p.id_pedido
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN productos pr ON d.id_producto = pr.id_producto
ORDER BY p.id_pedido DESC;
GO

-- ============================================================================
-- PREGUNTA 10: ¿Cuántos pagos siguen pendientes o cancelados?
-- ============================================================================
PRINT '--- P10: Resumen de pagos pendientes/cancelados ---'
GO
SELECT 
    pg.estado_pago AS EstadoPago,
    COUNT(*) AS TotalRegistros,
    ISNULL(SUM(pg.monto_pagado), 0) AS MontoRegistrado
FROM pagos pg
WHERE pg.estado_pago IN ('Pendiente', 'Cancelado')
GROUP BY pg.estado_pago
ORDER BY pg.estado_pago;
GO

PRINT '========== FIN DE ANÁLISIS =========='
GO