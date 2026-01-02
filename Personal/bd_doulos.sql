-- 1. Habilitar extensión para UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Tabla de Comercios (Multi-tenant)
CREATE TABLE comercios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(150) NOT NULL,
    nit_rut VARCHAR(50),
    email_contacto VARCHAR(100),
    configuracion JSONB, -- Config como moneda, logo, etc.
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabla de Categorías
CREATE TABLE categorias (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    comercio_id UUID NOT NULL REFERENCES comercios(id) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    CONSTRAINT fk_comercio_cat FOREIGN KEY (comercio_id) REFERENCES comercios(id)
);

-- 4. Tabla de Productos (Agnóstica al tipo de negocio)
CREATE TABLE productos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    comercio_id UUID NOT NULL REFERENCES comercios(id) ON DELETE CASCADE,
    categoria_id UUID REFERENCES categorias(id) ON DELETE SET NULL,
    nombre VARCHAR(200) NOT NULL,
    sku VARCHAR(50), -- Código único de producto
    precio_base DECIMAL(12, 2) NOT NULL,
    stock_actual INTEGER DEFAULT 0,
    -- Aquí guardamos "color", "sabor", "talla", "material", etc.
    caracteristicas JSONB, 
    imagen_url TEXT,
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tabla de Clientes
CREATE TABLE clientes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    comercio_id UUID NOT NULL REFERENCES comercios(id) ON DELETE CASCADE,
    nombre_completo VARCHAR(200) NOT NULL,
    email VARCHAR(150),
    telefono VARCHAR(20),
    direccion_envio TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Tabla de Pedidos (Cabecera)
CREATE TABLE pedidos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    comercio_id UUID NOT NULL REFERENCES comercios(id) ON DELETE CASCADE,
    cliente_id UUID REFERENCES clientes(id) ON DELETE SET NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(50) DEFAULT 'pendiente', -- pendiente, pagado, enviado, cancelado
    metodo_pago VARCHAR(50),
    total DECIMAL(12, 2) NOT NULL,
    notas TEXT
);

-- 7. Tabla Detalle de Pedidos (Líneas de venta)
CREATE TABLE detalle_pedidos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    pedido_id UUID NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
    producto_id UUID REFERENCES productos(id) ON DELETE SET NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario_historico DECIMAL(12, 2) NOT NULL, -- Se guarda el precio al momento de la venta
    subtotal DECIMAL(12, 2) NOT NULL
);

-- 8. Índices para mejorar velocidad de búsqueda
CREATE INDEX idx_productos_comercio ON productos(comercio_id);
CREATE INDEX idx_pedidos_comercio ON pedidos(comercio_id);
CREATE INDEX idx_productos_caracteristicas ON productos USING GIN (caracteristicas);