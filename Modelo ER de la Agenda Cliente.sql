CREATE TABLE `AspNetUsers` (
  `Id` varchar(28) PRIMARY KEY AUTO_INCREMENT,
  `NombreComplerto` varchar(255),
  `Email` varchar(255)
);

CREATE TABLE `eventos_usuario` (
  `id_evento` int PRIMARY KEY AUTO_INCREMENT,
  `usuario_creador` varchar(28),
  `nombre_evento` varchar(255) COMMENT 'nombre del evento',
  `fecha_inicio` timestamp COMMENT 'fecha en que se ejecuta el evento',
  `fecha_fin` timestamp COMMENT 'fecha en que se termina el evento , se unen hora_inicio y hora_fin',
  `todo_el_dia` boolean DEFAULT false COMMENT 'Valida si se ejecuta todo el dia el evento',
  `tiempo_recordatorio` int COMMENT 'El tiempo que se va recordar antes de la fecha indicada',
  `rango_recordatorio` char(10) COMMENT 'El rango del tiempo a recordar si es en horas o minutos',
  `model_type` varchar(255),
  `model_id` int,
  `color` varchar(30),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `medios_notificacion` (
  `id_notificacion` int PRIMARY KEY,
  `nombre_tipo_notificacion` varchar(255) COMMENT 'Es el nombre del tipo de notificacion como web push o app movil',
  `habilitado` boolean COMMENT 'Podemos usarlo para manipular el tipo de notificacion si lo habilitamos en el sistema o no',
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `tipos_notificacion_has_eventos_usuarios` (
  `id_notificacion_evento` int PRIMARY KEY,
  `id_evento_usuario` int,
  `id_medio_notificacion` int,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `notas_eventos` (
  `id_nota` int PRIMARY KEY AUTO_INCREMENT,
  `id_evento_usuario` int,
  `titulo` text COMMENT 'El titulo del comentario de la nota en el evento',
  `contenido` text COMMENT 'El comentario de la nota en el evento',
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `calendarios` (
  `id_calendario` int PRIMARY KEY AUTO_INCREMENT,
  `usuario_creador` varchar(28),
  `nombre_calendario` varchar(255) COMMENT 'Es el nombre del caledario o agrupacion donde van a ir varios eventos , cuando es fecha cronograma debe ser el codigo de proceso junto con la entidad del contrato ',
  `id_contrato` numeric DEFAULT null,
  `color` varchar(30),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `Contrato` (
  `idContrato` numeric PRIMARY KEY AUTO_INCREMENT,
  `Nombre` varchar(255),
  `FechaPublicacion` timestamp,
  `Link` text
);

CREATE TABLE `invitados_eventos` (
  `id_invitacion` int PRIMARY KEY AUTO_INCREMENT,
  `id_evento_usuario` int,
  `usuario_invitado` varchar(28),
  `created_at` timestamp,
  `updated_at` timestamp
);

ALTER TABLE `eventos_usuario` ADD FOREIGN KEY (`usuario_creador`) REFERENCES `AspNetUsers` (`Id`);

ALTER TABLE `tipos_notificacion_has_eventos_usuarios` ADD FOREIGN KEY (`id_evento_usuario`) REFERENCES `eventos_usuario` (`id_evento`);

ALTER TABLE `tipos_notificacion_has_eventos_usuarios` ADD FOREIGN KEY (`id_medio_notificacion`) REFERENCES `medios_notificacion` (`id_notificacion`);

ALTER TABLE `notas_eventos` ADD FOREIGN KEY (`id_evento_usuario`) REFERENCES `eventos_usuario` (`id_evento`);

ALTER TABLE `calendarios` ADD FOREIGN KEY (`usuario_creador`) REFERENCES `AspNetUsers` (`Id`);

ALTER TABLE `calendarios` ADD FOREIGN KEY (`id_contrato`) REFERENCES `Contrato` (`idContrato`);

ALTER TABLE `invitados_eventos` ADD FOREIGN KEY (`id_evento_usuario`) REFERENCES `eventos_usuario` (`id_evento`);

ALTER TABLE `invitados_eventos` ADD FOREIGN KEY (`usuario_invitado`) REFERENCES `AspNetUsers` (`Id`);
