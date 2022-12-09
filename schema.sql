/* Database schema to keep the structure of entire database. */
/* Project - create animals table. */
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);
/* Project - query and update animals table */
ALTER TABLE animals
ADD species VARCHAR(50);
/* Project - query multiple tables */
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INT,
    PRIMARY KEY(id)
);
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    PRIMARY KEY(id)
);
\ d animals
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals
ADD COLUMN species_id INT CONSTRAINT species_fk REFERENCES species (id);
ALTER TABLE animals
ADD COLUMN owner_id INT CONSTRAINT owner_fk REFERENCES owners (id);