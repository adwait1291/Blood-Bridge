import re
import random

def edgecreate(donar, receiver):

    edges = []

    for i in donar:
        for j in receiver:
            if re.findall('Op$', i) and re.findall('p$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('On$', i):
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('Ap$', i) and re.findall('Ap$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('Ap$', i) and re.findall('ABp$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('An$', i) and re.findall('A.$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('An$', i) and re.findall('AB.$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('Bp$', i) and re.findall('Bp$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('Bp$', i) and re.findall('ABp$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('Bn$', i) and re.findall('B.$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('ABp$', i) and re.findall('ABp$', i) :
                edges.append((i, j))

    for i in donar:
        for j in receiver:
            if re.findall('ABn$', i) and re.findall('AB.$', i) :
                edges.append((i, j))

    return edges
