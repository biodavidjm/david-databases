Neo4j Training
====

___Max de Marzi___

Graph databases helps you to find similar patterns, no matter what the relationship among them are. Example:

# The App

### Start Neo4j

```
cd /Users/djt469/bin/neo4j-enterprise-2.2.0-M04
bin/neo4j start
:play movies
```

### To re-start everything: just delete the `data` directory:

```
bin/neo4j stop
rm -rf data/
mkdir data
bin/neo4j start
```

# Cypher: the Neo4j query language

### Sublime plugin

The plugin will detect files ending in .cql or .cyp as Cypher, optionally just select Cypher from the Syntax menu.

