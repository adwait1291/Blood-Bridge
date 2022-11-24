
import networkx as nx
import matplotlib.pyplot as plt

def graph(donar, receiver, edges):

    g = nx.Graph()

    g.add_nodes_from(donar, bipartite=0)
    g.add_nodes_from(receiver, bipartite=1)

    g.add_edges_from(edges)

    nx.draw_networkx(g, pos = nx.drawing.layout.bipartite_layout(g, donar), width = 2)
    plt.show()

    return g
