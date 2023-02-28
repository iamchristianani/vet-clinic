/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL,
  PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(250);

CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(250),
age INT,
PRIMARY KEY(id)
);

CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(250),
PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT FK_Animals_Species 
FOREIGN KEY (species_id) 
REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT FK_Animals_Owner 
FOREIGN KEY (owner_id) 
REFERENCES owners (id);


CREATE TABLE vets (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(250),
age INT,
date_of_graduation DATE,
PRIMARY KEY(id)
);

CREATE TABLE specializations (
vet_id INT REFERENCES vets(id),
species_id INT REFERENCES species(id),
PRIMARY KEY(species_id, vet_id)
);

CREATE TABLE visits (
animal_id INT REFERENCES animals(id),
vet_id INT REFERENCES vets(id),
visit_date DATE,
PRIMARY KEY(animal_id, vet_id, visit_date)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Remove the primary keys from the visits table
ALTER TABLE visits DROP CONSTRAINT visits_pkey;

CREATE INDEX animals_visits_idx ON visits(animal_id);

CREATE INDEX vets_visits_idx ON visits(vet_id);

CREATE INDEX owners_visits_idx ON owners(email); 