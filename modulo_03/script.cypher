// ===============================
// CONSTRAINTS / INDICES
// ===============================
CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE u.userId IS UNIQUE;
CREATE CONSTRAINT post_id IF NOT EXISTS FOR (p:Post) REQUIRE p.postId IS UNIQUE;
CREATE CONSTRAINT comment_id IF NOT EXISTS FOR (c:Comment) REQUIRE c.commentId IS UNIQUE;
CREATE CONSTRAINT tag_name IF NOT EXISTS FOR (t:Tag) REQUIRE t.name IS UNIQUE;

// ===============================
// CRIAÇÃO DE 10 USUÁRIOS
// ===============================
UNWIND [
  {id:"U01", name:"Carlos"},
  {id:"U02", name:"Mariana"},
  {id:"U03", name:"João"},
  {id:"U04", name:"Ana"},
  {id:"U05", name:"Bruno"},
  {id:"U06", name:"Fernanda"},
  {id:"U07", name:"Lucas"},
  {id:"U08", name:"Paula"},
  {id:"U09", name:"Rafaela"},
  {id:"U10", name:"Matheus"}
] AS u
CREATE (:User {userId:u.id, name:u.name});

// ===============================
// CRIAÇÃO DE 6 TAGS (INTERESSES)
// ===============================
CREATE (t1:Tag {name:"tecnologia"});
CREATE (t2:Tag {name:"música"});
CREATE (t3:Tag {name:"cinema"});
CREATE (t4:Tag {name:"games"});
CREATE (t5:Tag {name:"esportes"});
CREATE (t6:Tag {name:"ciência"});

// ===============================
// CRIAÇÃO DE 10 POSTS
// ===============================
UNWIND [
  {id:"P01", text:"Lançamento incrível hoje!", ts:datetime("2025-01-05T09:00:00")},
  {id:"P02", text:"Alguém viu o jogo ontem?", ts:datetime("2025-01-06T20:30:00")},
  {id:"P03", text:"Novo álbum recomendado", ts:datetime("2025-01-07T14:15:00")},
  {id:"P04", text:"Dica de leitura científica", ts:datetime("2025-01-08T08:00:00")},
  {id:"P05", text:"Trailer oficial liberado", ts:datetime("2025-01-09T12:00:00")},
  {id:"P06", text:"Top 10 jogos do ano", ts:datetime("2025-01-10T18:30:00")},
  {id:"P07", text:"Pergunta sobre programação", ts:datetime("2025-01-11T07:45:00")},
  {id:"P08", text:"Treino de hoje foi brutal", ts:datetime("2025-01-12T06:20:00")},
  {id:"P09", text:"Experimento falhou — aprendizados", ts:datetime("2025-01-13T11:11:00")},
  {id:"P10", text:"Playlist colaborativa: adicione faixas", ts:datetime("2025-01-14T16:00:00")}
] AS p
CREATE (:Post {postId:p.id, text:p.text, createdAt:p.ts});

// ===============================
// VÍNCULOS POSTED: users -> posts
// ===============================
MATCH (u1:User {userId:"U01"}), (p1:Post {postId:"P01"}) CREATE (u1)-[:POSTED {createdAt:p1.createdAt}]->(p1);
MATCH (u2:User {userId:"U02"}), (p2:Post {postId:"P02"}) CREATE (u2)-[:POSTED {createdAt:p2.createdAt}]->(p2);
MATCH (u3:User {userId:"U03"}), (p3:Post {postId:"P03"}) CREATE (u3)-[:POSTED {createdAt:p3.createdAt}]->(p3);
MATCH (u4:User {userId:"U04"}), (p4:Post {postId:"P04"}) CREATE (u4)-[:POSTED {createdAt:p4.createdAt}]->(p4);
MATCH (u5:User {userId:"U05"}), (p5:Post {postId:"P05"}) CREATE (u5)-[:POSTED {createdAt:p5.createdAt}]->(p5);
MATCH (u6:User {userId:"U06"}), (p6:Post {postId:"P06"}) CREATE (u6)-[:POSTED {createdAt:p6.createdAt}]->(p6);
MATCH (u7:User {userId:"U07"}), (p7:Post {postId:"P07"}) CREATE (u7)-[:POSTED {createdAt:p7.createdAt}]->(p7);
MATCH (u8:User {userId:"U08"}), (p8:Post {postId:"P08"}) CREATE (u8)-[:POSTED {createdAt:p8.createdAt}]->(p8);
MATCH (u9:User {userId:"U09"}), (p9:Post {postId:"P09"}) CREATE (u9)-[:POSTED {createdAt:p9.createdAt}]->(p9);
MATCH (u10:User {userId:"U10"}), (p10:Post {postId:"P10"}) CREATE (u10)-[:POSTED {createdAt:p10.createdAt}]->(p10);

// ===============================
// TAGS EM POSTS (HAS_TAG)
// ===============================
MATCH (p1:Post {postId:"P01"}),(t:Tag {name:"música"})       CREATE (p1)-[:HAS_TAG]->(t);
MATCH (p2:Post {postId:"P02"}),(t:Tag {name:"esportes"})    CREATE (p2)-[:HAS_TAG]->(t);
MATCH (p3:Post {postId:"P03"}),(t:Tag {name:"música"})      CREATE (p3)-[:HAS_TAG]->(t);
MATCH (p4:Post {postId:"P04"}),(t:Tag {name:"ciência"})     CREATE (p4)-[:HAS_TAG]->(t);
MATCH (p5:Post {postId:"P05"}),(t:Tag {name:"cinema"})      CREATE (p5)-[:HAS_TAG]->(t);
MATCH (p6:Post {postId:"P06"}),(t:Tag {name:"games"})       CREATE (p6)-[:HAS_TAG]->(t);
MATCH (p7:Post {postId:"P07"}),(t:Tag {name:"tecnologia"})  CREATE (p7)-[:HAS_TAG]->(t);
MATCH (p8:Post {postId:"P08"}),(t:Tag {name:"esportes"})    CREATE (p8)-[:HAS_TAG]->(t);
MATCH (p9:Post {postId:"P09"}),(t:Tag {name:"ciência"})     CREATE (p9)-[:HAS_TAG]->(t);
MATCH (p10:Post {postId:"P10"}),(t:Tag {name:"música"})     CREATE (p10)-[:HAS_TAG]->(t);

// ===============================
// RELACIONAMENTOS DE SEGUIMENTO ENTRE USUÁRIOS (FOLLOWS)
// ===============================
MATCH (u1:User {userId:"U01"}),(u2:User {userId:"U02"}) CREATE (u1)-[:FOLLOWS {since:date("2024-11-01")}]->(u2);
MATCH (u2:User {userId:"U02"}),(u3:User {userId:"U03"}) CREATE (u2)-[:FOLLOWS {since:date("2024-12-01")}]->(u3);
MATCH (u3:User {userId:"U03"}),(u1:User {userId:"U01"}) CREATE (u3)-[:FOLLOWS {since:date("2024-10-15")}]->(u1);
MATCH (u4:User {userId:"U04"}),(u1:User {userId:"U01"}) CREATE (u4)-[:FOLLOWS {since:date("2024-09-20")}]->(u1);
MATCH (u5:User {userId:"U05"}),(u3:User {userId:"U03"}) CREATE (u5)-[:FOLLOWS {since:date("2024-12-10")}]->(u3);
MATCH (u6:User {userId:"U06"}),(u2:User {userId:"U02"}) CREATE (u6)-[:FOLLOWS {since:date("2024-12-15")}]->(u2);
MATCH (u7:User {userId:"U07"}),(u4:User {userId:"U04"}) CREATE (u7)-[:FOLLOWS {since:date("2024-11-25")}]->(u4);
MATCH (u8:User {userId:"U08"}),(u5:User {userId:"U05"}) CREATE (u8)-[:FOLLOWS {since:date("2024-12-20")}]->(u5);
MATCH (u9:User {userId:"U09"}),(u6:User {userId:"U06"}) CREATE (u9)-[:FOLLOWS {since:date("2024-12-22")}]->(u6);
MATCH (u10:User {userId:"U10"}),(u7:User {userId:"U07"}) CREATE (u10)-[:FOLLOWS {since:date("2024-12-24")}]->(u7);

// ===============================
// INTERAÇÕES: LIKES, SHARES, COMMENTS
// ===============================
MATCH (u1:User {userId:"U01"}),(p3:Post {postId:"P03"}) CREATE (u1)-[:LIKED {createdAt:datetime("2025-01-07T15:00:00")}]->(p3);
MATCH (u2:User {userId:"U02"}),(p1:Post {postId:"P01"}) CREATE (u2)-[:LIKED {createdAt:datetime("2025-01-05T10:00:00")}]->(p1);
MATCH (u3:User {userId:"U03"}),(p2:Post {postId:"P02"}) CREATE (u3)-[:SHARED {createdAt:datetime("2025-01-06T21:00:00")}]->(p2);
MATCH (u4:User {userId:"U04"}),(p5:Post {postId:"P05"}) CREATE (u4)-[:LIKED {createdAt:datetime("2025-01-09T13:00:00")}]->(p5);
MATCH (u5:User {userId:"U05"}),(p6:Post {postId:"P06"}) CREATE (u5)-[:SHARED {createdAt:datetime("2025-01-10T19:00:00")}]->(p6);
MATCH (u6:User {userId:"U06"}),(p9:Post {postId:"P09"}) CREATE (u6)-[:LIKED {createdAt:datetime("2025-01-13T12:00:00")}]->(p9);
MATCH (u7:User {userId:"U07"}),(p7:Post {postId:"P07"}) CREATE (u7)-[:COMMENTED {createdAt:datetime("2025-01-11T08:00:00"), text:"Boa pergunta!"}]->(p7);
MATCH (u8:User {userId:"U08"}),(p8:Post {postId:"P08"}) CREATE (u8)-[:LIKED {createdAt:datetime("2025-01-12T07:00:00")}]->(p8);
MATCH (u9:User {userId:"U09"}),(p10:Post {postId:"P10"}) CREATE (u9)-[:SHARED {createdAt:datetime("2025-01-14T17:00:00")}]->(p10);
MATCH (u10:User {userId:"U10"}),(p4:Post {postId:"P04"}) CREATE (u10)-[:COMMENTED {createdAt:datetime("2025-01-08T09:00:00"), text:"Interessante!"}]->(p4);

// ===============================
// COMENTÁRIOS NÓS (opcionais para análises de texto/thread)
// ===============================
CREATE (c1:Comment {commentId:"C01", text:"Concordo", createdAt:datetime("2025-01-07T15:10:00")});
CREATE (c2:Comment {commentId:"C02", text:"Qual fonte?", createdAt:datetime("2025-01-09T13:10:00")});
MATCH (u1:User {userId:"U01"}),(c1:Comment {commentId:"C01"}),(p3:Post {postId:"P03"})
  CREATE (u1)-[:WROTE {createdAt:c1.createdAt}]->(c1), (c1)-[:ON]->(p3);
MATCH (u5:User {userId:"U05"}),(c2:Comment {commentId:"C02"}),(p5:Post {postId:"P05"})
  CREATE (u5)-[:WROTE {createdAt:c2.createdAt}]->(c2), (c2)-[:ON]->(p5);

// ===============================
// USUÁRIOS SEGUEM TAGS (INTERESSE)
// ===============================
MATCH (u1:User {userId:"U01"}),(t:Tag {name:"música"}) CREATE (u1)-[:INTERESTED_IN]->(t);
MATCH (u3:User {userId:"U03"}),(t:Tag {name:"games"}) CREATE (u3)-[:INTERESTED_IN]->(t);
MATCH (u4:User {userId:"U04"}),(t:Tag {name:"ciência"}) CREATE (u4)-[:INTERESTED_IN]->(t);
MATCH (u2:User {userId:"U02"}),(t:Tag {name:"esportes"}) CREATE (u2)-[:INTERESTED_IN]->(t);
