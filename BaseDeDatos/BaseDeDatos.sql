CREATE DATABASE IF NOT EXISTS proyectob;
USE proyectob;

CREATE TABLE CLIENTE(
  cedula CHAR(10) PRIMARY KEY,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correoElectronico VARCHAR(100) DEFAULT NULL,
  telefono CHAR(10) DEFAULT NULL,
  ubicacion VARCHAR(50) NOT NULL,
  aceptaTermino BOOLEAN NOT NULL
);

CREATE TABLE ADMINISTRADOR(
  administradorID INT PRIMARY KEY AUTO_INCREMENT,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correoElectronico VARCHAR(100) NOT NULL
);

CREATE TABLE COURIER(
  courierID INT PRIMARY KEY,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  cantidadEnvios INT DEFAULT 0,
  codigoEmpresa VARCHAR(20) NOT NULL
);

CREATE TABLE SOPORTE(
  soporteID INT PRIMARY KEY,
  correoElectronico VARCHAR(100),
  administradorID INT,
  FOREIGN KEY (administradorID) REFERENCES ADMINISTRADOR(administradorID)
);

CREATE TABLE TRANSACCION(
  transaccionID INT PRIMARY KEY,
  valorTotal FLOAT NOT NULL,
  estado VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  clienteID CHAR(10) NOT NULL,
  FOREIGN KEY (clienteID) REFERENCES CLIENTE(cedula)
);

CREATE TABLE ARTESANO(
  ruc VARCHAR(13) PRIMARY KEY,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correoElectronico VARCHAR(100) DEFAULT NULL,
  telefono VARCHAR(15) NOT NULL,
  aceptaTerminos BOOLEAN NOT NULL,
  administradorID INT,
  FOREIGN KEY (administradorID) REFERENCES ADMINISTRADOR(administradorID)
);

CREATE TABLE PAGO(
  pagoID INT PRIMARY KEY,
  tipo ENUM('DEPOSITO','TRANSFERENCIA'),
  valorPago FLOAT NOT NULL,
  fecha DATE NOT NULL,
  metodoPago VARCHAR(30) NOT NULL,
  transaccionID INT,
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID)
);

CREATE TABLE PEDIDO(
  pedidoID INT PRIMARY KEY,
  fechaEvento DATE NOT NULL,
  direccionDestino VARCHAR(100) NOT NULL,
  estado VARCHAR(30) NOT NULL,
  estadoGPS VARCHAR(50) NOT NULL,
  transaccionID INT NOT NULL,
  courierID INT NOT NULL,
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID),
  FOREIGN KEY (courierID) REFERENCES COURIER(courierID)
);

CREATE TABLE PRODUCTO(
  productoID INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  descripcion CHAR(60) DEFAULT NULL,
  categoria VARCHAR(50) NOT NULL,
  precio FLOAT NOT NULL,
  porcentajeIVA FLOAT NOT NULL,
  stock INT DEFAULT 0,
  artesanoID VARCHAR(13),
  estadoRevision VARCHAR(20),
  administradorID INT,
  FOREIGN KEY (artesanoID) REFERENCES ARTESANO(ruc),
  FOREIGN KEY(administradorID) REFERENCES ADMINISTRADOR(administradorID)
);

CREATE TABLE DETALLES_PXT(
  productoID INT,
  transaccionID INT,
  cantidad INT,
  subtotal FLOAT,
  PRIMARY KEY(productoID, transaccionID),
  FOREIGN KEY (productoID) REFERENCES PRODUCTO(productoID),
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID)
);

CREATE TABLE FOTO(
  fotoID INT PRIMARY KEY,
  formato VARCHAR(10) NOT NULL,
  peso INT,
  url VARCHAR(255),
  productoID INT,
  FOREIGN KEY (productoID) REFERENCES PRODUCTO(productoID)
);

CREATE TABLE DEVOLUCION(
  devolucionID INT PRIMARY KEY,
  fechaInicio DATE NOT NULL,
  fechaFin DATE NOT NULL,
  tipo ENUM('PRUEBA','DANO'),
  motivo VARCHAR(20) DEFAULT NULL,
  comentario CHAR(60) DEFAULT NULL,
  productoID INT,
  soporteID INT,
  transaccionID INT,
  clienteID CHAR(10),
  FOREIGN KEY (productoID) REFERENCES PRODUCTO(productoID),
  FOREIGN KEY (soporteID) REFERENCES SOPORTE(soporteID),
  FOREIGN KEY (transaccionID) REFERENCES TRANSACCION(transaccionID),
  FOREIGN KEY (clienteID) REFERENCES CLIENTE(cedula)
 
-- CRUD
-- TABLA CLIENTE (10 registros)
INSERT INTO CLIENTE (cedula, nombres, apellidos, correoElectronico, telefono, ubicacion, aceptaTermino) VALUES
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

-- CREATE
INSERT INTO CLIENTE (cedula, nombres, apellidos, correoElectronico, telefono, ubicacion, aceptaTermino)
VALUES ('0999999999', 'Nombre', 'Apellido', 'correo@ejemplo.com', '0999999999', 'Ubicación Ejemplo', true);

-- READ (todos)
SELECT * FROM CLIENTE;

-- READ (uno)
SELECT * FROM CLIENTE WHERE cedula = '0999999999';

-- UPDATE
UPDATE CLIENTE
SET nombres = 'Nuevo Nombre', telefono = '0987654321'
WHERE cedula = '0999999999';

-- DELETE
DELETE FROM CLIENTE WHERE cedula = '0999999999';


-- TABLA ADMINISTRADOR (10 registros)
INSERT INTO ADMINISTRADOR (administradorID, nombres, apellidos, correoElectronico) VALUES
(1, 'Luis Carlos', 'Mendoza Flores', 'luis.mendoza@proyectob.com'),
(2, 'Carmen Rosa', 'Espinoza García', 'carmen.espinoza@proyectob.com'),
(3, 'Miguel Ángel', 'Palacios Vera', 'miguel.palacios@proyectob.com'),
(4, 'Sandra Patricia', 'Villacrés Ortiz', 'sandra.villacres@proyectob.com'),
(5, 'Javier Eduardo', 'Coello Zambrano', 'javier.coello@proyectob.com'),
(6, 'Mónica Esperanza', 'Navas Santamaría', 'monica.navas@proyectob.com'),
(7, 'Ricardo Antonio', 'Aguirre Moreira', 'ricardo.aguirre@proyectob.com'),
(8, 'Elena Cristina', 'Burgos Lara', 'elena.burgos@proyectob.com'),
(9, 'Daniel Sebastián', 'Chávez Molina', 'daniel.chavez@proyectob.com'),
(10, 'Verónica Alejandra', 'Paredes Núñez', 'veronica.paredes@proyectob.com');

-- CREATE
INSERT INTO ADMINISTRADOR (nombres, apellidos, correoElectronico)
VALUES ('Nuevo', 'Administrador', 'nuevo.admin@ejemplo.com');

-- READ (todos)
SELECT * FROM ADMINISTRADOR;

-- READ (uno)
SELECT * FROM ADMINISTRADOR WHERE administradorID = 1;

-- UPDATE
UPDATE ADMINISTRADOR
SET correoElectronico = 'actualizado@ejemplo.com'
WHERE administradorID = 1;

-- DELETE
DELETE FROM ADMINISTRADOR WHERE administradorID = 1;



-- TABLA COURIER (10 registros)
INSERT INTO COURIER (courierID, nombres, apellidos, cantidadEnvios, codigoEmpresa) VALUES
(1, 'Juan Carlos', 'Pérez Aguirre', 25, 'EMP001'),
(2, 'María Fernanda', 'López Vargas', 32, 'EMP002'),
(3, 'Pedro Antonio', 'Ramírez Cruz', 18, 'EMP001'),
(4, 'Lucía Esperanza', 'Santos Delgado', 41, 'EMP003'),
(5, 'José Miguel', 'Herrera Solís', 29, 'EMP002'),
(6, 'Carolina Isabel', 'Mejía Cárdenas', 36, 'EMP001'),
(7, 'Héctor Fabián', 'Ordóñez Peña', 22, 'EMP003'),
(8, 'Paola Alejandra', 'Vega Mendoza', 38, 'EMP002'),
(9, 'Mauricio Andrés', 'Campos Rivera', 27, 'EMP001'),
(10, 'Daniela Cristina', 'Morocho Tello', 33, 'EMP003');


-- CREATE
INSERT INTO COURIER (courierID, nombres, apellidos, cantidadEnvios, codigoEmpresa)
VALUES (11, 'Nombre', 'Apellido', 0, 'EMP004');

-- READ (todos)
SELECT * FROM COURIER;

-- READ (uno)
SELECT * FROM COURIER WHERE courierID = 11;

-- UPDATE
UPDATE COURIER
SET cantidadEnvios = 10, codigoEmpresa = 'EMP005'
WHERE courierID = 11;

-- DELETE
DELETE FROM COURIER WHERE courierID = 11;


-- TABLA SOPORTE (10 registros)
INSERT INTO SOPORTE (soporteID, correoElectronico, administradorID) VALUES
(1, 'soporte1@proyectob.com', 1),
(2, 'soporte2@proyectob.com', 2),
(3, 'soporte3@proyectob.com', 3),
(4, 'soporte4@proyectob.com', 4),
(5, 'soporte5@proyectob.com', 5),
(6, 'soporte6@proyectob.com', 1),
(7, 'soporte7@proyectob.com', 2),
(8, 'soporte8@proyectob.com', 3),
(9, 'soporte9@proyectob.com', 4),
(10, 'soporte10@proyectob.com', 5);

-- CREATE
INSERT INTO SOPORTE (soporteID, correoElectronico, administradorID)
VALUES (11, 'soporte11@proyectob.com', 1);

-- READ (todos)
SELECT * FROM SOPORTE;

-- READ (uno)
SELECT * FROM SOPORTE WHERE soporteID = 11;

-- UPDATE
UPDATE SOPORTE
SET correoElectronico = 'nuevo.soporte@proyectob.com'
WHERE soporteID = 11;

-- DELETE
DELETE FROM SOPORTE WHERE soporteID = 11;


-- TABLA ARTESANO (10 registros)
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

-- CREATE
INSERT INTO ARTESANO (ruc, nombres, apellidos, correoElectronico, telefono, aceptaTerminos, administradorID)
VALUES ('9999999999999', 'Nombre', 'Apellido', 'correo@artesano.com', '0999888777', true, 1);

-- READ (todos)
SELECT * FROM ARTESANO;

-- READ (uno)
SELECT * FROM ARTESANO WHERE ruc = '9999999999999';

-- UPDATE
UPDATE ARTESANO
SET telefono = '0999777666', aceptaTerminos = false
WHERE ruc = '9999999999999';

-- DELETE
DELETE FROM ARTESANO WHERE ruc = '9999999999999';


-- TABLA TRANSACCION (10 registros)
INSERT INTO TRANSACCION (transaccionID, valorTotal, estado, fecha, clienteID) VALUES
(1, 125.50, 'COMPLETADA', '2025-01-15', '0912345678'),
(2, 89.75, 'PENDIENTE', '2025-01-18', '0923456789'),
(3, 234.20, 'COMPLETADA', '2025-01-20', '0934567890'),
(4, 156.80, 'CANCELADA', '2025-01-22', '0945678901'),
(5, 98.30, 'COMPLETADA', '2025-01-25', '0956789012'),
(6, 187.45, 'PROCESANDO', '2025-01-28', '0967890123'),
(7, 76.90, 'COMPLETADA', '2025-02-01', '0978901234'),
(8, 298.15, 'PENDIENTE', '2025-02-03', '0989012345'),
(9, 145.60, 'COMPLETADA', '2025-02-05', '0990123456'),
(10, 112.35, 'PROCESANDO', '2025-02-08', '0901234567');

-- CREATE
INSERT INTO TRANSACCION (transaccionID, valorTotal, estado, fecha, clienteID)
VALUES (11, 100.00, 'PENDIENTE', '2025-08-06', '0912345678');

-- READ (todos)
SELECT * FROM TRANSACCION;

-- READ (uno)
SELECT * FROM TRANSACCION WHERE transaccionID = 11;

-- UPDATE
UPDATE TRANSACCION
SET estado = 'COMPLETADA'
WHERE transaccionID = 11;

-- DELETE
DELETE FROM TRANSACCION WHERE transaccionID = 11;


-- TABLA PAGO (10 registros)
INSERT INTO PAGO (pagoID, tipo, valorPago, fecha, metodoPago, transaccionID) VALUES
(1, 'TRANSFERENCIA', 125.50, '2025-01-15', 'Tarjeta de Crédito', 1),
(2, 'DEPOSITO', 89.75, '2025-01-18', 'Efectivo', 2),
(3, 'TRANSFERENCIA', 234.20, '2025-01-20', 'Transferencia Bancaria', 3),
(4, 'DEPOSITO', 156.80, '2025-01-22', 'Tarjeta de Débito', 4),
(5, 'TRANSFERENCIA', 98.30, '2025-01-25', 'PayPal', 5),
(6, 'DEPOSITO', 187.45, '2025-01-28', 'Efectivo', 6),
(7, 'TRANSFERENCIA', 76.90, '2025-02-01', 'Tarjeta de Crédito', 7),
(8, 'DEPOSITO', 298.15, '2025-02-03', 'Transferencia Bancaria', 8),
(9, 'TRANSFERENCIA', 145.60, '2025-02-05', 'Tarjeta de Débito', 9),
(10, 'DEPOSITO', 112.35, '2025-02-08', 'PayPal', 10);

-- CREATE
INSERT INTO PAGO (pagoID, tipo, valorPago, fecha, metodoPago, transaccionID)
VALUES (11, 'DEPOSITO', 100.00, '2025-08-06', 'Efectivo', 1);

-- READ (todos)
SELECT * FROM PAGO;

-- READ (uno)
SELECT * FROM PAGO WHERE pagoID = 11;

-- UPDATE
UPDATE PAGO
SET valorPago = 110.00
WHERE pagoID = 11;

-- DELETE
DELETE FROM PAGO WHERE pagoID = 11;


-- TABLA PEDIDO (10 registros)
INSERT INTO PEDIDO (pedidoID, fechaEvento, direccionDestino, estado, estadoGPS, transaccionID, courierID) VALUES
(1, '2025-01-16', 'Av. 9 de Octubre y Malecón, Guayaquil', 'ENTREGADO', 'Ubicación: Destino', 1, 1),
(2, '2025-01-19', 'Av. Amazonas N24-03, Quito', 'EN_TRANSITO', 'Ubicación: Carretera', 2, 2),
(3, '2025-01-21', 'Calle Larga 7-07, Cuenca', 'ENTREGADO', 'Ubicación: Destino', 3, 3),
(4, '2025-01-23', 'Av. Cevallos 08-40, Ambato', 'CANCELADO', 'Ubicación: Origen', 4, 4),
(5, '2025-01-26', 'Av. Rocafuerte y 25 de Junio, Machala', 'ENTREGADO', 'Ubicación: Destino', 5, 5),
(6, '2025-01-29', 'Av. Universitaria, Portoviejo', 'PREPARANDO', 'Ubicación: Almacén', 6, 6),
(7, '2025-02-02', 'Calle Bolívar 14-83, Loja', 'ENTREGADO', 'Ubicación: Destino', 7, 7),
(8, '2025-02-04', 'Av. Daniel León Borja, Riobamba', 'EN_TRANSITO', 'Ubicación: Carretera', 8, 8),
(9, '2025-02-06', 'Malecón Las Palmas, Esmeraldas', 'ENTREGADO', 'Ubicación: Destino', 9, 9),
(10, '2025-02-09', 'Av. Teodoro Gómez, Ibarra', 'PREPARANDO', 'Ubicación: Almacén', 10, 10);

-- CREATE
INSERT INTO PEDIDO (pedidoID, fechaEvento, direccionDestino, estado, estadoGPS, transaccionID, courierID)
VALUES (11, '2025-08-10', 'Dirección Ejemplo', 'PREPARANDO', 'Ubicación: Almacén', 1, 1);

-- READ (todos)
SELECT * FROM PEDIDO;

-- READ (uno)
SELECT * FROM PEDIDO WHERE pedidoID = 11;

-- UPDATE
UPDATE PEDIDO
SET estado = 'ENTREGADO'
WHERE pedidoID = 11;

-- DELETE
DELETE FROM PEDIDO WHERE pedidoID = 11;


-- TABLA PRODUCTO (10 registros)
INSERT INTO PRODUCTO (productoID, nombre, descripcion, categoria, precio, porcentajeIVA, stock, artesanoID, estadoRevision, administradorID) VALUES
(1, 'Poncho Otavaleño', 'Poncho tradicional tejido a mano con lana de alpaca', 'Textiles', 85.00, 15.0, 12, 1234567890, 'APROBADO', 1),
(2, 'Sombrero de Paja Toquilla', 'Auténtico sombrero Panama Hat hecho a mano', 'Sombreros', 120.00, 15.0, 8, 1345678901, 'APROBADO', 2),
(3, 'Cerámica de Chordeleg', 'Vasija decorativa pintada con técnicas ancestrales', 'Cerámica', 45.50, 15.0, 20, 1456789012, 'REVISION', 3),
(4, 'Bolso de Cuero', 'Cartera artesanal de cuero curtido naturalmente', 'Marroquinería', 65.75, 15.0, 15, 1567890123, 'APROBADO', 1),
(5, 'Hamaca de Algodón', 'Hamaca tejida con algodón orgánico multicolor', 'Textiles', 55.30, 15.0, 10, 1678901234, 'APROBADO', 2),
(6, 'Máscara Ritual', 'Máscara tallada en madera de cedro para danzas', 'Tallado', 78.90, 15.0, 6, 1789012345, 'REVISION', 4),
(7, 'Bufanda de Alpaca', 'Bufanda suave tejida con fibra de alpaca natural', 'Textiles', 35.60, 15.0, 25, 1890123456, 'APROBADO', 3),
(8, 'Joyería en Tagua', 'Collar elaborado con semillas de tagua pintadas', 'Joyería', 28.40, 15.0, 30, 1901234567, 'PENDIENTE', 5),
(9, 'Canasta de Mimbre', 'Canasta tejida con fibras naturales de la costa', 'Cestería', 42.80, 15.0, 18, 2012345678, 'APROBADO', 1),
(10, 'Instrumentos Andinos', 'Quena artesanal tallada en caña de Guadúa', 'Instrumentos', 32.15, 15.0, 14, 1357924680, 'APROBADO', 4);

-- CREATE
INSERT INTO PRODUCTO (productoID, nombre, descripcion, categoria, precio, porcentajeIVA, stock, artesanoID, estadoRevision, administradorID)
VALUES (11, 'Producto Nuevo', 'Descripción ejemplo', 'Categoría', 50.00, 15.0, 10, '1234567890', 'APROBADO', 1);

-- READ (todos)
SELECT * FROM PRODUCTO;

-- READ (uno)
SELECT * FROM PRODUCTO WHERE productoID = 11;

-- UPDATE
UPDATE PRODUCTO
SET stock = 20, precio = 55.00
WHERE productoID = 11;

-- DELETE
DELETE FROM PRODUCTO WHERE productoID = 11;



-- TABLA DETALLES_PXT (10 registros)
INSERT INTO DETALLES_PXT (productoID, transaccionID, cantidad, subtotal) VALUES
(1, 1, 1, 85.00),       
(2, 2, 1, 120.00),      
(3, 3, 2, 91.00),       
(4, 4, 2, 131.50),     
(5, 5, 1, 55.30),      
(6, 6, 2, 157.80),      
(7, 7, 1, 35.60),       
(8, 8, 2, 56.80),       
(9, 9, 3, 128.40),     
(10, 10, 1, 32.15);     

-- CREATE
INSERT INTO DETALLES_PXT (productoID, transaccionID, cantidad, subtotal)
VALUES (1, 11, 2, 170.00);

-- READ (todos)
SELECT * FROM DETALLES_PXT;

-- READ (uno)
SELECT * FROM DETALLES_PXT WHERE productoID = 1 AND transaccionID = 11;

-- UPDATE
UPDATE DETALLES_PXT
SET cantidad = 3, subtotal = 255.00
WHERE productoID = 1 AND transaccionID = 11;

-- DELETE
DELETE FROM DETALLES_PXT WHERE productoID = 1 AND transaccionID = 11;



-- TABLA FOTO (10 registros)
INSERT INTO FOTO (fotoID, formato, peso, url, productoID) VALUES
(1, 'JPG', 2048, 'https://fotos.proyectob.com/poncho001.jpg', 1),
(2, 'PNG', 1856, 'https://fotos.proyectob.com/sombrero002.png', 2),
(3, 'JPG', 2234, 'https://fotos.proyectob.com/ceramica003.jpg', 3),
(4, 'JPEG', 1943, 'https://fotos.proyectob.com/bolso004.jpeg', 4),
(5, 'PNG', 2156, 'https://fotos.proyectob.com/hamaca005.png', 5),
(6, 'JPG', 2387, 'https://fotos.proyectob.com/mascara006.jpg', 6),
(7, 'JPEG', 1765, 'https://fotos.proyectob.com/bufanda007.jpeg', 7),
(8, 'PNG', 1892, 'https://fotos.proyectob.com/collar008.png', 8),
(9, 'JPG', 2067, 'https://fotos.proyectob.com/canasta009.jpg', 9),
(10, 'JPEG', 1734, 'https://fotos.proyectob.com/quena010.jpeg', 10);

-- CREATE
INSERT INTO FOTO (fotoID, formato, peso, url, productoID)
VALUES (11, 'JPG', 2100, 'https://fotos.proyectob.com/nueva_foto.jpg', 1);

-- READ (todos)
SELECT * FROM FOTO;

-- READ (uno)
SELECT * FROM FOTO WHERE fotoID = 11;

-- UPDATE
UPDATE FOTO
SET url = 'https://fotos.proyectob.com/actualizada_foto.jpg'
WHERE fotoID = 11;

-- DELETE
DELETE FROM FOTO WHERE fotoID = 11;


-- TABLA DEVOLUCION (10 registros)
INSERT INTO DEVOLUCION (devolucionID, fechaInicio, fechaFin, tipo, motivo, comentario, productoID, soporteID, transaccionID, clienteID) VALUES
(1, '2025-01-17', '2025-01-24', 'DANO', 'Defecto fabricación', 'Producto llegó con hilo suelto en el borde', 1, 1, 1, '0912345678'),
(2, '2025-01-20', '2025-01-27', 'PRUEBA', 'No satisface', 'Color no coincide con la foto mostrada en web', 2, 2, 2, '0923456789'),
(3, '2025-01-22', '2025-01-29', 'DANO', 'Transporte', 'Vasija llegó con grieta en la base', 3, 3, 3, '0934567890'),
(4, '2025-01-24', '2025-01-31', 'PRUEBA', 'Talla incorrecta', 'Bolso más pequeño de lo esperado', 4, 4, 4, '0945678901'),
(5, '2025-01-27', '2025-02-03', 'DANO', 'Defecto material', 'Hamaca con hilos de diferente textura', 5, 5, 5, '0956789012'),
(6, '2025-01-30', '2025-02-06', 'PRUEBA', 'No es lo esperado', 'Máscara no tiene el acabado mostrado', 6, 1, 6, '0967890123'),
(7, '2025-02-03', '2025-02-10', 'DANO', 'Defecto tejido', 'Bufanda con punto corrido en una sección', 7, 2, 7, '0978901234'),
(8, '2025-02-05', '2025-02-12', 'PRUEBA', 'Calidad baja', 'Pintura del collar se desprende fácilmente', 8, 3, 8, '0989012345'),
(9, '2025-02-07', '2025-02-14', 'DANO', 'Transporte', 'Canasta llegó deformada por mal empaque', 9, 4, 9, '0990123456'),
(10, '2025-02-10', '2025-02-17', 'PRUEBA', 'Sonido deficiente', 'Quena no produce el sonido esperado', 10, 5, 10, '0901234567');

-- CREATE
INSERT INTO DEVOLUCION (devolucionID, fechaInicio, fechaFin, tipo, motivo, comentario, productoID, soporteID, transaccionID, clienteID)
VALUES (11, '2025-08-07', '2025-08-14', 'DANO', 'Motivo ejemplo', 'Comentario ejemplo', 1, 1, 1, '0912345678');

-- READ (todos)
SELECT * FROM DEVOLUCION;

-- READ (uno)
SELECT * FROM DEVOLUCION WHERE devolucionID = 11;

-- UPDATE
UPDATE DEVOLUCION
SET comentario = 'Comentario actualizado'
WHERE devolucionID = 11;

-- DELETE
DELETE FROM DEVOLUCION WHERE devolucionID = 11;

