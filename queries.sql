/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <  '2020-01-01';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name AS "ANIMALS NAME" FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name AS "ANIMALS NAME" FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name AS "OWNERS NAME", animals.name AS "ANIMALS NAME" FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
SELECT species.name AS "SPECIES NAME", COUNT(*) AS "no of SPECIES" FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name AS "ANIMALS NAME" FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT animals.name AS "ANIMALS NAME" FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name AS "OWNERS NAME", COUNT(*) AS "no of ANIMALS" FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;

SELECT visits.animal_id, animals.name FROM visits JOIN animals ON visits.animal_id = animals.id WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher') ORDER BY visit_date DESC LIMIT 1;
SELECT COUNT(*) AS "no of Animals" FROM visits JOIN animals ON visits.animal_id = animals.id WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');
SELECT vets.name AS "Vets", species.name AS "Species" FROM specializations RIGHT JOIN vets ON specializations.vet_id = vets.id LEFT JOIN species ON specializations.species_id = species.id;
SELECT visits.animal_id, animals.name FROM visits JOIN animals ON visits.animal_id = animals.id WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez') AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';
SELECT animals.name, visits.animal_id, COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY count(*) DESC LIMIT 1;
SELECT animals.name AS "Animal Name", COUNT(*) AS "no of Visits" FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT(*) DESC LIMIT 1;
SELECT visits.animal_id, animals.name FROM visits JOIN animals ON visits.animal_id = animals.id WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') ORDER BY visit_date ASC LIMIT 1;
SELECT animals.name, vets.name, visits.visit_date FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id ORDER BY visits.visit_date DESC LIMIT 1;
SELECT COUNT(*) AS "no of Visits" FROM vets JOIN visits ON vets.id = visits.vet_id LEFT JOIN specializations ON vets.id = specializations.vet_id LEFT JOIN species ON specializations.species_id = species.id WHERE species IS NULL;
SELECT species.name AS "Species Name" FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id JOIN species ON animals.species_id = species.id WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') GROUP BY species.name ORDER BY count(animals.name) DESC LIMIT 1;


explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;


SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';


EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
