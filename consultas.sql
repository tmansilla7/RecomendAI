CREATE SCHEMA IF NOT EXISTS trabajo_practico_final;

USE trabajo_practico_final;

DROP TABLE IF EXISTS Pais;
CREATE TABLE Pais (
	pais_id INT NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	PRIMARY KEY(pais_id)
);

DROP TABLE IF EXISTS Idioma;
CREATE TABLE Idioma(
	idioma_id INT NOT NULL,
    nombre VARCHAR(100),
    PRIMARY KEY(idioma_id)
);

DROP TABLE IF EXISTS Genero;
CREATE TABLE Genero(
	genero_id INT NOT NULL,
    descripcion VARCHAR(250),
    PRIMARY KEY  (genero_id)
);

DROP TABLE IF EXISTS Sexo;
CREATE TABLE Sexo(
	sexo_id INT NOT NULL,
    nombre VARCHAR(100),
    PRIMARY KEY(sexo_id)
);

DROP TABLE IF EXISTS Tipo;
CREATE TABLE Tipo(
	tipo_id INT NOT NULL,
    nombre VARCHAR (100),
    PRIMARY KEY (tipo_id)
);

DROP TABLE IF EXISTS Tematica;
CREATE TABLE Tematica (
	tematica_id INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	PRIMARY KEY(tematica_id)
);

DROP TABLE IF EXISTS Caracteristica;
CREATE TABLE Caracteristica(
	caracteristica_id INT NOT NULL,
	descripcion VARCHAR(100),
	PRIMARY KEY(caracteristica_id)
);

DROP TABLE IF EXISTS Participe;
CREATE TABLE Participe(
	participe_id INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	PRIMARY KEY(participe_id)
);

DROP TABLE IF EXISTS Conversacion;
CREATE TABLE Conversacion(
	id_conversacion int not null,
	CONSTRAINT conversacion_pk PRIMARY KEY (id_conversacion)
);

DROP TABLE IF EXISTS Opinion;
CREATE TABLE Opinion(
	opinion_id int not null,
	recomendacion_acertada boolean,
	consumido boolean,
	puntuacion int not null,
	CONSTRAINT opinion_pk PRIMARY KEY(opinion_id)
);

DROP TABLE IF EXISTS Emocion;
CREATE TABLE Emocion(
	emocion_id int not null,
	nombre varchar(50),
	CONSTRAINT emocion_pk PRIMARY KEY(emocion_id)
);

DROP TABLE IF EXISTS Perfil;
CREATE TABLE Perfil(
	perfil_id int not null,
	nombre varchar(50),
	email varchar(50),
	contrasenia varchar(50),
	edad int,
	lugar_residencia varchar(50),
	sexo_id int not null,
	idioma_id int not null,
	pais_id int not null,
	CONSTRAINT perfil_PK PRIMARY KEY(perfil_id),
	FOREIGN KEY (sexo_id) REFERENCES sexo (sexo_id),
	FOREIGN KEY (idioma_id) REFERENCES idioma (idioma_id),
	FOREIGN KEY (pais_id) REFERENCES pais (pais_id)
);

DROP TABLE IF EXISTS Contenido;
CREATE TABLE Contenido (
	id_contenido INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME,
    anio_publicacion YEAR NOT NULL,
    id_cont_relacion INT, -- Puede ser null, ya que no todos los contenidos tienen contenido relacionado
    tipo_relacion VARCHAR(100),
    id_pais INT NOT NULL,
    PRIMARY KEY(id_contenido),
    FOREIGN KEY (id_cont_relacion) REFERENCES Contenido(id_contenido),
    FOREIGN KEY (id_pais) REFERENCES Pais(pais_id)
);

DROP TABLE IF EXISTS Puntuacion;
CREATE TABLE Puntuacion(
	puntuacion_id INT NOT NULL,
	puntuacion INT NOT NULL,
	caracteristica_id INT,
	id_contenido INT,
	PRIMARY KEY(puntuacion_id),
	FOREIGN KEY(caracteristica_id) REFERENCES caracteristica(caracteristica_id),
	FOREIGN KEY(id_contenido) REFERENCES contenido(id_contenido)
);

DROP TABLE IF EXISTS Recomendacion;
CREATE TABLE Recomendacion(
	recomendacion_id int not null,
    id_contenido int not null,
	fecha date,
	opinion_id int not null,
	CONSTRAINT recomendacion_pk PRIMARY KEY (recomendacion_id,id_contenido),
    FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido),
	FOREIGN KEY (opinion_id) REFERENCES opinion (opinion_id)
);

DROP TABLE IF EXISTS Contenido_tipo;
CREATE TABLE Contenido_tipo (
   	id_contenido int not null,
	tipo_id int not null,
	CONSTRAINT Contenido_tipo_pk PRIMARY KEY (id_contenido, tipo_id),
	FOREIGN KEY (id_contenido) REFERENCES Contenido (id_contenido),
	FOREIGN KEY (tipo_id) REFERENCES Tipo (tipo_id)
);

DROP TABLE IF EXISTS Contenido_participe;
CREATE TABLE Contenido_participe (
    	id_contenido int not null,
	participe_id int not null,
	rol varchar(25) not null,
	CONSTRAINT Contenido_participe_pk PRIMARY KEY (id_contenido, participe_id, rol),
	FOREIGN KEY (id_contenido) REFERENCES Contenido (id_contenido),
	FOREIGN KEY (participe_id) REFERENCES Participe (participe_id)
);

DROP TABLE IF EXISTS Contenido_idioma; 
CREATE TABLE Contenido_idioma (
   	id_contenido int not null,
	idioma_id int not null,
	CONSTRAINT Contenido_idioma_pk PRIMARY KEY (id_contenido, idioma_id),
	FOREIGN KEY (id_contenido) REFERENCES Contenido (id_contenido),
	FOREIGN KEY (idioma_id) REFERENCES Idioma (idioma_id)
);

DROP TABLE IF EXISTS Contenido_genero;
CREATE TABLE Contenido_genero (
    	id_contenido int not null,
	genero_id int not null,
	CONSTRAINT Contenido_genero_pk PRIMARY KEY (id_contenido, genero_id),
	FOREIGN KEY (id_contenido) REFERENCES Contenido (id_contenido),
	FOREIGN KEY (genero_id) REFERENCES Genero (genero_id)
);

DROP TABLE IF EXISTS Contenido_tematica;
CREATE TABLE Contenido_tematica (
    	id_contenido int not null,
	tematica_id int not null,
	CONSTRAINT Contenido_tematica_pk PRIMARY KEY (id_contenido, tematica_id),
	FOREIGN KEY (id_contenido) REFERENCES Contenido (id_contenido),
	FOREIGN KEY (tematica_id) REFERENCES Tematica (tematica_id)
);

DROP TABLE IF EXISTS Conversacion_tematica;
CREATE TABLE Conversacion_tematica (
    id_conversacion INT NOT NULL,
    tematica_id INT NOT NULL,
    FOREIGN KEY (id_conversacion) REFERENCES conversacion(id_conversacion),
    FOREIGN KEY (tematica_id) REFERENCES tematica(tematica_id),
    PRIMARY KEY (id_conversacion,tematica_id)
);

DROP TABLE IF EXISTS Conversacion_caracteristica;
CREATE TABLE Conversacion_caracteristica (
    id_conversacion INT NOT NULL,
    caracteristica_id INT NOT NULL,
    FOREIGN KEY (id_conversacion) REFERENCES conversacion(id_conversacion),
    FOREIGN KEY (caracteristica_id) REFERENCES caracteristica(caracteristica_id),
    PRIMARY KEY (id_conversacion,caracteristica_id)
);

DROP TABLE IF EXISTS Conversacion_genero;
CREATE TABLE Conversacion_genero (
    id_conversacion INT NOT NULL,
    genero_id INT NOT NULL,
    FOREIGN KEY (id_conversacion) REFERENCES conversacion(id_conversacion),
    FOREIGN KEY (genero_id) REFERENCES genero(genero_id),
    PRIMARY KEY (id_conversacion,genero_id)
);

DROP TABLE IF EXISTS Conversacion_emocion;
CREATE TABLE Conversacion_emocion (
    id_conversacion INT NOT NULL,
    emocion_id INT NOT NULL,
    FOREIGN KEY (id_conversacion) REFERENCES conversacion(id_conversacion),
    FOREIGN KEY (emocion_id) REFERENCES emocion(emocion_id),
    PRIMARY KEY (id_conversacion,emocion_id)
);

DROP TABLE IF EXISTS Opinion_perfil;
CREATE TABLE Opinion_perfil (
	opinion_id INT NOT NULL,
    perfil_id INT NOT NULL,
    FOREIGN KEY (opinion_id) REFERENCES opinion(opinion_id),
    FOREIGN KEY (perfil_id) REFERENCES perfil(perfil_id),
    PRIMARY KEY (opinion_id,perfil_id)
);

DROP TABLE IF EXISTS Contenido_emocion_caracteristica;
CREATE TABLE Contenido_emocion_caracteristica (
	id_contenido INT NOT NULL,
	emocion_id INT NOT NULL,
	caracteristica_id INT NOT NULL,
	ponderacion DECIMAL(1,1),
	CONSTRAINT Contenido_emocion_caracteristica PRIMARY KEY (id_contenido, emocion_id, caracteristica_id),
	FOREIGN KEY (id_contenido) REFERENCES Contenido (id_contenido),
	FOREIGN KEY (emocion_id) REFERENCES Emocion (emocion_id),
	FOREIGN KEY (caracteristica_id) REFERENCES Caracteristica (caracteristica_id)
);

DROP TABLE IF EXISTS Conversacion_recomendacion_perfil;
CREATE TABLE Conversacion_recomendacion_perfil (
    id_conversacion INT NOT NULL,
    recomendacion_id INT NOT NULL,
    perfil_id INT NOT NULL,
    id_contenido INT NOT NULL,
    FOREIGN KEY (id_conversacion) REFERENCES conversacion(id_conversacion),
    FOREIGN KEY (recomendacion_id, id_contenido) REFERENCES recomendacion(recomendacion_id, id_contenido),
    FOREIGN KEY (perfil_id) REFERENCES perfil(perfil_id),
    PRIMARY KEY (id_conversacion, recomendacion_id, id_contenido, perfil_id)
);


-- INSERTS 
-- Ingresar paises
INSERT INTO Pais(pais_id, nombre)
VALUES
(1, 'Argentina'),
(2, 'Francia'),
(3, 'Colombia'),
(4, 'Dinamarca'),
(5, 'Inglaterra'),
(6, 'Brasil'),
(7, 'Alemania'),
(8, 'Hungría'),
(9, 'India'),
(10, 'Japón'),
(11, 'Canadá'),
(12, 'Luxemburgo'),
(13, 'México'),
(14, 'Noruega'),
(15, 'Estados Unidos'),
(16, 'Perú'),
(17, 'Qatar'),
(18, 'Rusia'),
(19, 'Suecia'),
(20, 'Tailandia'),
(21, 'Uruguay'),
(22, 'Venezuela'),
(23, 'Chile'),
(24, 'Australia'),
(25, 'Bolivia');

-- Ingresar idioma
INSERT INTO Idioma (idioma_id, nombre)
VALUES
(1, 'Español'),
(2, 'Inglés'),
(3, 'Francés'),
(4, 'Alemán'),
(5, 'Italiano'),
(6, 'Japonés'),
(7, 'Mandarín'),
(8, 'Ruso'),
(9, 'Árabe'),
(10, 'Hindi');

-- Ingresar genero
INSERT INTO Genero (genero_id, descripcion)
VALUES
(1, 'Acción'),
(2, 'Aventura'),
(3, 'Comedia'),
(4, 'Drama'),
(5, 'Terror'),
(6, 'Ciencia ficción'),
(7, 'Fantasía'),
(8, 'Romántico'),
(9, 'Documental'),
(10, 'Histórico'),
(11, 'Animación'),
(12, 'Suspenso'),
(13, 'Crimen'),
(14, 'Guerra'),
(15, 'Biografía');

-- Ingresar sexo
INSERT INTO Sexo (sexo_id, nombre)
VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'No binario');

-- Ingresar tipo
INSERT INTO Tipo (tipo_id, nombre)
VALUES
(1, 'Película'),
(2, 'Serie'),
(3, 'Documental'),
(4, 'Cortometraje'),
(5, 'Anime'),
(6, 'Videojuego'),
(7, 'Libro'),
(8, 'Podcast'),
(9, 'Música'),
(10, 'Obra de teatro');

-- Ingresar tematicas
INSERT INTO Tematica (tematica_id, nombre)
VALUES
(1, 'Aventura'),
(2, 'Ciencia Ficción'),
(3, 'Romance'),
(4, 'Misterio'),
(5, 'Terror'),
(6, 'Comedia'),
(7, 'Drama'),
(8, 'Fantasía'),
(9, 'Historia'),
(10, 'Acción'),
(11, 'Documental'),
(12, 'Animación'),
(13, 'Biografía'),
(14, 'Deporte'),
(15, 'Crimen'),
(16, 'Familia'),
(17, 'Musical'),
(18, 'Guerra'),
(19, 'Western'),
(20, 'Thriller'),
(21, 'Policial'),
(22, 'Pop'),
(23, 'Rock'),
(24, 'Hip-Hop'),
(25, 'Reggae'),
(26, 'Jazz'),
(27, 'Blues'),
(28, 'Country'),
(29, 'Electrónica'),
(30, 'Clásica'),
(31, 'Latina'),
(32, 'Salsa'),
(33, 'Merengue'),
(34, 'Bachata'),
(35, 'K-Pop'),
(36, 'R&B'),
(37, 'Tango'),
(38, 'Podcasts'),
(39, 'Folklore'),
(40, 'Indie'),
(41, 'Heavy Metal');

-- Ingresar caracteristicas
INSERT INTO Caracteristica (caracteristica_id, descripcion)
VALUES
(1, 'Conmovedor'),
(2, 'Divertido'),
(3, 'Sorprendente'),
(4, 'Emocionante'),
(5, 'Inspirador'),
(6, 'Triste'),
(7, 'Alegre'),
(8, 'Terrorífico'),
(9, 'Romántico'),
(10, 'Intrigante'),
(11, 'Relajante'),
(12, 'Motivador'),
(13, 'Desgarrador'),
(14, 'Gracioso'),
(15, 'Dramático'),
(16, 'Nostálgico'),
(17, 'Reflexivo'),
(18, 'Estimulante'),
(19, 'Apasionante'),
(20, 'Sorprendente'),
(21, 'Atrapante');

-- Ingresar participes
INSERT INTO Participe(participe_id, nombre)
VALUES
(1, 'Tim Robbins'),
(2, 'Dylan OBrien'),
(3, 'Daniel Radcliffe'),
(4, 'Leonardo DiCaprio'),
(5, 'Tom Hanks'),
(6, 'Bryan Cranston'),
(7, 'Emilia Clarke'),
(8, 'Steve Carell'),
(9, 'Jennifer Aniston'),
(10, 'Millie Bobby Brown'),
(11, 'Gregory Peck'),
(12, 'John Hurt'),
(13, 'Robert Redford'),
(14, 'James Dashner'),
(15, 'J.K. Rowling'),
(16, 'Joe Rogan'),
(17, 'Sarah Koenig'),
(18, 'Josh Clark'),
(19, 'Karen Kilgariff'),
(20, 'Michael Barbaro'),
(21, 'Freddie Mercury'),
(22, 'Robert Plant'),
(23, 'John Lennon'),
(24, 'Michael Jackson'),
(25, 'Kurt Cobain'),
(26, 'Jack Nicholson'),
(27, 'John Travolta'),
(28, 'Elijah Wood'),
(29, 'Keanu Reeves'),
(30, 'Kate Winslet'),
(31, 'Mark Hamill'),
(32, 'Jodie Foster'),
(33, 'Sam Neill'),
(34, 'Robert Downey Jr.'),
(35, 'Morgan Freeman'),
(36, 'James Gandolfini'),
(37, 'Dominic West'),
(38, 'Jon Hamm'),
(39, 'Hugh Bonneville'),
(40, 'Benedict Cumberbatch');

-- Ingresar Conversacion
INSERT INTO Conversacion (id_conversacion) 
VALUES(1), 
	  (2), 
      (3), 
      (4), 
      (5),
      (6),
      (7),
      (8),
      (9),
      (10),
      (11),
      (12);
      
-- Ingresar opiniones
INSERT INTO Opinion (opinion_id, recomendacion_acertada,consumido,puntuacion)
VALUES
	(1,TRUE,TRUE,2),
    (2,FALSE,TRUE,5),
    (3,TRUE,FALSE,1),
    (4,FALSE,FALSE,4),
    (5,TRUE,TRUE,4);

-- Ingresar emociones
INSERT INTO Emocion (emocion_id, nombre)
VALUES
    (1, 'Felicidad'),
    (2, 'Tristeza'),
    (3, 'Enojo'),
    (4, 'Miedo'),
    (5, 'Asombro'),
    (6, 'Amor'),
    (7, 'Confianza'),
    (8, 'Esperanza'),
    (9, 'Sorpresa'),
    (10, 'Desprecio'),
    (11, 'Aburrimiento');
    
    -- Ingresar perfiles
INSERT INTO Perfil (perfil_id, nombre, email, contrasenia, edad, lugar_residencia, sexo_id, idioma_id, pais_id)
VALUES
(1, 'Juan Pérez', 'juan.perez@example.com', 'password123', 30, 'Buenos Aires', 1, 1, 1), 
(2, 'María Gómez', 'maria.gomez@example.com', 'securepass', 25, 'Paris', 2, 2, 2), 
(3, 'Carlos López', 'carlos.lopez@example.com', 'mypassword', 35, 'Ciudad de México', 1, 3, 13), 
(4, 'Ana Martínez', 'ana.martinez@example.com', 'anotherpass', 28, 'Bogotá', 2, 1, 3), 
(5, 'Pedro Sánchez', 'pedro.sanchez@example.com', 'yetanotherpass', 22, 'Lima', 1, 2, 16),
('6', 'Lila Fernandez', 'lilafernandez@example.com', 'hola1234', '21', 'Buenos Aires', '2', '1', '1'),
('7', 'Sergio Ramirez', 'sergio@example.com', 'sergio123', '23', 'Buenos Aires', '1', '1', '1');

-- Ingresar Contenidos
INSERT INTO Contenido (id_contenido, titulo, duracion, anio_publicacion, id_cont_relacion, tipo_relacion, id_pais)
VALUES
	-- Peliculas
    (1, 'Sueño de fuga', '02:22:00', 1994, NULL, NULL, 1),
    (2, 'Maze Runner', '02:55:00', 2011, NULL, "libro", 2),
    (3, 'Harry Potter', '02:32:00', 2008, NULL, "libro", 3),
    (4, 'Inception', '02:28:00', 2010, NULL, NULL, 4),
    (5, 'Forrest Gump', '02:22:00', 1994, NULL, NULL, 1),
    -- Series
    (6, 'Breaking Bad', '00:47:00', 2008, NULL, NULL, 1),
    (7, 'Juegos de Tronos', '01:00:00', 2011, NULL, NULL, 5),
    (8, 'The Office', '00:22:00', 2005, NULL, NULL, 1),
    (9, 'Friends', '00:22:00', 1994, NULL, NULL, 1),
    (10, 'Stranger Things', '01:00:00', 2016, NULL, NULL, 1),
    -- Libros
    (11, 'matar un ruiseñor', NULL, 1960, NULL, NULL, 1),
    (12, '1984', NULL, 1949, NULL, NULL, 6),
    (13, 'El Gran Gatsby', NULL, 1925, NULL, NULL, 1),
    (14, 'Maze Runner: Correr o Morir', NULL, 2009, NULL, NULL, 7),
    (15, 'Harry Potter yy La Piedra Filosofal', NULL, 1997, NULL, NULL, 8),
    -- Podcasts
    (16, 'The Joe Rogan Experience', '02:00:00', 2009, NULL, NULL, 1),
    (17, 'Serial', '00:30:00', 2014, NULL, NULL, 1),
    (18, 'Stuff You Should Know', '00:45:00', 2008, NULL, NULL, 1),
    (19, 'My Favorite Murder', '01:00:00', 2016, NULL, NULL, 1),
    (20, 'The Daily', '00:20:00', 2017, NULL, NULL, 1),
    -- Musica
    (21, 'Bohemian Rhapsody', '00:05:55', 1975, NULL, NULL, 7),
    (22, 'Stairway to Heaven', '00:08:02', 1971, NULL, NULL, 8),
    (23, 'Imagine', '00:03:00', 1971, NULL, NULL, 1),
    (24, 'Billie Jean', '00:04:54', 1982, NULL, NULL, 1),
    (25, 'Smells Like Teen Spirit', '00:05:01', 1991, NULL, NULL, 1),
    -- Peliculas
    (26, 'El Resplandor', '02:26:00', 1980, NULL, NULL, 1),
    (27, 'Tiempos Violentos', '02:34:00', 1994, NULL, NULL, 1),
    (28, 'El Señor de los Anillos: La Comunidad del Anillo', '02:58:00', 2001, NULL, NULL, 8),
    (29, 'Matrix', '02:16:00', 1999, NULL, NULL, 1),
    (30, 'Titanic', '03:14:00', 1997, NULL, NULL, 1),
    (31, 'Star Wars: Episode IV', '02:05:00', 1977, NULL, NULL, 1),
    (32, 'El Silencio de los Inocentes', '01:58:00', 1991, NULL, NULL, 1),
    (33, 'Jurassic Park', '02:07:00', 1993, NULL, NULL, 1),
    (34, 'Los Vengadores', '02:23:00', 2012, NULL, NULL, 1),
    (35, 'Terminator', '02:22:00', 2001, NULL, NULL, 1),
    -- Series
    (36, 'Los Sopranos', '00:55:00', 1999, NULL, NULL, 1),
    (37, 'Los Vigilantes', '01:00:00', 2002, NULL, NULL, 1),
    (38, 'Mad Men', '00:47:00', 2007, NULL, NULL, 1),
    (39, 'Downton Abbey', '00:55:00', 2010, NULL, NULL, 7),
    (40, 'Sherlock', '01:30:00', 2010, NULL, NULL, 7),
    -- Libros
    (41, 'El Guardian entre el centeno', NULL, 1951, NULL, NULL, 1),
    (42, 'Padre Rico Padre Pobre', NULL, 1997, NULL, NULL, 1),
    (43, 'El Señor de los Anillos', NULL, 1954, NULL, NULL, 8),
    (44, 'Cometas en el cielo', NULL, 2003, NULL, NULL, 9),
    (45, 'Los Juegos del Hambre', NULL, 2008, NULL, NULL, 1),
    -- Podcasts
    (46, 'The Ezra Klein Show', '01:00:00', 2016, NULL, NULL, 1),
    (47, 'Radiolab', NULL, 2002, NULL, NULL, 1),
    (48, 'The Tim Ferriss Show', '01:30:00', 2014, NULL, NULL, 1),
    (49, 'Revisionist History', '00:45:00', 2016, NULL, NULL, 1),
    (50, 'Armchair Expert', '01:15:00', 2018, NULL, NULL, 1),
    -- Musica
    (51, 'Hallelujah', '00:04:38', 1984, NULL, NULL, 8),
    (52, 'Wonderwall', '00:04:18', 1995, NULL, NULL, 7),
    (53, 'Sweet Caroline', '00:03:21', 1969, NULL, NULL, 1),
    (54, 'Respect', '00:02:28', 1967, NULL, NULL, 1),
    (55, 'Stayin'' Alive', '00:04:45', 1977, NULL, NULL, 7),
    (56, 'Hotel California', '00:06:31', 1977, NULL, NULL, 1),
    (57, 'Sweet Home Alabama', '00:03:44', 1974, NULL, NULL, 1),
    (58, 'Thriller', '00:05:57', 1982, NULL, NULL, 1),
    (59, 'Bohemian Rhapsody', '00:05:55', 1975, NULL, NULL, 7),
    (60, 'Imagine', '00:03:00', 1971, NULL, NULL, 1),
    (61, 'Imagine', '00:03:05', 1971, NULL, NULL, 5),
	(62, 'Smells Like Teen Spirit', '00:04:39', 1991, NULL, NULL, 15),
	(63, 'Despacito', '00:03:47', 2017, NULL, NULL, 13),
	(64, 'Shape of You', '00:03:53', 2017, NULL, NULL, 5),
	(65, 'See You Again', '00:03:58', 2015, NULL, NULL, 15),
	(66, 'Uptown Funk', '00:04:30', 2014, NULL, NULL, 5),
	(67, 'Gangnam Style', '00:04:13', 2012, NULL, NULL, 10),
	(68, 'Sugar', '00:03:55', 2014, NULL, NULL, 15),
	(69, 'Sorry', '00:03:14', 2015, NULL, NULL, 11),
	(70, 'Roar', '00:03:43', 2013, NULL, NULL, 15),
	(71, 'Counting Stars', '00:04:02', 2013, NULL, NULL, 15),
	(72, 'Thinking Out Loud', '00:04:41', 2014, NULL, NULL, 5),
	(73, 'Dark Horse', '00:03:35', 2013, NULL, NULL, 15),
	(74, 'Faded', '00:03:28', 2015, NULL, NULL, 14),
	(75, 'Girls Like You', '00:03:53', 2018, NULL, NULL, 15),
	(76, 'Shake It Off', '00:03:39', 2014, NULL, NULL, 15),
	(77, 'Wonderwall', '00:04:18', 1995, NULL, NULL, 5),
	(78, 'Canción de Alicia en el País', '00:04:26', 1980, NULL, NULL, 1),
	(79, 'Echoes', '00:23:31', 1971, NULL, NULL, 5),
	(80, 'Stairway to Heaven', '00:08:02', 1971, NULL, NULL, 5),
	(81, 'Nadie Sabe', '00:06:19', 2023, NULL, NULL, 1),
	(82, 'Zwei Jahre', '01:30:00', 2013, NULL, NULL, 7);
    
    
    -- AGREGAMOS UN SET DE CONTENIDO PARA INGRESAR LOS DATOS DE UNA SECUELA.
    UPDATE contenido
    SET id_cont_relacion = 14, tipo_relacion = 'libro'
    WHERE id_contenido = 2;
    
    UPDATE contenido
	SET id_cont_relacion = 15, tipo_relacion = 'libro'
    WHERE id_contenido = 3;
    
-- Ingresar puntuaciones
-- Ingresar puntuaciones adicionales asegurando que no haya duplicados
INSERT INTO Puntuacion (puntuacion_id, puntuacion, caracteristica_id, id_contenido)
VALUES
(1, 85, 1, 10),
(2, 90, 2, 11),
(3, 75, 3, 12),
(4, 88, 4, 13),
(5, 92, 5, 14),
(6, 78, 6, 15),
(7, 84, 7, 16),
(8, 79, 8, 17),
(9, 91, 9, 18),
(10, 87, 10, 19),
(11, 86, 11, 20),
(12, 80, 12, 21),
(13, 77, 13, 22),
(14, 82, 14, 23),
(15, 89, 15, 24),
(16, 76, 16, 25),
(17, 83, 17, 26),
(18, 85, 18, 27),
(19, 81, 19, 28),
(20, 88, 20, 29),
(21, 79, 21, 30),
(22, 90, 21, 31),
(23, 74, 21, 32),
(24, 92, 21, 33),
(25, 87, 21, 34),
(26, 75, 21, 35),
(27, 83, 21, 36),
(28, 81, 21, 37),
(29, 84, 21, 38),
(30, 86, 21, 39),
(31, 5, 3, 1),
(32, 8, 12, 1),
(33, 7, 19, 1),
(34, 4, 7, 1),
(35, 9, 15, 1),
(36, 6, 11, 1),
(37, 8, 4, 1),
(38, 7, 9, 1),
(39, 5, 17, 1),
(40, 6, 2, 1),
(41, 7, 6, 2),
(42, 8, 12, 2),
(43, 5, 19, 2),
(44, 9, 7, 2),
(45, 6, 15, 2),
(46, 7, 11, 2),
(47, 8, 4, 2),
(48, 5, 9, 2),
(49, 6, 17, 2),
(50, 7, 2, 2),
(51, 8, 6, 3),
(52, 5, 12, 3),
(53, 7, 19, 3),
(54, 6, 7, 3),
(55, 9, 15, 3),
(56, 7, 11, 3),
(57, 5, 4, 3),
(58, 8, 9, 3),
(59, 6, 17, 3),
(60, 7, 2, 3),
(61, 5, 6, 4),
(62, 8, 12, 4),
(63, 7, 19, 4),
(64, 6, 7, 4),
(65, 9, 15, 4),
(66, 7, 11, 4),
(67, 5, 4, 4),
(68, 8, 9, 4),
(69, 6, 17, 4),
(70, 7, 2, 4),
(71, 8, 6, 5),
(72, 5, 12, 5),
(73, 7, 19, 5),
(74, 6, 7, 5),
(75, 9, 15, 5),
(76, 7, 11, 5),
(77, 5, 4, 5),
(78, 8, 9, 5),
(79, 6, 17, 5),
    (80, 7, 2, 5),
    (81, 7, 6, 6),
    (82, 8, 12, 6),
    (83, 5, 19, 6),
    (84, 9, 7, 6),
    (85, 6, 15, 6),
    (86, 7, 11, 6),
    (87, 8, 4, 6),
    (88, 5, 9, 6),
    (89, 6, 17, 6),
    (90, 7, 2, 6),
    (91, 8, 6, 70),
    (92, 5, 12, 70),
    (93, 7, 19, 70),
    (94, 6, 7, 70),
    (95, 9, 15, 70),
    (96, 7, 11, 70),
    (97, 5, 4, 70),
    (98, 8, 9, 70),
    (99, 6, 17, 70),
    (100, 7, 2, 70),
    (101, 8, 6, 8),
    (102, 5, 12, 8),
    (103, 7, 19, 8),
    (104, 6, 7, 8),
    (105, 9, 15, 8),
    (106, 7, 11, 8),
    (107, 5, 4, 8),
    (108, 8, 9, 8),
    (109, 6, 17, 8),
    (110, 7, 2, 8),
    (111, 8, 6, 9),
    (112, 5, 12, 9),
    (113, 7, 19, 9),
    (114, 6, 7, 9),
    (115, 9, 15, 9),
    (116, 7, 11, 9),
    (117, 5, 4, 9),
    (118, 8, 9, 9),
    (119, 6, 17, 9),
    (120, 7, 2, 9);
    
-- Insertar Recomendaciones    
INSERT INTO Recomendacion (recomendacion_id, id_contenido, fecha, opinion_id)
VALUES(1,4, '2023-06-01',  1),
(2, 6,'2023-06-02',  2), 
(3,20, '2023-06-03',  3), 
(4,3, '2023-06-04',  4), 
(5,8, '2023-06-05',  5),
(6,32, '2021-06-16', 3),
(7,40, '2022-06-15',  2),
(8, 22,'2021-06-14',  1),
(9, 11,'2023-06-13',  4),
(10,14, '2022-06-12', 3),
('11', '25', '2024-07-09', '2'),
('12', '30', '2023-03-04', '3');


-- Insertar Contenido_tipo
INSERT INTO Contenido_tipo (id_contenido, tipo_id)
VALUES (1,1),
	   (21,9), 
       (6,2), 
       (30,1), 
       (53,9), 
       (52,9), 
       (7,2), 
       (5, 1),
       (1,3), 
	   (24,4), 
	   (12,5), 
	   (20,6), 
	   (39,7), 
	   (19,8), 
	   (46,10), 
	   (2,2),
	   (4,3),
	   (44,9),
       (33,2),
       (36,3),
       (58,9),
	   (59, 9),
	   (60, 9),
	   (61, 9),
	   (62, 9),
	   (63, 9),
	   (64, 9),
	   (65, 9),
	   (66, 9),
	   (67, 9),
	   (68, 9),
	   (69, 9),
	   (70, 9),
	   (71, 9),
	   (72, 9),
	   (73, 9),
	   (74, 9),
	   (75, 9),
	   (76, 9),
	   (77, 9),
	   (78, 9),
	   (79, 9),
	   (80, 9),
	   (81, 9),
	   (82, 9),
       (22,9),
       (23,9),
       (24,9),
       (25,9);


-- Ingresar Contenido_participe
INSERT INTO Contenido_participe (id_contenido, participe_id, rol)
VALUES (2,2,"actor"),
	   (4, 2, "Actor"), 
       (7,7,"Actriz"), 
       (10,10,"Actriz"),
       (1, 2, "actor"), 
	   (24, 2, "compositor"),
	   (12, 2, "colaborador"), 
	   (20, 2, "director"), 
	   (39, 2, "invitado"),
	   (19, 2, "guionista"),
	   (46, 2, "presentador"),
       (44, 2, "asistente"),
       (1, 8, "actor"), 
	   (24, 8, "compositor"),
	   (12, 8, "colaborador"), 
	   (20, 8, "director"), 
	   (39, 8, "invitado"),
	   (19, 8, "guionista"),
	   (46, 8, "presentador"),
	   (36, 8, "asistente"),
	   (33, 8, "asistente"),
	   (58, 8, "asistente");
       
-- Ingresar Contenido_idioma
INSERT INTO Contenido_idioma (id_contenido, idioma_id)
VALUES (1,2), 
       (3,2),
       (4,2), 
       (9,2), 
       (45,2);

       
-- Ingresar Contenido_genero
INSERT INTO Contenido_genero (id_contenido, genero_id)
VALUES (1, 2),
	   (2,2),
       (4,12),
       (5,4), 
       (26,5),
       (33,2), 
       (40,1),
       (6,4),
       (27,1);
       
-- Ingresar Contenido_tematica
INSERT INTO Contenido_tematica (id_contenido, tematica_id)
VALUES (1,1), 
       (2,1), 
       (3,8), 
       (4,4), 
       (5,1);
       
-- Ingresar conversacion_tematica
INSERT INTO Conversacion_tematica (id_conversacion,tematica_id)
VALUES (1,1),
	   (1,2),
	   (2,3),
	   (2,4),
	   (3,7),
	   (3,10),
	   (4,6),
	   (4,5),
	   (5,8),
	   (5,9);  
       
-- Ingresar conversacion_caracteristica
INSERT INTO Conversacion_caracteristica (id_conversacion, caracteristica_id)
VALUES (1,1),
	   (1,6),
	   (2,2),
	   (2,14),
	   (2,3),
	   (3,4),
	   (3,8),
	   (4,20),
	   (4,19),
	   (5,16);
       
-- Ingresar conversacion_genero
INSERT INTO Conversacion_genero (id_conversacion, genero_id)
VALUES (1,1), 
       (2,2), 
       (3,3), 
       (4,4), 
       (5,5);

-- Ingresar conversacion_emocion       
INSERT INTO Conversacion_emocion (id_conversacion, emocion_id)
VALUES (1,1), 
	   (2,2), 
       (3,3), 
       (4,4), 
       (5,5);
       
-- Ingresar opinion_perfil
INSERT INTO Opinion_perfil (opinion_id, perfil_id ) 
VALUES (1,3),
	   (4,2),
       (1,5),
       (5,3),
       (1,2),
       (3,3),
       (2,1),
       (1,1),
       (2,5),
       (1,4),
       (4,3),
       (5,1),
       (3,5),
       (4,1),
       (5,5);
       
INSERT INTO `trabajo_practico_final`.`opinion_perfil` (`opinion_id`, `perfil_id`) VALUES ('4', '6');
INSERT INTO `trabajo_practico_final`.`opinion_perfil` (`opinion_id`, `perfil_id`) VALUES ('5', '7');
       
-- Ingresar contenido_emocion_caracteristica
INSERT INTO Contenido_emocion_caracteristica (id_contenido, emocion_id, caracteristica_id, ponderacion)
VALUES (1,1,21,'0.3'),
       (2,4,1,'0.4'),
       (3,10,6,'-0.2'),
       (4,2,13,'-0.8'),
       (5,6,9, '0.7'),
	   (53,11,1,'0.1'),
       (54,11,7,'0.8'),
       (55,11,1,'0.6'),
       (56,11,12,'-0.3'),
       (57,11,7,'0.3'),
       (72,11,12,'0.5'),
       (63,11,1,'0.4'),
       (21,11,1,'0.1'),
        (22,11,1,'0.4'),
        (23,11,1,'-0.2'),
        (24,11,1,'-0.1'),
        (25,11,1,'-0.2');
       
INSERT INTO Conversacion_recomendacion_perfil (id_conversacion, recomendacion_id, id_contenido, perfil_id)
VALUES (4,1,4,5),
       (3,2,6,1),
       (1,3,20,2),
       (4,4,3,3),
       (2,5,8,4);
       
       
-- CONSULTAS 
-- 1.Top 10 de contenidos (a su criterio) que tengan al menos 100 puntuaciones.
SELECT C.id_contenido, C.titulo
FROM Contenido C
JOIN Puntuacion P ON C.id_contenido = P.id_contenido
GROUP BY C.id_contenido, C.titulo
HAVING COUNT(p.id_contenido) >= 10
LIMIT 10;

-- 2.Por cada formato, mostrar cantidad de contenidos, de recomendaciones hechas, de consumidas y promedio de puntuación global.
SELECT 
	t.nombre AS formato,
    COUNT(DISTINCT ct.id_contenido) AS "Cantidad de contenidos",
    COUNT(DISTINCT r.recomendacion_id) AS "Cantidad de recomendaciones hechas",
    COUNT(DISTINCT o.opinion_id) AS "Cantidad de recomendaciones consumidas",
    AVG(o.puntuacion) AS "Promedio de puntuacion global"
FROM tipo t
LEFT JOIN contenido_tipo ct ON t.tipo_id = ct.tipo_id
LEFT JOIN contenido_genero cog ON ct.id_contenido = cog.id_contenido
LEFT JOIN conversacion_genero cng ON cog.genero_id = cng.genero_id
LEFT JOIN conversacion c ON cng.id_conversacion = c.id_conversacion
LEFT JOIN recomendacion r ON ct.id_contenido = r.id_contenido
LEFT JOIN opinion o ON r.opinion_id = o.opinion_id
GROUP BY ct.tipo_id, t.nombre;

-- 3.Armar una playlist de recomendadas con canciones emocionantes para cuando estás aburrido.
SELECT c.titulo, c.duracion
FROM Contenido c -- Entidad CONTENIDO
JOIN Contenido_tipo ct ON ct.id_contenido = c.id_contenido
JOIN Tipo t ON t.tipo_id = ct.tipo_id
JOIN Contenido_emocion_caracteristica cec ON cec.id_contenido = c.id_contenido
JOIN Emocion e ON e.emocion_id = cec.emocion_id
JOIN Caracteristica ca ON ca.caracteristica_id = cec.caracteristica_id
WHERE EXISTS (SELECT 1
			  FROM Recomendacion r
              JOIN conversacion_recomendacion_perfil crp ON crp.recomendacion_id = r.recomendacion_id
              JOIN conversacion con ON con.id_conversacion = crp.id_conversacion
              WHERE e.nombre LIKE 'aburrimiento'
              AND t.nombre LIKE 'musica'
              AND ca.descripcion IN ('conmovedor', 'alegre', 'motivador')
);

-- 4.Saga de películas más “atrapante” del catálogo
SELECT C.TITULO
FROM contenido C
JOIN contenido_tipo CT ON C.ID_CONTENIDO = CT.ID_CONTENIDO
JOIN tipo T ON CT.TIPO_ID = T.TIPO_ID
JOIN contenido_emocion_caracteristica CEC ON CT.ID_CONTENIDO = CEC.ID_CONTENIDO
JOIN caracteristica CA ON CEC.CARACTERISTICA_ID = CA.CARACTERISTICA_ID
WHERE T.NOMBRE = 'Película' AND CA.DESCRIPCION= "Atrapante"
GROUP BY C.TITULO, C.ID_CONTENIDO
ORDER BY COUNT(CA.DESCRIPCION) DESC
LIMIT 1;

-- 5. Personas que participen de alguna manera en contenidos de todos los formatos posibles
SELECT p.participe_id, p.nombre
FROM participe p
WHERE NOT EXISTS (
    SELECT t.tipo_id
    FROM Tipo t
    WHERE NOT EXISTS (
        SELECT 1
        FROM Contenido_participe cp
        JOIN Contenido_tipo ct ON cp.id_contenido = ct.id_contenido
        WHERE cp.participe_id = p.participe_id
        AND ct.tipo_id = t.tipo_id
    )
);

 -- 6.obtener los 10 contenidos más recomendados por los perfiles de usuarios que residen en Buenos Aires.
SELECT p.nombre, c.titulo, c.anio_publicacion, p.lugar_residencia
FROM perfil p
JOIN opinion_perfil op ON p.perfil_id = op.perfil_id
JOIN opinion o ON op.opinion_id = o.opinion_id
JOIN recomendacion r ON o.opinion_id = r.opinion_id
JOIN contenido c ON r.id_contenido = c.id_contenido
WHERE p.lugar_residencia = 'Buenos Aires'
GROUP BY p.nombre, c.titulo, c.anio_publicacion, p.lugar_residencia
LIMIT 10;

-- 7.Generar una vista de la ficha técnica de un contenido cualquiera
-- Cada contenido tendrá una especie de ficha técnica con título,
-- formato, duración o tiempo estimado (caso de libros o juegos), año de publicación, origen,
-- géneros, temáticas y partícipes
DROP VIEW IF EXISTS ficha_tecnica_contenido;
CREATE VIEW ficha_tecnica_contenido AS
SELECT
    c.titulo,
    t.nombre AS formato,
    c.duracion,
    c.anio_publicacion,
   p.nombre AS pais_origen,
    g.descripcion AS genero,
    tm.nombre AS tematica,
    pa.nombre AS participe
FROM Contenido c 
JOIN Pais p ON c.id_pais = p.pais_id
JOIN Contenido_tipo ct ON c.id_contenido = ct.id_contenido
JOIN Tipo t ON ct.tipo_id = t.tipo_id
LEFT JOIN Contenido_genero cg ON c.id_contenido = cg.id_contenido
LEFT JOIN Genero g ON cg.genero_id = g.genero_id
LEFT JOIN Contenido_tematica ctm ON c.id_contenido = ctm.id_contenido
LEFT JOIN Tematica tm ON ctm.tematica_id = tm.tematica_id
LEFT JOIN Contenido_participe cp ON c.id_contenido = cp.id_contenido
LEFT JOIN Participe pa ON cp.participe_id = pa.participe_id
LEFT JOIN Contenido_emocion_caracteristica cec ON c.id_contenido = cec.id_contenido
WHERE c.id_contenido = 2; -- Ficha tecnica del contenido 2

SELECT * FROM ficha_tecnica_contenido;
