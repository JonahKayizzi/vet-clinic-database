/*Queries that provide answers to the questions from all projects.*/
/*Queries that provide answers to questions from project - create animals table*/
SELECT *
FROM animals
WHERE name LIKE '%mon';
SELECT name
FROM animals
WHERE date_of_birth BETWEEN 'Jan 01,2016' AND 'Dec 31, 2019';
SELECT name
FROM animals
WHERE neutered = true
    AND escape_attempts < 3;
SELECT date_of_birth
FROM animals
WHERE name in ('Agumon', 'Pikachu');
SELECT name,
    escape_attempts
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
WHERE weight_kg BETWEEN 10.4 AND 17.3;
/*Queries that provide answers to questions from project - query and update animals table*/
/*Part 1*/
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
BEGIN;
DELETE FROM animals;
ROLLBACK;
BEGIN;
DELETE FROM animals
WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT savepoint1;
UPDATE animals
SET weight_kg = (weight_kg * -1);
ROLLBACK TO SAVEPOINT savepoint1;
UPDATE animals
SET weight_kg = (weight_kg * -1)
WHERE weight_kg < 0;
COMMIT;
/*Part 2*/
SELECT COUNT(*)
FROM animals;
SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;
SELECT AVG(weight_kg)
FROM animals;
SELECT neutered,
    SUM(escape_attempts)
FROM animals
GROUP BY neutered;
SELECT species,
    MAX(weight_kg),
    MIN(weight_kg)
FROM animals
GROUP BY species;
SELECT species,
    AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN 'Jan 01, 1990' AND 'Dec 31, 2000'
GROUP BY species;
/* Project - query multiple tables */
SELECT a.name
FROM animals a
    JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';
SELECT a.name
FROM animals a
    JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';
SELECT o.full_name,
    a.name
FROM owners o
    LEFT JOIN animals a ON o.id = a.owner_id;
SELECT count(*),
    s.name
FROM animals a
    JOIN species s ON a.species_id = s.id
GROUP BY s.name;
SELECT a.name
FROM animals a
    JOIN owners o ON a.owner_id = o.id
    JOIN species s ON a.species_id = s.id
WHERE s.name = 'Digimon'
    AND o.full_name = 'Jennifer Orwell';
SELECT a.name
FROM animals a
    JOIN owners o ON a.owner_id = o.id
WHERE a.escape_attempts = 0
    AND o.full_name = 'Dean Winchester';
SELECT combined.full_name
FROM (
        SELECT o.full_name,
            COUNT (a.name) AS animal_number
        FROM owners o
            LEFT JOIN animals a ON o.id = a.owner_id
        GROUP BY o.full_name
    ) AS combined
WHERE combined.animal_number = (
        SELECT MAX (animal_number)
        FROM (
                SELECT o.full_name,
                    COUNT (a.name) AS animal_number
                FROM owners o
                    LEFT JOIN animals a ON o.id = a.owner_id
                GROUP BY o.full_name
            ) AS xx
    );
/* Project - add join tables */
SELECT a.name
FROM animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;
SELECT COUNT(*)
FROM (
        SELECT v.animal_id
        from visits v
            JOIN vets ve ON v.vet_id = ve.id
        WHERE ve.name = 'Stephanie Mendez'
        GROUP BY v.animal_id
    ) as xx;
SELECT ve.name as vet_name,
    s.name as species_name
FROM vets ve
    LEFT JOIN specializations sp ON ve.id = sp.vet_id
    LEFT JOIN species s ON sp.species_id = s.id;
SELECT a.name
FROM animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets as ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez'
    AND v.visit_date BETWEEN 'April 1, 2020' AND 'August 30, 2020';
SELECT COUNT(v.animal_id) total_animal_visits,
    a.name as animal_name
FROM visits v
    JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY total_animal_visits DESC
LIMIT 1;
SELECT a.name
FROM animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;
SELECT a.name as animal_name,
    a.date_of_birth as animal_dob,
    a.escape_attempts,
    a.neutered,
    a.weight_kg,
    ve.name as vet_name,
    ve.age as vet_age,
    ve.date_of_graduation as vet_date_of_graduation,
    v.visit_date
FROM animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets ve ON v.vet_id = ve.id
ORDER BY v.visit_date DESC
LIMIT 1;
SELECT count(*) as total_visits,
    s.name as species_name
FROM visits v
    JOIN vets ve ON v.vet_id = ve.id
    JOIN animals a ON v.animal_id = a.id
    JOIN species s ON a.species_id = s.id
WHERE ve.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY total_visits DESC;
