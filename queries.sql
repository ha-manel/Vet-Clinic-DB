/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

SELECT * 
FROM animals 
WHERE name LIKE '%mon';

SELECT name 
FROM animals 
WHERE date_of_birth BETWEEN '01-01-2016' AND '12-31-2019';

SELECT name 
FROM animals 
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth 
FROM animals 
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts 
FROM animals 
WHERE weight_kg > 10.5;

SELECT * 
FROM animals 
WHERE neutered = true;

SELECT * 
FROM animals 
WHERE name != 'Gabumon';

SELECT * 
FROM animals 
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN;
UPDATE animals 
SET species = 'unspecified';

SELECT name, species 
FROM animals;

ROLLBACK;

SELECT name, species 
FROM animals;


BEGIN;
UPDATE animals 
SET species = 'digimon' 
WHERE name LIKE '%mon';

UPDATE animals 
SET species = 'pokemon' 
WHERE species IS NULL;

SELECT name, species 
FROM animals;
COMMIT;


BEGIN;
DELETE 
FROM animals;
ROLLBACK;


BEGIN; 
DELETE 
FROM animals 
WHERE date_of_birth > '01-01-2022';

SELECT name, date_of_birth 
FROM animals;

SAVEPOINT SP1;

UPDATE animals 
SET weight_kg = weight_kg * -1;

SELECT name, weight_kg 
FROM animals;

ROLLBACK TO SP1;

UPDATE animals 
SET weight_kg = weight_kg * -1 
WHERE weight_kg < 0;

SELECT name, weight_kg 
FROM animals;
COMMIT;


SELECT COUNT(*) AS animals_count 
FROM animals;

SELECT COUNT(*) AS never_escaped_animals 
FROM animals 
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS avg_weight 
FROM animals;

SELECT COUNT(escape_attempts) AS escape_count, neutered 
FROM animals 
GROUP BY neutered;

SELECT MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight, species 
FROM animals 
GROUP BY species;

SELECT AVG(escape_attempts) as avg_escapes, species 
FROM animals 
WHERE date_of_birth BETWEEN '01-01-1990' AND '12-31-2000' 
GROUP BY species;


SELECT name 
FROM animals 
JOIN owners ON owners.full_name = 'Melody Pond' AND owners.id = animals.owner_id;

SELECT * 
FROM animals 
JOIN species ON species.name = 'Pokemon' AND species.id = animals.species_id;

SELECT name, full_name 
FROM animals 
RIGHT OUTER JOIN owners ON animals.owner_id = owners.id;

SELECT COUNT(*), species.name 
FROM animals 
JOIN species ON animals.species_id = species.id 
GROUP BY species.id;

SELECT animals.name, animals.species_id, owners.full_name AS owner 
FROM animals 
JOIN owners ON owners.full_name = 'Jennifer Orwell' AND animals.species_id = (SELECT id FROM species WHERE name = 'Digimon') AND owners.id = animals.owner_id;

SELECT animals.name, animals.escape_attempts, owners.full_name AS owner 
FROM animals 
JOIN owners ON owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0 AND owners.id = animals.owner_id;

SELECT COUNT(*), owners.full_name AS owner FROM animals 
JOIN owners ON animals.owner_id = owners.id 
GROUP BY owners.full_name 
ORDER BY COUNT(*) DESC 
LIMIT 1;

SELECT vets.name AS vet_name, animals.name AS animal_name, date_of_visit 
FROM visits 
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher') 
AND animals.id = visits.animal_id 
ORDER BY date_of_visit DESC 
LIMIT 1;

SELECT DISTINCT vets.name AS vet_name, animals.name AS animal_name 
FROM visits 
JOIN animals ON animals.id = visits.animal_id 
AND vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
JOIN vets ON vets.id = visits.vet_id;

SELECT vets.name AS vet_name, species.name AS specialty
FROM specializations 
RIGHT OUTER JOIN vets ON vets.id = specializations.vet_id 
LEFT OUTER JOIN species ON species.id = specializations.species_id;

SELECT vets.name AS vet_name, animals.name AS animal_name, date_of_visit
FROM visits
JOIN animals ON animals.id = visits.vet_id
JOIN vets ON vets.id = visits.vet_id AND vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '04-01-2020' AND '08-30-2020';

SELECT animals.name, COUNT(animal_id) 
FROM visits
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(animal_id) DESC
LIMIT 1;

SELECT vets.name AS vet_name, animals.name AS animal_name, date_of_visit
FROM visits
JOIN vets ON vets.id = visits.vet_id AND vets.name = 'Maisy Smith'
JOIN animals ON animals.id = visits.animal_id
ORDER BY date_of_visit ASC
LIMIT 1;

SELECT * 
FROM visits
FULL OUTER JOIN animals ON animals.id = visits.animal_id
FULL OUTER JOIN vets ON vets.id = visits.vet_id
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) 
FROM vets
JOIN visits ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN specializations ON vets.id = specializations.vet_id
WHERE NOT specializations.species_id = animals.species_id;

SELECT species.name
FROM animals
JOIN species ON species.id = animals.species_id
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id AND vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species_id) DESC
LIMIT 1;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;

EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
