CREATE TABLE Propietario (
    id_propietario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE Mascota (
    id_mascota INT IDENTITY(1,1) PRIMARY KEY,
    nombre_mascota VARCHAR(50) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raza VARCHAR(50),
    edad INT,
    id_propietario INT NOT NULL,
    CONSTRAINT FK_Mascota_Propietario FOREIGN KEY (id_propietario) REFERENCES 
Propietario(id_propietario)
);

CREATE TABLE Servicio (
    id_servicio INT IDENTITY(1,1) PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE Atencion (
    id_atencion INT IDENTITY(1,1) PRIMARY KEY,
    fecha_atencion DATE NOT NULL,
    id_mascota INT NOT NULL,
    id_servicio INT NOT NULL,
    observaciones TEXT,
    CONSTRAINT FK_Atencion_Mascota FOREIGN KEY (id_mascota) REFERENCES 
Mascota(id_mascota),
    CONSTRAINT FK_Atencion_Servicio FOREIGN KEY (id_servicio) REFERENCES 
Servicio(id_servicio)
);

INSERT INTO Propietario (nombre, telefono, direccion) VALUES 
('Carlos Pérez', '3101234567', 'Calle 100 # 15-20'),
('Ana Gómez', '3209876543', 'Carrera 45 # 80-12'),
('Luis Rodríguez', '3154567890', 'Av. Suba # 125-50');

INSERT INTO Mascota (nombre_mascota, especie, raza, edad, id_propietario) VALUES 
('Firulais', 'Canino', 'Labrador', 3, 1),
('Michi', 'Felino', 'Siames', 2, 2),
('Luna', 'Canino', 'Poodle', 5, 1),
('Simón', 'Felino', 'Criollo', 4, 3);

INSERT INTO Servicio (nombre_servicio, precio) VALUES 
('Consulta General', 50000.00),
('Vacunación Antirrábica', 35000.00),
('Baño y Peluquería', 45000.00),
('Desparasitación', 25000.00);

INSERT INTO Atencion (fecha_atencion, id_mascota, id_servicio, observaciones) VALUES 
('2026-09-02', 1, 1, 'Paciente activo, sin fiebre. Se receta vitaminas.'),
('2026-09-03', 2, 2, 'Aplicación de dosis anual de vacuna antirrábica.'),
('2026-09-05', 3, 3, 'Servicio de baño completo con corte de uñas.'),
('2026-09-06', 4, 4, 'Se suministra pastilla antiparasitaria.'),
('2026-09-10', 1, 3, 'Baño medicado para piel sensible.');



-- Q1: Listado básico de mascotas por propietario
SELECT p.nombre AS Propietario, m.nombre_mascota, m.especie, m.raza 
FROM Propietario p 
JOIN Mascota m ON p.id_propietario = m.id_propietario;

-- Q2: Servicio más solicitado
SELECT s.nombre_servicio, COUNT(a.id_servicio) AS total_prestados 
FROM Servicio s 
JOIN Atencion a ON s.id_servicio = a.id_servicio 
GROUP BY s.nombre_servicio 
ORDER BY total_prestados DESC;

-- Q3: Atenciones en un periodo específico
SELECT * FROM Atencion 
WHERE fecha_atencion >= '2026-09-01' AND fecha_atencion <= '2026-09-30';

-- Q4: Historial médico de una mascota
SELECT m.nombre_mascota, s.nombre_servicio, a.fecha_atencion, a.observaciones 
FROM Atencion a 
JOIN Mascota m ON a.id_mascota = m.id_mascota 
JOIN Servicio s ON a.id_servicio = s.id_servicio 
WHERE m.id_mascota = 1;
-- Q5: Ingresos totales por servicios
SELECT SUM(s.precio) AS ingresos_totales 
FROM Atencion a 
JOIN Servicio s ON a.id_servicio = s.id_servicio;