DROP TABLE IF EXISTS `stickers`;

CREATE TABLE IF NOT EXISTS stickers (
    id            INT          NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255) NOT NULL,
    vehicle_hash  VARCHAR(50)  NOT NULL,
    vehicle_plate VARCHAR(50)  NOT NULL,
    scale         FLOAT        NOT NULL,
    rotation      FLOAT        NOT NULL,
    ray_from_x    FLOAT        NOT NULL,
    ray_from_y    FLOAT        NOT NULL,
    ray_from_z    FLOAT        NOT NULL,
    ray_to_x      FLOAT        NOT NULL,
    ray_to_y      FLOAT        NOT NULL,
    ray_to_z      FLOAT        NOT NULL,

    CONSTRAINT stickers_pk_id PRIMARY KEY (id)
) COLLATE utf8mb4_general_ci;