CREATE TABLE characters (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  show_id INTEGER,

  FOREIGN KEY(show_id) REFERENCES show(id)
);

CREATE TABLE shows (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  showType_id INTEGER,

  FOREIGN KEY(showType_id) REFERENCES showType(id)
);

CREATE TABLE showTypes (
  id INTEGER PRIMARY KEY,
  genre VARCHAR(255) NOT NULL
);

INSERT INTO
  showTypes (id, genre)
VALUES
  (1, "Thriller"), (2, "Comedy");

INSERT INTO
  shows (id, name, showType_id)
VALUES
  (1, "Sherlock", 2),
  (2, "Homeland", 1),
  (3, "Game of Thrones", 1),
  (4, "How I Met Your Mother", 2);

INSERT INTO
  characters (id, name, show_id)
VALUES
  (1, "Sherlock Holmes", 1),
  (2, "John Watson", 1),
  (3, "Carrie Mathison", 2),
  (4, "Saul Berenson", 2),
  (5, "Daenerys Targaryen", 3),
  (6, "Tyrion Lannister", 3),
  (8, "Robin Scherbatsky", 4);
