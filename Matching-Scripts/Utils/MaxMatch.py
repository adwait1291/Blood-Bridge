
import networkx as nx
from networkx.algorithms import bipartite
import matplotlib.pyplot as plt

def maxmatch(g, donar, receiver):

    k = list(nx.maximal_matching(g))     

    g2 = nx.Graph()

    g2.add_nodes_from(donar, bipartite=0)
    g2.add_nodes_from(receiver, bipartite=1)
    g2.add_edges_from(k)

    nx.draw_networkx(g2, pos = nx.drawing.layout.bipartite_layout(g2, donar), width = 2)

    plt.show()

    for i in range(len(k)):
        k[i] = list(k[i])
        k[i][0] = k[i][0][0:28]
        k[i][1] = k[i][1][0:28]

    return k

