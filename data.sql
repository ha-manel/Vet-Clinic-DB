/* Populate database with sample data. */

INSERT INTO animals (name) VALUES 
  ('Luna'),
  ('Daisy'),
  ('Charlie');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
  ('Agumon', 'Feb 3, 2020', 0, true, 10.23),
  ('Gabumon', 'Nov 15, 2018', 2, true, 8),
  ('Pikachu', 'Jan 7, 2021', 1, false, 15.04),
  ('Devimon', 'May 12, 2017', 5, true, 11),
  ('Charmander', 'Feb 8, 2020', 0, false, -11),
  ('Plantmon', 'Nov 15, 2021', 2, true, -5.7),
  ('Squirtle', 'Apr 2, 1993', 3, false, -12.13),
  ('Angemon', 'Jun 12, 2005', 1, true, -45),
  ('Boarmon', 'Jun 7, 2005', 7, true, 20.4),
  ('Blossom', 'Oct 13, 1998', 3, true, 17),
  ('Blossom', 'Oct 13, 1998', 3, true, 17),
  ('Ditto', 'May 14, 2022', 4, true, 22);

INSERT INTO owners (full_name, age) VALUES 
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES 
  ('Pokemon'),
  ('Digimon');

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';


INSERT INTO vets (name, age, date_of_graduation) VALUES 
  ('William Tatcher', 45, 'Apr 23, 2000'),
  ('Maisy Smith', 26, 'Jan 17, 2019'),
  ('Stephanie Mendez', 64, 'May 4, 1981'),
  ('Jack Harkness', 38, 'Jun 8, 2008');

INSERT INTO specializations VALUES 
  ((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Digimon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'),(SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO visits VALUES
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), 'May 24, 2020'),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), 'Jul 22, 2020'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), 'Feb 2, 2021'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), 'Jan 5, 2020'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), 'Mar 8, 2020'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), 'May 14, 2020'),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), 'May 4, 2021'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), 'Feb 24, 2021'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), 'Dec 21, 2019'),
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), 'Aug 10, 2020'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), 'Apr 7, 2021'),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), 'Sep 29, 2019'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), 'Oct 3, 2020'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), 'Nov 4, 2020'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), 'Jan 24, 2019'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), 'May 15, 2019'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), 'Feb 27, 2020'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), 'Aug 3, 2020'),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), 'May 24, 2020'),
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), 'Jan 11, 2021');

  -- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
