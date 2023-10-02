from knowledge.age import AgeGraphStore


def load_knowledge_to_graph(host, dbname, user, password, port=5432, graph_name="knowledge_graph"):
    graph_store = AgeGraphStore(
        host=host,
        dbname=dbname,
        user=user,
        password=password,
        port=port,
        graph_name=graph_name,
        node_label="entity"
    )
    conn = graph_store.client()
    conn.autocommit = True

    # Create a new database session and return a new instance of the connection class
    cur = conn.cursor()

    cur.execute(f"LOAD 'age'")
    cur.execute(f"SET search_path = ag_catalog, '$user', public;")
    cur.execute(f"SELECT * FROM ag_catalog.drop_graph('{graph_name}', true)")
    cur.execute(f"SELECT * FROM ag_catalog.create_graph('{graph_name}')")
    cur.execute(f"SELECT * FROM ag_catalog.create_vlabel('{graph_name}', 'entity');")

    entities_query = "SELECT DISTINCT ON (instance_of.entity_id) \
                      instance_of.entity_id AS id, ea_str.attribute_value AS name, 'instance' as type \
                      FROM instance_of INNER JOIN entity_attributes_str AS ea_str \
                      ON instance_of.entity_id = ea_str.entity_id AND ea_str.attribute_name = 'name' \
                      AND instance_of.concept_name != 'pose' and instance_of.concept_name != 'region' and instance_of.concept_name != 'map' \
                      UNION SELECT concepts.entity_id AS id, concepts.concept_name AS name, 'concept' as type FROM concepts \
                      ORDER BY id ASC"

    cur.execute(entities_query)
    for row in cur.fetchall():
        id = row[0]
        name = row[1]
        type = row[2]
        cur.execute(
            f"SELECT * FROM cypher('{graph_name}', $$CREATE (a:entity {{id: '{id}', name: '{name}', type: '{type}'}}) RETURN a $$) as (a agtype);")

    def add_predicate_to_graph(predicate, query):
        cur.execute(query)
        for row in cur.fetchall():
            cur.execute(
                f"SELECT * FROM cypher('{graph_name}', $$MATCH (u:entity {{id: '{row[0]}'}}), (v:entity {{id: '{row[2]}'}}) CREATE (u)-[e:{predicate}]->(v) RETURN e$$) as (e agtype);")

    attributes_query = "SELECT * FROM attributes WHERE attributes.type = 'id'"
    cur.execute(attributes_query)
    for row in cur.fetchall():
        predicate = row[0]
        attribute_query = f"SELECT ea_id.entity_id AS start_id, 'entity' as start_vertex_type, \
                            ea_id.attribute_value AS end_id, 'entity' as end_vertex_type \
                            FROM entity_attributes_id as ea_id \
                            WHERE ea_id.attribute_name = '{predicate}'"
        add_predicate_to_graph(predicate, attribute_query)

    def add_float_value_and_predicate_to_graph(predicate, query):
        cur.execute(query)
        for row in cur.fetchall():
            cur.execute(
                f"SELECT * FROM cypher('{graph_name}', $$CREATE (a:float {{name: '{row[2]}'}}) RETURN a $$) as (a agtype);")
            cur.execute(
                f"SELECT * FROM cypher('{graph_name}', $$MATCH (u:entity {{id: '{row[0]}'}}), (v:float {{name: '{row[2]}'}}) CREATE (u)-[e:{predicate}]->(v) RETURN e$$) as (e agtype);")

    attributes_query = "SELECT * FROM attributes WHERE attributes.type = 'float'"
    cur.execute(attributes_query)
    for row in cur.fetchall():
        predicate = row[0]
        attribute_query = f"SELECT ea_float.entity_id AS start_id, 'entity' as start_vertex_type, \
                            ea_float.attribute_value AS end_value, 'float' as end_vertex_type \
                            FROM entity_attributes_float as ea_float \
                            WHERE ea_float.attribute_name = '{predicate}'"
        add_float_value_and_predicate_to_graph(predicate, attribute_query)

    # Add bool predicates
    def add_bool_value_and_predicate_to_graph(predicate, query):
        cur.execute(query)
        for row in cur.fetchall():
            name = 'True' if row[2] else 'False'
            cur.execute(
                f"SELECT * FROM cypher('{graph_name}', $$MATCH (u:entity {{id: '{row[0]}'}}), (v:bool {{name: '{name}'}}) CREATE (u)-[e:{predicate}]->(v) RETURN e$$) as (e agtype);")

    cur.execute(f"SELECT * FROM cypher('{graph_name}', $$CREATE (a:bool {{name: 'True'}}) RETURN a $$) as (a agtype);")
    cur.execute(f"SELECT * FROM cypher('{graph_name}', $$CREATE (a:bool {{name: 'False'}}) RETURN a $$) as (a agtype);")
    attributes_query = "SELECT * FROM attributes WHERE attributes.type = 'bool'"
    cur.execute(attributes_query)
    for row in cur.fetchall():
        predicate = row[0]
        attribute_query = f"SELECT ea_float.entity_id AS start_id, 'entity' as start_vertex_type, \
                            ea_float.attribute_value AS end_value, 'bool' as end_vertex_type \
                            FROM entity_attributes_float as ea_float \
                            WHERE ea_float.attribute_name = '{predicate}'"
        add_bool_value_and_predicate_to_graph(predicate, attribute_query)

    instance_of_query = "SELECT instance_of.entity_id AS start_id, 'entity' AS start_vertex_type, \
                         concepts.entity_id AS end_id, 'entity' AS end_vertex_type \
                      FROM instance_of \
                      INNER JOIN concepts ON instance_of.concept_name = concepts.concept_name \
                      WHERE instance_of.concept_name != 'pose' and instance_of.concept_name != 'region' and instance_of.concept_name != 'map' \
                      ORDER BY start_id ASC "
    add_predicate_to_graph('instance_of', instance_of_query)

    return graph_store