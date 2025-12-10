// ===============================
//  CONSTRAINTS
// ===============================

CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE u.userId IS UNIQUE;
CREATE CONSTRAINT movie_id IF NOT EXISTS FOR (m:Movie) REQUIRE m.movieId IS UNIQUE;
CREATE CONSTRAINT series_id IF NOT EXISTS FOR (s:Series) REQUIRE s.seriesId IS UNIQUE;
CREATE CONSTRAINT genre_name IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;
CREATE CONSTRAINT actor_id IF NOT EXISTS FOR (a:Actor) REQUIRE a.actorId IS UNIQUE;
CREATE CONSTRAINT director_id IF NOT EXISTS FOR (d:Director) REQUIRE d.directorId IS UNIQUE;

// ===============================
//  CRIAÇÃO DE GÊNEROS
// ===============================

CREATE (g1:Genre {name:"Action"});
CREATE (g2:Genre {name:"Comedy"});
CREATE (g3:Genre {name:"Drama"});
CREATE (g4:Genre {name:"Sci-Fi"});
CREATE (g5:Genre {name:"Thriller"});

// ===============================
//  CRIAÇÃO DE ATORES
// ===============================

CREATE (a1:Actor {actorId:"A01", name:"Alice Souza"});
CREATE (a2:Actor {actorId:"A02", name:"Bruno Lima"});
CREATE (a3:Actor {actorId:"A03", name:"Carla Mendes"});
CREATE (a4:Actor {actorId:"A04", name:"Daniel Rocha"});
CREATE (a5:Actor {actorId:"A05", name:"Elisa Torres"});

// ===============================
//  CRIAÇÃO DE DIRETORES
// ===============================

CREATE (d1:Director {directorId:"D01", name:"Rafael Costa"});
CREATE (d2:Director {directorId:"D02", name:"Fernanda Dias"});
CREATE (d3:Director {directorId:"D03", name:"Gustavo Freitas"});

// ===============================
//  CRIAÇÃO DE MOVIES (6)
// ===============================

CREATE (m1:Movie {movieId:"M01", title:"Eclipse Urbano", year:2020});
CREATE (m2:Movie {movieId:"M02", title:"O Último Código", year:2022});
CREATE (m3:Movie {movieId:"M03", title:"Rir Pra Não Chorar", year:2021});
CREATE (m4:Movie {movieId:"M04", title:"Zona de Impacto", year:2019});
CREATE (m5:Movie {movieId:"M05", title:"Horizonte Paralelo", year:2023});
CREATE (m6:Movie {movieId:"M06", title:"Caminho Sombrio", year:2024});

// ===============================
//  CRIAÇÃO DE SÉRIES (4)
// ===============================

CREATE (s1:Series {seriesId:"S01", title:"Reflexo Digital", seasons:2});
CREATE (s2:Series {seriesId:"S02", title:"Rota 66", seasons:3});
CREATE (s3:Series {seriesId:"S03", title:"Núcleo Zero", seasons:1});
CREATE (s4:Series {seriesId:"S04", title:"Conexões", seasons:4});

// ===============================
//  GÊNEROS DOS FILMES/SÉRIES
// ===============================

MATCH (m1:Movie),(g1:Genre {name:"Action"}) CREATE (m1)-[:IN_GENRE]->(g1);
MATCH (m2:Movie),(g4:Genre {name:"Sci-Fi"}) CREATE (m2)-[:IN_GENRE]->(g4);
MATCH (m3:Movie),(g2:Genre {name:"Comedy"}) CREATE (m3)-[:IN_GENRE]->(g2);
MATCH (m4:Movie),(g5:Genre {name:"Thriller"}) CREATE (m4)-[:IN_GENRE]->(g5);
MATCH (m5:Movie),(g4:Genre {name:"Sci-Fi"}) CREATE (m5)-[:IN_GENRE]->(g4);
MATCH (m6:Movie),(g3:Genre {name:"Drama"}) CREATE (m6)-[:IN_GENRE]->(g3);

MATCH (s1:Series),(g4:Genre) CREATE (s1)-[:IN_GENRE]->(g4);
MATCH (s2:Series),(g1:Genre) CREATE (s2)-[:IN_GENRE]->(g1);
MATCH (s3:Series),(g5:Genre) CREATE (s3)-[:IN_GENRE]->(g5);
MATCH (s4:Series),(g3:Genre) CREATE (s4)-[:IN_GENRE]->(g3);

// ===============================
//  ATORES EM FILMES/SÉRIES
// ===============================

MATCH (a1),(m1) CREATE (a1)-[:ACTED_IN]->(m1);
MATCH (a2),(m2) CREATE (a2)-[:ACTED_IN]->(m2);
MATCH (a3),(m3) CREATE (a3)-[:ACTED_IN]->(m3);
MATCH (a4),(m4) CREATE (a4)-[:ACTED_IN]->(m4);
MATCH (a5),(m5) CREATE (a5)-[:ACTED_IN]->(m5);

MATCH (a1),(s1) CREATE (a1)-[:ACTED_IN]->(s1);
MATCH (a2),(s2) CREATE (a2)-[:ACTED_IN]->(s2);
MATCH (a3),(s3) CREATE (a3)-[:ACTED_IN]->(s3);
MATCH (a4),(s4) CREATE (a4)-[:ACTED_IN]->(s4);

// ===============================
//  DIRETORES EM FILMES/SÉRIES
// ===============================

MATCH (d1),(m1) CREATE (d1)-[:DIRECTED]->(m1);
MATCH (d2),(m2) CREATE (d2)-[:DIRECTED]->(m2);
MATCH (d3),(m3) CREATE (d3)-[:DIRECTED]->(m3);

MATCH (d1),(s1) CREATE (d1)-[:DIRECTED]->(s1);
MATCH (d2),(s2) CREATE (d2)-[:DIRECTED]->(s2);

// ===============================
//  CRIAÇÃO DE 10 USUÁRIOS
// ===============================

UNWIND [
  {id:"U01", name:"João"},
  {id:"U02", name:"Maria"},
  {id:"U03", name:"Pedro"},
  {id:"U04", name:"Ana"},
  {id:"U05", name:"Lucas"},
  {id:"U06", name:"Carla"},
  {id:"U07", name:"Rafaela"},
  {id:"U08", name:"Felipe"},
  {id:"U09", name:"Vinícius"},
  {id:"U10", name:"Larissa"}
] AS u
CREATE (:User {userId:u.id, name:u.name});

// ===============================
//  RELACIONAMENTO: WATCHED
// ===============================
// usuários assistem filmes e séries com rating

MATCH (u:User {userId:"U01"}), (m:Movie {movieId:"M01"}) CREATE (u)-[:WATCHED {rating:4.5}]->(m);
MATCH (u:User {userId:"U02"}), (m:Movie {movieId:"M02"}) CREATE (u)-[:WATCHED {rating:5.0}]->(m);
MATCH (u:User {userId:"U03"}), (m:Movie {movieId:"M03"}) CREATE (u)-[:WATCHED {rating:3.5}]->(m);
MATCH (u:User {userId:"U04"}), (m:Movie {movieId:"M04"}) CREATE (u)-[:WATCHED {rating:4.0}]->(m);
MATCH (u:User {userId:"U05"}), (m:Movie {movieId:"M05"}) CREATE (u)-[:WATCHED {rating:5.0}]->(m);
MATCH (u:User {userId:"U06"}), (m:Movie {movieId:"M06"}) CREATE (u)-[:WATCHED {rating:4.8}]->(m);

MATCH (u:User {userId:"U07"}), (s:Series {seriesId:"S01"}) CREATE (u)-[:WATCHED {rating:4.0}]->(s);
MATCH (u:User {userId:"U08"}), (s:Series {seriesId:"S02"}) CREATE (u)-[:WATCHED {rating:3.8}]->(s);
MATCH (u:User {userId:"U09"}), (s:Series {seriesId:"S03"}) CREATE (u)-[:WATCHED {rating:4.7}]->(s);
MATCH (u:User {userId:"U10"}), (s:Series {seriesId:"S04"}) CREATE (u)-[:WATCHED {rating:4.3}]->(s);
