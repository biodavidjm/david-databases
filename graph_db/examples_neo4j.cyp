// Introduction to Neo4j and cypher

// Example of bidirectional relationships

// `match(a)` means "match any node"


MATH (a)--(b) RETURN a, b;
EXPLAIN match(a)--(b) RETURN a, b;
profile match(a)--(b) RETURN a, b;

//It would be different as:
//Monodirectional:

match(a)-->(b) RETURN a, b;
EXPLAIN match(a)-->(b) RETURN a, b;
profile match(a)-->(b) RETURN a, b;

//Or even:
profile match(a)-->() RETURN a;

match (a)-->() return distinct a.name

You can go deep in the relationships when querying:


match (a)-[r]->(b) 
return a.name, count(r), type(r), id(a)
order by count(r) desc
skip 3
limit 10

Pay attention to the null values in this query:

match (a)
OPTIONAL MATCH(a)-[r]->()
RETURN a.name, type(r)



match (a)-[:ACTED_IN]->(b)
return a.name, b.title

//and don't forget that you can get the statistics..

PROFILE match (a)-[:ACTED_IN]->(b)
return a.name, b.title

PROFILE match (a)-[r:ACTED_IN]->(b:Movie) 
return a.name, r.roles, b.title


//PATHs

// These kind of searches are of course possible:
// (a)->(b)<-(c)

// For example, find the actors that acted in a movie, and also the name of the directors that directed that movie

MATCH (a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
RETURN a.name, m.title, d.name

// Or with aliases:

MATCH (a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
RETURN a.name AS actor, m.title AS Movie, d.name as Director

// and you can search this in this way as well:

MATCH (a)-[:ACTED_IN]->(m), (m)<-[:DIRECTED]-(d)
RETURN a.name AS actor, m.title AS Movie, d.name as Director

// and if you want to visualize the date, just remove to show the label...

MATCH (a)-[:ACTED_IN]->(m), (m)<-[:DIRECTED]-(d) RETURN a,m,d

// You can create shortcuts like this:

MATCH p= (a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
RETURN p;

// and you can count..

MATCH (a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
RETURN a.name AS actor, m.title AS Movie, d.name as Director, count(*)

// Tell me the movies where actor and director have worked together

MATCH (a)-[:ACTED_IN]->(m)<-[:ACTED_IN]-(d)
RETURN a.name AS First_Actor, d.name AS Second_Actor, collect(m.title) as movies;

// Assignment: Directors that has also acted in the same movie:

MATCH (a)-[:DIRECTED]->(m)<-[:ACTED_IN]-(a)
RETURN a.name, m.title
ORDER BY a.name


MATCH (a)-[:ACTED_IN]->(m)<-[:ACTED_IN]-(b)
RETURN a.name AS First_Actor, b.name AS Second_Actor, collect(m.title) as movies;

MATCH (n)
WHERE n.name = "Tom Hanks"
RETURN n;

// More specific searches:

MATCH (n)
WHERE n.name = "Tom Hanks"
RETURN n;
//is the same as
MATCH (tom:Person {name:"Tom Hanks"})
RETURN tom;


// Same things with

MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(movie:Movie)
RETURN movie.title;
//is the same as 
MATCH (tom:Person)-[:ACTED_IN]->(movie:Movie)
WHERE tom.name="Tom Hanks"
RETURN movie.title;

// Now all the directors that have worked with Tom hanks

MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(movie),
(director)-[:DIRECTOR]->(movie)
RETURN DISTINCT director.name;

MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(movie),
(kevin:Person {name:"Kevin Bacon"})-[ACTED_IN]->(movie)
RETURN movie.title

MATCH (tom:Person)-[:ACTED_IN]->(movie),
(kevin:Person)-[:ACTED_IN]->(movie)
WHERE tom.name = "Tom Hanks" AND kevin.name= "Kevin Bacon"
RETURN movie.title;

// Do this:
profile MATCH (tom:Person)-[:ACTED_IN]->(movie),
(kevin:Person)-[:ACTED_IN]->(movie)
WHERE tom.name = "Tom Hanks" AND kevin.name= "Kevin Bacon"
RETURN movie.title;

// The database can be indexed:
create index on :Movie(title)
create index on :Person(name)

// Now running:
profile MATCH (tom:Person)-[:ACTED_IN]->(movie),
(kevin:Person)-[:ACTED_IN]->(movie)
WHERE tom.name = "Tom Hanks" AND kevin.name= "Kevin Bacon"
RETURN movie.title;

//Who are the 5 busiest actors (in this database, of course)?
MATCH (actor:Person)-[:ACTED_IN]->(movie)
RETURN actor.name, count(*) AS count
ORDER BY count DESC
limit 5

// Recommend 3 actors that Keanu Reeves should work with (and hasn't yet)
// (a typical friends of friends relationship)

//This is what I was writting
MATCH (actor:Person {name:"Keanu Reeves"})-[:ACTED_IN]->(movie),
(colleage:Person)-[:ACTED_IN]->(movie)
WHERE NOT (colleage:Person)-[:ACTED_IN]->(movie)<-[:ACTED_IN]-(OTHER)
RETURN movie.title, colleage.name


MATCH (keanu:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(c),
(c)-[:ACTED_IN]->()<-[:ACTED_IN]-(coc)
WHERE keanu.name="Keanu Reeves" AND NOT ( (keanu)-[:ACTED_IN]->()<-[:ACTED_IN]-(coc) )
AND coc <> keanu // This should prevent to keanu to be recommended to himself, but I am not sure about that
RETURN coc.name, count(coc)
ORDER BY count(coc) DESC
LIMIT 3;


// Delete stuff is complictated: you must kill the relationship as well between both nodes:
// Thus, this does not work:
MATCH (emil:Person {name:"Emil Eifrem"}) DELETE emil;

// To do it correctly:
MATCH (emil:Person {name:"Emil Eifrem"}) 
OPTIONAL MATCH (emil)-[r]-()
DELETE r, emil;

// Add "knows" relationships between all actors who were in the same movie
MATCH (a:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(b:Person)
CREATE UNIQUE (a)-[:KNOWS]-(b);

// Return friends of friends




