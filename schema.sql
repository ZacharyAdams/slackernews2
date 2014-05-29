CREATE TABLE articles (
  id serial PRIMARY KEY,
  title varchar(1000) NOT NULL,
  url varchar(1000) NOT NULL,
  description varchar(1000) NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE comments (
  id serial PRIMARY KEY,
  content varchar(1000) NOT NULL,
  created_at TIMESTAMP NOT NULL
  );
