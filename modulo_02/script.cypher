// ------------------------------
// CONSTRAINTS
// ------------------------------
CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT music_id IF NOT EXISTS FOR (m:Music) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT artist_id IF NOT EXISTS FOR (a:Artist) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT genre_id IF NOT EXISTS FOR (g:Genre) REQUIRE g.id IS UNIQUE;

// ------------------------------
// CRIAÇÃO DOS USUÁRIOS
// ------------------------------
CREATE (u1:User {id:1, name:"Carlos"})
CREATE (u2:User {id:2, name:"Marina"})
CREATE (u3:User {id:3, name:"João"})
CREATE (u4:User {id:4, name:"Ana"})
CREATE (u5:User {id:5, name:"Bruno"})
CREATE (u6:User {id:6, name:"Fernanda"})
CREATE (u7:User {id:7, name:"Lucas"})
CREATE (u8:User {id:8, name:"Paula"})
CREATE (u9:User {id:9, name:"Rafaela"})
CREATE (u10:User {id:10, name:"Matheus"});

// ------------------------------
// CRIAÇÃO DOS GÊNEROS
// ------------------------------
CREATE (g1:Genre {id:1, name:"Pop"})
CREATE (g2:Genre {id:2, name:"Rock"})
CREATE (g3:Genre {id:3, name:"Hip-Hop"})
CREATE (g4:Genre {id:4, name:"Eletrônica"});

// ------------------------------
// CRIAÇÃO DOS ARTISTAS
// ------------------------------
CREATE (a1:Artist {id:1, name:"Artist A"})
CREATE (a2:Artist {id:2, name:"Artist B"})
CREATE (a3:Artist {id:3, name:"Artist C"})
CREATE (a4:Artist {id:4, name:"Artist D"});

// ------------------------------
// CRIAÇÃO DAS MÚSICAS (10 MÚSICAS)
// ------------------------------
CREATE (m1:Music {id:1, title:"Song 1"})
CREATE (m2:Music {id:2, title:"Song 2"})
CREATE (m3:Music {id:3, title:"Song 3"})
CREATE (m4:Music {id:4, title:"Song 4"})
CREATE (m5:Music {id:5, title:"Song 5"})
CREATE (m6:Music {id:6, title:"Song 6"})
CREATE (m7:Music {id:7, title:"Song 7"})
CREATE (m8:Music {id:8, title:"Song 8"})
CREATE (m9:Music {id:9, title:"Song 9"})
CREATE (m10:Music {id:10, title:"Song 10"});

// ------------------------------
// RELACIONAMENTOS ARTISTA → MÚSICA
// ------------------------------
CREATE (a1)-[:CREATED]->(m1)
CREATE (a1)-[:CREATED]->(m2)
CREATE (a2)-[:CREATED]->(m3)
CREATE (a2)-[:CREATED]->(m4)
CREATE (a3)-[:CREATED]->(m5)
CREATE (a3)-[:CREATED]->(m6)
CREATE (a4)-[:CREATED]->(m7)
CREATE (a4)-[:CREATED]->(m8)
CREATE (a1)-[:CREATED]->(m9)
CREATE (a3)-[:CREATED]->(m10);

// ------------------------------
// RELACIONAMENTOS GENRE → MÚSICA
// ------------------------------
CREATE (g1)-[:HAS_MUSIC]->(m1)
CREATE (g1)-[:HAS_MUSIC]->(m2)
CREATE (g2)-[:HAS_MUSIC]->(m3)
CREATE (g2)-[:HAS_MUSIC]->(m4)
CREATE (g3)-[:HAS_MUSIC]->(m5)
CREATE (g3)-[:HAS_MUSIC]->(m6)
CREATE (g4)-[:HAS_MUSIC]->(m7)
CREATE (g4)-[:HAS_MUSIC]->(m8)
CREATE (g1)-[:HAS_MUSIC]->(m9)
CREATE (g2)-[:HAS_MUSIC]->(m10);

// ------------------------------
// INTERAÇÕES DOS USUÁRIOS
// ------------------------------
CREATE (u1)-[:LISTENED {times:5}]->(m1)
CREATE (u1)-[:LIKED]->(m2)
CREATE (u2)-[:LISTENED {times:3}]->(m3)
CREATE (u2)-[:FOLLOW_ARTIST]->(a1)
CREATE (u3)-[:LISTENED {times:7}]->(m4)
CREATE (u3)-[:LIKED]->(m1)
CREATE (u4)-[:LISTENED {times:10}]->(m5)
CREATE (u5)-[:LISTENED {times:2}]->(m6)
CREATE (u6)-[:LISTENED {times:4}]->(m7)
CREATE (u7)-[:LIKED]->(m8)
CREATE (u8)-[:LISTENED {times:6}]->(m9)
CREATE (u9)-[:FOLLOW_ARTIST]->(a3)
CREATE (u10)-[:LISTENED {times:8}]->(m10);

// ------------------------------
// RELACIONAMENTOS ENTRE USUÁRIOS
// ------------------------------
CREATE (u1)-[:FOLLOWS]->(u2)
CREATE (u2)-[:FOLLOWS]->(u3)
CREATE (u3)-[:FOLLOWS]->(u1)
CREATE (u4)-[:FOLLOWS]->(u1)
CREATE (u5)-[:FOLLOWS]->(u3);
