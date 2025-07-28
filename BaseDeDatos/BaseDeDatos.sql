CREATE DATABASE proyectob;
use proyectob;
CREATE TABLE CLIENTE(
cedula char(10) primary key,
nombres varchar(30) not null,
apellidos varchar(30) not null,
correoElectronico varchar(100) default null,
telefono char(10) default null,
ubicacion varchar(50) not null,
aceptaTermino boolean not null);

CREATE TABLE ADMINISTRADOR(
administradorID int primary key,
nombres varchar(30) not null,
apellidos varchar(30) not null,
correoElectronico varchar(100) not null);

CREATE TABLE COURIER(
courierID int primary key,
nombres varchar(30) not null,
apellidos varchar(30) not null,
cantidadEnvios int default 0,
codigoEmpresa varchar(20) not null);

CREATE TABLE SOPORTE(
soporteID int primary key,
correoElectronico varchar(100),
administradorID int,
foreign key (administradorID) references administrador(administradorID));

CREATE TABLE TRANSACCION(
transaccionID int primary key,
valorTotal float not null,
estado varchar(20) not null,
fecha date not null,
clienteID char(10) not null,
foreign key (clienteID) references cliente(cedula));

CREATE TABLE ARTESANO(
ruc varchar(13) primary key,
nombres varchar(30) not null,
apellidos varchar(30) not null,
correoElectronico varchar(100) default null,
telefono varchar(15) not null,
aceptaTerminos boolean not null,
administradorID int,
foreign key (administradorID) references administrador (administradorID));

CREATE TABLE PAGO(
pagoID int primary key,
tipo enum('DEPOSITO','TRANSFERENCIA'),
valorPago float not null,
fecha date not null,
metodoPago varchar(30) not null,
transaccionID int,
foreign key (transaccionID) references transaccion (transaccionID));

CREATE TABLE PEDIDO(
pedidoID int primary key,
fechaEvento date not null,
direccionDestino varchar(100) not null,
estado varchar(30) not null,
estadoGPS varchar(50) not null,
transaccionID int not null,
courierID int not null,
foreign key (transaccionID) references transaccion(transaccionID),
foreign key (courierID) references courier (courierID));

CREATE TABLE PRODUCTO(
productoID int primary key,
nombre varchar(30) not null,
descripcion char(60) default null,
categoria varchar(50) not null,
precio float not null,
porcentajeIVA float not null,
stock int default 0,
artesanoID int,
estadoRevision varchar(20),
administradorID int,
foreign key (artesanoID) references artesano(ruc),
foreign key(administradorID) references administrador(administradorID));

CREATE TABLE DETALLES_PXT(
productoID int,
transaccionID int,
primary key(productoID,transaccionID),
foreign key (productoID) references producto (productoID),
foreign key (transaccionID) references transaccion(transaccionID));

CREATE TABLE FOTO(
fotoID int primary key,
formato varchar(10) not null,
peso int,
url varchar(255),
productoID int,
foreign key (productoID) references producto(productoID));

CREATE TABLE DEVOLUCION(
devolucionID int primary key,
fechaInicio date not null,
fechaFin date not null,
tipo enum('PRUEBA','DANO'),
motivo varchar(20) default null,
comentario char(60) default null,
productoID int,
soporteID int,
transaccionID int,
clienteID char(10),
foreign key (productoID) references producto(productoID),
foreign key (soporteID) references soporte(soporteID),
foreign key (transaccionID) references transaccion(transaccionID),
foreign key (clienteID) references cliente(cedula));
 
 
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

-- TABLA DETALLES_PXT (10 registros)
INSERT INTO DETALLES_PXT (productoID, transaccionID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

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
