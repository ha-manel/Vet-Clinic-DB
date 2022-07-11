/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD species varchar(30);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name varchar(100),
    age INT
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(30)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INT REFERENCES species(id);
ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id)
);

CREATE TABLE visits (
    vet_id INT REFERENCES vets(id),
    animal_id INT REFERENCES animals(id),
    date_of_visit DATE
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create indexes
CREATE INDEX animal_ids ON visits (animal_id);

CREATE INDEX vet_ids ON visits (vet_id);

CREATE INDEX owner_emails ON owners (email);
