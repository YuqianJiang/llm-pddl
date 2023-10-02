from typing import Any, Dict, List, Optional
from llama_index.graph_stores.types import GraphStore

try:
    import psycopg2
except ImportError:
    raise ImportError("Please install psycopg2")

class AgeGraphStore(GraphStore):
    def __init__(
        self,
        dbname: str,
        user: str,
        password: str,
        host: str,
        port: int,
        graph_name: str,
        node_label: str,
        **kwargs: Any,
    ) -> None:
        try:
            self._conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
        except psycopg2.OperationalError as err:
            raise ValueError(err)
        self._dbname = dbname
        self._graph_name = graph_name
        self._node_label = node_label

    def client(self):
        return self._conn

    def get(self, subj: str) -> List[List[str]]:
        """Get triplets."""
        query = (
                    f"SELECT * FROM ag_catalog.cypher('{self._graph_name}', $$ "
                    f"MATCH (:{self._node_label} {{name:'{subj}'}})-[r]->(n2:{self._node_label})"
                    f"RETURN type(r), n2.name"
                    f"$$) as (rel agtype, obj agtype);"
        )
        cur = self._conn.cursor()
        cur.execute(query)
        results = cur.fetchall()
        return [[eval(rel), eval(obj)] for (rel, obj) in results]

    def get_rel_map(
            self, subjs: Optional[List[str]] = None, depth: int = 2, limit: int=30
    ) -> Dict[str, List[List[str]]]:
        """Get flat rel map."""

        rel_map: Dict[Any, List[Any]] = {}
        if subjs is None or len(subjs) == 0:
            # unlike simple graph_store, we don't do get_all here
            return rel_map

        for subj in subjs:
            rel_map[subj] = []

        subjs_str = "['" + "', '".join(subjs) + "']"

        query = (f"SELECT * FROM ag_catalog.cypher('{self._graph_name}', $$ "
                 f"MATCH p=(n1:{self._node_label})-[*1..{depth}]-() "
                 f"WHERE n1.name IN {subjs_str} "
                 f"WITH n1.name AS subj, p, relationships(p) AS rels "
                 f"UNWIND rels AS rel "
                 f"WITH subj AS subj, p, collect([startNode(rel).name, type(rel), endNode(rel).name]) AS predicates "
                 f"RETURN subj, predicates LIMIT {limit}"
                 f"$$) as (subj agtype, rel agtype);"
        )
        cur = self._conn.cursor()
        try:
            cur.execute(query)
        except psycopg2.errors.SyntaxError as err:
            print (err)
        results = cur.fetchall()
        for row in results:
            for rel in eval(row[1]):
                rel_str = "" + rel[0] + ", -[" + rel[1] + "], " + "-> " + rel[2] + ""
                if rel_str not in rel_map[eval(row[0])]:
                    rel_map[eval(row[0])].append(rel_str)
        return rel_map

