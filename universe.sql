-- drop in case the database is already made
DROP DATABASE universe;

-- create the database
CREATE DATABASE universe;

\connect universe;

--DATABASE TABLES 
CREATE TABLE galaxy
(
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE, 
  description TEXT NOT NULL,
  has_life BOOLEAN,
  galaxy_class INT,
  galaxy_age_millions NUMERIC(8, 2)
);

CREATE TABLE star
(
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  description TEXT NOT NULL,
  star_type VARCHAR(30),
  has_planet_in_orbit BOOLEAN,
  galaxy_id INT REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet
(
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  description TEXT NOT NULL,
  planet_type INT,
  has_moons BOOLEAN,
  number_of_moons INT,
  has_life BOOLEAN,
  star_id INT REFERENCES star(star_id)
);

CREATE TABLE moon
(
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  description TEXT NOT NULL,
  moon_type INT, 
  planet_id INT REFERENCES planet(planet_id)
);

CREATE TABLE guardian
(
  guardian_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  description TEXT NOT NULL,
  guardian_class INT UNIQUE
);

-- INSERT STATEMENTS 
-- Inserting 6 rows into the galaxy table
INSERT INTO galaxy (name, description, has_life, galaxy_class, galaxy_age_millions)
VALUES
  ('Milky Way', 'A spiral galaxy that contains our solar system.', TRUE, 1, 13.8),
  ('Andromeda', 'The closest spiral galaxy to the Milky Way.', FALSE, 1, 10),
  ('Triangulum', 'A member of the Local Group of galaxies.', TRUE, 1, 3.1),
  ('Whirlpool', 'A spiral galaxy known for its distinct spiral arms.', TRUE, 1, 8.5),
  ('Messier 87', 'An elliptical galaxy in the Virgo Cluster.', FALSE, 2, 13.5),
  ('Sombrero', 'A spiral galaxy with a bright nucleus and large central bulge.', FALSE, 1, 10.6);

-- Inserting 6 rows into the star table
INSERT INTO star (name, description, star_type, has_planet_in_orbit, galaxy_id)
VALUES
  ('Sun', 'The star at the center of our Solar System.', 'G-type main-sequence', TRUE, 1),
  ('Alpha Centauri A', 'A binary star system that is the closest to the Sun.', 'G-type main-sequence', TRUE, 2),
  ('Proxima Centauri', 'The closest known star to the Sun, part of the Alpha Centauri system.', 'Red dwarf', TRUE, 2),
  ('Betelgeuse', 'A red supergiant star in the constellation of Orion.', 'Red supergiant', FALSE, 3),
  ('Sirius', 'The brightest star in the Earths night sky, part of the constellation Canis Major.', 'A-type main-sequence', TRUE, 4),
  ('Rigel', 'A blue supergiant star in the constellation Orion.', 'Blue supergiant', FALSE, 5);

-- Inserting 12 rows into the planet table
INSERT INTO planet (name, description, planet_type, has_moons, number_of_moons, has_life, star_id)
VALUES
  ('Earth', 'The third planet from the Sun, known for its ability to support life.', 1, TRUE, 1, TRUE, 1),
  ('Mars', 'The fourth planet from the Sun, known for its red color and potential signs of past life.', 2, TRUE, 2, FALSE, 2),
  ('Jupiter', 'The largest planet in the Solar System, a gas giant with a strong magnetic field.', 3, TRUE, 79, FALSE, 3),
  ('Venus', 'The second planet from the Sun, known for its extreme heat and toxic atmosphere.', 2, FALSE, 0, FALSE, 4),
  ('Saturn', 'The sixth planet from the Sun, famous for its rings made of ice and rock.', 3, TRUE, 82, FALSE, 5),
  ('Mercury', 'The closest planet to the Sun, with extreme temperature variations.', 2, FALSE, 0, FALSE, 6),
  ('Neptune', 'The eighth planet from the Sun, an icy giant with high winds.', 4, TRUE, 14, FALSE, 1),
  ('Uranus', 'The seventh planet from the Sun, with a tilted axis and a ring system.', 4, TRUE, 27, FALSE, 2),
  ('Pluto', 'A dwarf planet, once considered the ninth planet in the Solar System.', 5, TRUE, 5, FALSE, 3),
  ('Titan', 'A moon of Saturn, larger than the planet Mercury, with a thick atmosphere.', 6, TRUE, 1, FALSE, 4),
  ('Ganymede', 'The largest moon of Jupiter, larger than the planet Mercury.', 6, TRUE, 1, FALSE, 5),
  ('Kepler-22b', 'An exoplanet in the habitable zone of its star, similar to Earth.', 1, FALSE, 0, TRUE, 6);

-- Inserting 20 rows into the moon table with planet_id values ranging from 1 to 12
INSERT INTO moon (name, description, moon_type, planet_id)
VALUES
  ('Luna', 'Earths only natural satellite, known for its phases and tides.', 1, 1),
  ('Phobos', 'The larger of Mars two moons, irregularly shaped and close to the planet.', 2, 2),
  ('Deimos', 'The smaller of Mars two moons, a distant and irregular moon.', 2, 2),
  ('Io', 'A volcanic moon of Jupiter, with the most active volcanoes in the Solar System.', 3, 3),
  ('Europa', 'A moon of Jupiter with an icy surface, believed to have an ocean beneath.', 4, 3),
  ('Ganymede', 'The largest moon of Jupiter, even larger than the planet Mercury.', 3, 3),
  ('Callisto', 'A heavily cratered moon of Jupiter, largely made of ice and rock.', 4, 3),
  ('Titan', 'A large moon of Saturn, with a thick atmosphere and lakes of methane.', 3, 4),
  ('Rhea', 'A moon of Saturn, composed mostly of water ice and some rock.', 4, 4),
  ('Iapetus', 'A moon of Saturn, known for its two-tone coloration and unusual equatorial ridge.', 4, 4),
  ('Mimas', 'A small, icy moon of Saturn, resembling the Death Star due to a large crater.', 4, 4),
  ('Enceladus', 'A moon of Saturn with geysers that eject water from an underground ocean.', 4, 4),
  ('Triton', 'The largest moon of Neptune, known for its retrograde orbit and icy surface.', 3, 5),
  ('Charon', 'The largest moon of Pluto, forming a binary system with its parent dwarf planet.', 2, 6),
  ('Ariel', 'A moon of Uranus, characterized by a geologically active surface and icy terrain.', 4, 7),
  ('Umbriel', 'A dark moon of Uranus, covered in ice and craters.', 4, 7),
  ('Miranda', 'A moon of Uranus, known for its strange and extreme geological features.', 3, 7),
  ('Titania', 'The largest moon of Uranus, composed mainly of ice and rock with a heavily cratered surface.', 4, 7),
  ('Oberon', 'Another large moon of Uranus, characterized by large craters and icy features.', 4, 7),
  ('Triton-X', 'A large, mysterious moon of Neptune, whose origins remain unclear.', 5, 5);


-- Inserting 5 rows into the guardians table
INSERT INTO guardian (name, description, guardian_class)
VALUES
  ('Astra', 'A celestial guardian who protects the balance of the stars.', 1),
  ('Titan', 'A powerful guardian with immense strength, protector of the planets.', 2),
  ('Nebula', 'A mystic guardian who controls the cosmic storms and nebulae.', 3),
  ('Phoenix', 'A fiery guardian, reborn from the ashes, safeguarding the universe.', 4),
  ('Luna', 'A guardian of the moon, tasked with ensuring its phases remain undisturbed.', 5);
