
CREATE DATABASE IF NOT EXISTS proyectob;
USE proyectob;

-- TABLA CLIENTE
CREATE TABLE CLIENTE(
  cedula CHAR(10) PRIMARY KEY,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correoElectronico VARCHAR(100) DEFAULT NULL,
  telefono CHAR(10) DEFAULT NULL,
  ubicacion VARCHAR(50) NOT NULL,
  aceptaTerminos BOOLEAN NOT NULL
);

-- TABLA ADMINISTRADOR
CREATE TABLE ADMINISTRADOR(
  administradorID INT PRIMARY KEY AUTO_INCREMENT,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correoElectronico VARCHAR(100) NOT NULL
);

-- TABLA COURIER
CREATE TABLE COURIER(
  courierID INT PRIMARY KEY AUTO_INCREMENT,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  cantidadEnvios INT DEFAULT 0 CHECK (cantidadEnvios >= 0),
  codigoEmpresa VARCHAR(20) NOT NULL
);

-- TABLA SOPORTE
CREATE TABLE SOPORTE(
  soporteID INT PRIMARY KEY AUTO_INCREMENT,
  correoElectronico VARCHAR(100),
  administradorID INT,
  FOREIGN KEY (administradorID) REFERENCES ADMINISTRADOR(administradorID)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX idx_soporte_administradorID ON SOPORTE(administradorID);

-- TABLA TRANSACCION
CREATE TABLE TRANSACCION(
  transaccionID INT PRIMARY KEY AUTO_INCREMENT,
  valorTotal FLOAT NOT NULL,
  estado VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  clienteID CHAR(10) NOT NULL,
  FOREIGN KEY (clienteID) REFERENCES CLIENTE(cedula)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_transaccion_clienteID ON TRANSACCION(clienteID);

-- TABLA ARTESANO
CREATE TABLE ARTESANO(
  ruc VARCHAR(13) PRIMARY KEY,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correoElectronico VARCHAR(100) DEFAULT NULL,
  telefono VARCHAR(15) NOT NULL,
  aceptaTerminos BOOLEAN NOT NULL,
  administradorID INT,
  FOREIGN KEY (administradorID) REFERENCES ADMINISTRADOR(administradorID)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX idx_artesano_administradorID ON ARTESANO(administradorID);

-- TABLA PAGO
CREATE TABLE PAGO(
  pagoID INT PRIMARY KEY AUTO_INCREMENT,
  tipo ENUM('DEPOSITO','TRANSFERENCIA') NOT NULL,
  valorPago FLOAT NOT NULL,
  fecha DATE NOT NULL,
  metodoPago VARCHAR(30) NOT NULL,
  transaccionID INT,
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_pago_transaccionID ON PAGO(transaccionID);

-- TABLA PEDIDO
CREATE TABLE PEDIDO(
  pedidoID INT PRIMARY KEY AUTO_INCREMENT,
  fechaEvento DATE NOT NULL,
  direccionDestino VARCHAR(100) NOT NULL,
  estado VARCHAR(30) NOT NULL,
  estadoGPS VARCHAR(50) NOT NULL,
  transaccionID INT NOT NULL,
  courierID INT NOT NULL,
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (courierID) REFERENCES COURIER(courierID)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX idx_pedido_transaccionID ON PEDIDO(transaccionID);
CREATE INDEX idx_pedido_courierID ON PEDIDO(courierID);

-- TABLA PRODUCTO
CREATE TABLE PRODUCTO(
  productoID INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  descripcion CHAR(60) DEFAULT NULL,
  categoria VARCHAR(50) NOT NULL,
  precio FLOAT NOT NULL CHECK (precio >= 0),
  porcentajeIVA FLOAT NOT NULL CHECK (porcentajeIVA >= 0),
  stock INT DEFAULT 0 CHECK (stock >= 0),
  artesanoID VARCHAR(13),
  estadoRevision VARCHAR(20),
  administradorID INT,
  FOREIGN KEY (artesanoID) REFERENCES ARTESANO(ruc)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (administradorID) REFERENCES ADMINISTRADOR(administradorID)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX idx_producto_artesanoID ON PRODUCTO(artesanoID);
CREATE INDEX idx_producto_administradorID ON PRODUCTO(administradorID);

-- TABLA DETALLES_PXT
CREATE TABLE DETALLES_PXT(
  productoID INT,
  transaccionID INT,
  cantidad INT CHECK (cantidad > 0),
  subtotal FLOAT CHECK (subtotal >= 0),
  PRIMARY KEY(productoID, transaccionID),
  FOREIGN KEY (productoID) REFERENCES PRODUCTO(productoID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_detalles_transaccionID ON DETALLES_PXT(transaccionID);

-- TABLA FOTO
CREATE TABLE FOTO(
  fotoID INT PRIMARY KEY AUTO_INCREMENT,
  formato VARCHAR(10) NOT NULL,
  peso INT CHECK (peso >= 0),
  url VARCHAR(255),
  productoID INT,
  FOREIGN KEY (productoID) REFERENCES PRODUCTO(productoID)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX idx_foto_productoID ON FOTO(productoID);

-- TABLA DEVOLUCION
CREATE TABLE DEVOLUCION(
  devolucionID INT PRIMARY KEY AUTO_INCREMENT,
  fechaInicio DATE NOT NULL,
  fechaFin DATE NOT NULL,
  tipo ENUM('PRUEBA','DANO') NOT NULL,
  motivo VARCHAR(20) DEFAULT NULL,
  comentario CHAR(60) DEFAULT NULL,
  productoID INT,
  soporteID INT,
  transaccionID INT,
  clienteID CHAR(10),
  FOREIGN KEY (productoID) REFERENCES PRODUCTO(productoID)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (soporteID) REFERENCES SOPORTE(soporteID)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (clienteID) REFERENCES CLIENTE(cedula)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX idx_devolucion_productoID ON DEVOLUCION(productoID);
CREATE INDEX idx_devolucion_soporteID ON DEVOLUCION(soporteID);
CREATE INDEX idx_devolucion_transaccionID ON DEVOLUCION(transaccionID);
CREATE INDEX idx_devolucion_clienteID ON DEVOLUCION(clienteID);

-- ===========================
-- Datos de ejemplo (INSERTs)
-- ===========================

-- INSERT en CLIENTE
INSERT INTO CLIENTE (cedula, nombres, apellidos, correoElectronico, telefono, ubicacion, aceptaTerminos) VALUES
('0912345678', 'María Elena', 'González Pérez', 'maria.gonzalez@email.com', '0987654321', 'Guayaquil Norte', true),
('0923456789', 'Carlos Alberto', 'Rodríguez Silva', 'carlos.rodriguez@email.com', '0976543210', 'Quito Centro', true),
('0934567890', 'Ana Lucía', 'Martínez López', 'ana.martinez@email.com', '0965432109', 'Cuenca Histórico', true),
('0945678901', 'Diego Fernando', 'Herrera Castro', 'diego.herrera@email.com', '0954321098', 'Ambato Centro', false),
('0956789012', 'Patricia Isabel', 'Vásquez Moreno', 'patricia.vasquez@email.com', '0943210987', 'Machala Sur', true),
('0967890123', 'Roberto Miguel', 'Torres Jiménez', 'roberto.torres@email.com', '0932109876', 'Portoviejo Norte', true),
('0978901234', 'Sofía Alejandra', 'Ruiz Castillo', 'sofia.ruiz@email.com', '0921098765', 'Loja Centro', true),
('0989012345', 'Andrés Felipe', 'Morales Díaz', 'andres.morales@email.com', '0910987654', 'Riobamba Este', false),
('0990123456', 'Gabriela Beatriz', 'Salazar Vargas', 'gabriela.salazar@email.com', '0909876543', 'Esmeraldas Costa', true),
('0901234567', 'Fernando José', 'Cevallos Ramos', 'fernando.cevallos@email.com', '0998765432', 'Ibarra Norte', true);

-- INSERT en ADMINISTRADOR
INSERT INTO ADMINISTRADOR (nombres, apellidos, correoElectronico) VALUES
('Luis Carlos', 'Mendoza Flores', 'luis.mendoza@proyectob.com'),
('Carmen Rosa', 'Espinoza García', 'carmen.espinoza@proyectob.com'),
('Miguel Ángel', 'Palacios Vera', 'miguel.palacios@proyectob.com'),
('Sandra Patricia', 'Villacrés Ortiz', 'sandra.villacres@proyectob.com'),
('Javier Eduardo', 'Coello Zambrano', 'javier.coello@proyectob.com'),
('Mónica Esperanza', 'Navas Santamaría', 'monica.navas@proyectob.com'),
('Ricardo Antonio', 'Aguirre Moreira', 'ricardo.aguirre@proyectob.com'),
('Elena Cristina', 'Burgos Lara', 'elena.burgos@proyectob.com'),
('Daniel Sebastián', 'Chávez Molina', 'daniel.chavez@proyectob.com'),
('Verónica Alejandra', 'Paredes Núñez', 'veronica.paredes@proyectob.com');

-- INSERT en COURIER
INSERT INTO COURIER (nombres, apellidos, cantidadEnvios, codigoEmpresa) VALUES
('Juan Carlos', 'Pérez Aguirre', 25, 'EMP001'),
('María Fernanda', 'López Vargas', 32, 'EMP002'),
('Pedro Antonio', 'Ramírez Cruz', 18, 'EMP001'),
('Lucía Esperanza', 'Santos Delgado', 41, 'EMP003'),
('José Miguel', 'Herrera Solís', 29, 'EMP002'),
('Carolina Isabel', 'Mejía Cárdenas', 36, 'EMP001'),
('Héctor Fabián', 'Ordóñez Peña', 22, 'EMP003'),
('Paola Alejandra', 'Vega Mendoza', 38, 'EMP002'),
('Mauricio Andrés', 'Campos Rivera', 27, 'EMP001'),
('Daniela Cristina', 'Morocho Tello', 33, 'EMP003');

-- INSERT en SOPORTE
INSERT INTO SOPORTE (correoElectronico, administradorID) VALUES
('soporte1@proyectob.com', 1),
('soporte2@proyectob.com', 2),
('soporte3@proyectob.com', 3),
('soporte4@proyectob.com', 4),
('soporte5@proyectob.com', 5),
('soporte6@proyectob.com', 1),
('soporte7@proyectob.com', 2),
('soporte8@proyectob.com', 3),
('soporte9@proyectob.com', 4),
('soporte10@proyectob.com', 5);

-- INSERT en ARTESANO
INSERT INTO ARTESANO (ruc, nombres, apellidos, correoElectronico, telefono, aceptaTerminos, administradorID) VALUES
('1234567890', 'Rosa María', 'Chamba Quishpe', 'rosa.chamba@artesano.com', '0987123456', true, 1),
('1345678901', 'Manuel Eugenio', 'Toapanta Iza', 'manuel.toapanta@artesano.com', '0976234567', true, 2),
('1456789012', 'Carmen Dolores', 'Pilataxi Saca', 'carmen.pilataxi@artesano.com', '0965345678', false, 3),
('1567890123', 'Washington Luis', 'Morocho Silva', 'washington.morocho@artesano.com', '0954456789', true, 1),
('1678901234', 'Blanca Esperanza', 'Ushiña Caiza', 'blanca.ushina@artesano.com', '0943567890', true, 2),
('1789012345', 'Segundo Miguel', 'Chicaiza Ante', 'segundo.chicaiza@artesano.com', '0932678901', true, 4),
('1890123456', 'María Inés', 'Quinapanta Taco', 'maria.quinapanta@artesano.com', '0921789012', true, 3),
('1901234567', 'Alberto Ramón', 'Chisaguano Ante', 'alberto.chisaguano@artesano.com', '0910890123', false, 5),
('2012345678', 'Luz Marina', 'Chuquitarco Ante', 'luz.chuquitarco@artesano.com', '0909901234', true, 1),
('1357924680', 'Víctor Hugo', 'Sailema Taco', 'victor.sailema@artesano.com', '0998012345', true, 4);

-- INSERT en TRANSACCION
INSERT INTO TRANSACCION (valorTotal, estado, fecha, clienteID) VALUES
(125.50, 'COMPLETADA', '2025-01-15', '0912345678'),
(89.75, 'PENDIENTE', '2025-01-18', '0923456789'),
(234.20, 'COMPLETADA', '2025-01-20', '0934567890'),
(156.80, 'CANCELADA', '2025-01-22', '0945678901'),
(98.30, 'COMPLETADA', '2025-01-25', '0956789012'),
(187.45, 'PROCESANDO', '2025-01-28', '0967890123'),
(76.90, 'COMPLETADA', '2025-02-01', '0978901234'),
(298.15, 'PENDIENTE', '2025-02-03', '0989012345'),
(145.60, 'COMPLETADA', '2025-02-05', '0990123456'),
(112.35, 'PROCESANDO', '2025-02-08', '0901234567');

-- INSERT en PAGO
INSERT INTO PAGO (tipo, valorPago, fecha, metodoPago, transaccionID) VALUES
('TRANSFERENCIA', 125.50, '2025-01-15', 'Tarjeta de Crédito', 1),
('DEPOSITO', 89.75, '2025-01-18', 'Efectivo', 2),
('TRANSFERENCIA', 234.20, '2025-01-20', 'Transferencia Bancaria', 3),
('DEPOSITO', 156.80, '2025-01-22', 'Tarjeta de Débito', 4),
('TRANSFERENCIA', 98.30, '2025-01-25', 'PayPal', 5),
('DEPOSITO', 187.45, '2025-01-28', 'Efectivo', 6),
('TRANSFERENCIA', 76.90, '2025-02-01', 'Tarjeta de Crédito', 7),
('DEPOSITO', 298.15, '2025-02-03', 'Transferencia Bancaria', 8),
('TRANSFERENCIA', 145.60, '2025-02-05', 'Tarjeta de Débito', 9),
('DEPOSITO', 112.35, '2025-02-08', 'PayPal', 10);

-- INSERT en PEDIDO
INSERT INTO PEDIDO (fechaEvento, direccionDestino, estado, estadoGPS, transaccionID, courierID) VALUES
('2025-01-16', 'Av. 9 de Octubre y Malecón, Guayaquil', 'ENTREGADO', 'Ubicación: Destino', 1, 1),
('2025-01-19', 'Av. Amazonas N24-03, Quito', 'EN_TRANSITO', 'Ubicación: Carretera', 2, 2),
('2025-01-21', 'Calle Larga 7-07, Cuenca', 'ENTREGADO', 'Ubicación: Destino', 3, 3),
('2025-01-23', 'Av. Cevallos 08-40, Ambato', 'CANCELADO', 'Ubicación: Origen', 4, 4),
('2025-01-26', 'Av. Rocafuerte y 25 de Junio, Machala', 'ENTREGADO', 'Ubicación: Destino', 5, 5),
('2025-01-29', 'Av. Universitaria, Portoviejo', 'PREPARANDO', 'Ubicación: Almacén', 6, 6),
('2025-02-02', 'Calle Bolívar 14-83, Loja', 'ENTREGADO', 'Ubicación: Destino', 7, 7),
('2025-02-04', 'Av. Daniel León Borja, Riobamba', 'EN_TRANSITO', 'Ubicación: Carretera', 8, 8),
('2025-02-06', 'Malecón Las Palmas, Esmeraldas', 'ENTREGADO', 'Ubicación: Destino', 9, 9),
('2025-02-09', 'Av. Teodoro Gómez, Ibarra', 'PREPARANDO', 'Ubicación: Almacén', 10, 10);

-- INSERT en PRODUCTO
INSERT INTO PRODUCTO (nombre, descripcion, categoria, precio, porcentajeIVA, stock, artesanoID, estadoRevision, administradorID) VALUES
('Jarrón de cerámica', 'Jarrón artesanal pintado a mano', 'Decoración', 25.50, 12.0, 50, '1234567890', 'APROBADO', 1),
('Collar de plata', 'Collar con diseño tradicional', 'Joyería', 40.00, 12.0, 30, '1345678901', 'APROBADO', 2),
('Manta de lana', 'Manta tejida a mano', 'Textiles', 60.00, 12.0, 20, '1456789012', 'PENDIENTE', 3),
('Cuadro en madera', 'Cuadro tallado artesanalmente', 'Arte', 45.75, 12.0, 15, '1567890123', 'APROBADO', 4),
('Bolso de cuero', 'Bolso artesanal de cuero', 'Accesorios', 55.00, 12.0, 10, '1678901234', 'APROBADO', 5),
('Figura de cerámica', 'Figura decorativa pintada', 'Decoración', 30.00, 12.0, 40, '1789012345', 'PENDIENTE', 1),
('Pulsera de cuentas', 'Pulsera con cuentas de colores', 'Joyería', 18.00, 12.0, 25, '1890123456', 'APROBADO', 2),
('Bufanda tejida', 'Bufanda de lana natural', 'Textiles', 22.00, 12.0, 35, '1901234567', 'APROBADO', 3),
('Escultura en madera', 'Escultura tallada a mano', 'Arte', 75.00, 12.0, 12, '2012345678', 'APROBADO', 4),
('Cartera de cuero', 'Cartera hecha a mano', 'Accesorios', 65.00, 12.0, 18, '1357924680', 'PENDIENTE', 5);

-- INSERT en DETALLES_PXT
INSERT INTO DETALLES_PXT (productoID, transaccionID, cantidad, subtotal) VALUES
(1, 1, 2, 51.00),
(2, 1, 1, 40.00),
(3, 2, 1, 60.00),
(4, 3, 1, 45.75),
(5, 4, 1, 55.00),
(6, 5, 2, 60.00),
(7, 6, 3, 54.00),
(8, 7, 2, 44.00),
(9, 8, 1, 75.00),
(10, 9, 1, 65.00);

-- INSERT en FOTO
INSERT INTO FOTO (formato, peso, url, productoID) VALUES
('jpg', 2048, 'http://example.com/img1.jpg', 1),
('png', 1024, 'http://example.com/img2.png', 2),
('jpg', 512, 'http://example.com/img3.jpg', 3),
('png', 256, 'http://example.com/img4.png', 4),
('jpg', 2048, 'http://example.com/img5.jpg', 5),
('png', 1024, 'http://example.com/img6.png', 6),
('jpg', 512, 'http://example.com/img7.jpg', 7),
('png', 256, 'http://example.com/img8.png', 8),
('jpg', 2048, 'http://example.com/img9.jpg', 9),
('png', 1024, 'http://example.com/img10.png', 10);

-- INSERT en DEVOLUCION
INSERT INTO DEVOLUCION (fechaInicio, fechaFin, tipo, motivo, comentario, productoID, soporteID, transaccionID, clienteID) VALUES
('2025-02-10', '2025-02-15', 'PRUEBA', 'Talla incorrecta', 'El producto no quedó bien', 1, 1, 1, '0912345678'),
('2025-02-12', '2025-02-17', 'DANO', 'Producto roto', 'Daño en envío', 2, 2, 2, '0923456789'),
('2025-02-14', '2025-02-19', 'PRUEBA', 'Color diferente', 'No es el color esperado', 3, 3, 3, '0934567890'),
('2025-02-16', '2025-02-21', 'DANO', 'Defecto', 'Defecto de fábrica', 4, 4, 4, '0945678901'),
('2025-02-18', '2025-02-23', 'PRUEBA', 'No es lo que esperaba', 'Cambio de opinión', 5, 5, 5, '0956789012'),
('2025-02-20', '2025-02-25', 'DANO', 'Mal embalaje', 'Daño por transporte', 6, 6, 6, '0967890123'),
('2025-02-22', '2025-02-27', 'PRUEBA', 'Tamaño pequeño', 'No me queda', 7, 7, 7, '0978901234'),
('2025-02-24', '2025-02-29', 'DANO', 'Roto', 'Producto llegó roto', 8, 8, 8, '0989012345'),
('2025-02-26', '2025-03-03', 'PRUEBA', 'No era lo esperado', 'Cambios de diseño', 9, 9, 9, '0990123456'),
('2025-02-28', '2025-03-05', 'DANO', 'Daño en costuras', 'Mal acabado', 10, 10, 10, '0901234567');

-- ===========================
-- CRUD
-- ===========================

-- Seleccionar todos los clientes
SELECT * FROM CLIENTE;

-- Actualizar stock de un producto
UPDATE PRODUCTO SET stock = stock - 1 WHERE productoID = 1;

-- Eliminar un pedido (borrará en cascada la transacción si se configura así)
DELETE FROM PEDIDO WHERE pedidoID = 10;

-- Insertar un nuevo producto
INSERT INTO PRODUCTO (nombre, descripcion, categoria, precio, porcentajeIVA, stock, artesanoID, estadoRevision, administradorID)
VALUES ('Nuevo Producto', 'Descripción ejemplo', 'Categoría', 99.99, 12.0, 100, '1234567890', 'PENDIENTE', 1);

