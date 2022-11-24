import re
import random

# users = ['user01Bp', 'user02Op', 'user03Bp', 'user04Op', 'user05ABn', 'user06Bp', 'user07On', 'user08Op', 'user09Op', 'user10Ap', 
#         'user11ABp', 'user12Bp', 'user13Bn', 'user14ABp', 'user15Op', 'user16Ap', 'user17ABp', 'user18Bp', 'user19Op', 'user20Ap', 
#         'user21Ap', 'user22Op', 'user23Bp', 'user24Op', 'user25Bp', 'user26ABp', 'user27Ap', 'user28Op', 'user29An', 'user30Op', 
#         'user31Ap', 'user32Bp', 'user33Ap', 'user34Ap', 'user35Ap', 'user36Bp', 'user37An', 'user38On', 'user39Bp', 'user40Op', 
#         'user41Op', 'user42Ap', 'user43Ap', 'user44Bp', 'user45Op', 'user46Op', 'user47Op', 'user48Op', 'user49Bp', 'user50Op', 
#         'user51Bp', 'user52On', 'user53Bp', 'user54Bp', 'user55Bp', 'user56Ap', 'user57ABp', 'user58Bp', 'user59Ap', 'user60Ap', 
#         'user61Ap', 'user62Bp', 'user63Bp', 'user64Ap', 'user65Ap', 'user66Bp', 'user67Bp', 'user68ABn', 'user69Op', 'user70Op', 
#         'user71Bp', 'user72Bn', 'user73Bp', 'user74Bp', 'user75Ap', 'user76Op', 'user77Bp', 'user78Op', 'user79Ap', 'user80Op', 
#         'user81Ap', 'user82Bp', 'user83Bp', 'user84Op', 'user85Op']


# donar = random.choices(users, k=10)

# list2 = []
# for ele in users:
#     if ele not in donar:
#         list2.append(ele)

# receiver = random.choices(list2, k=10)

# from list import csvrolist

# from initial_graph import graph

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

# print(donar)
# print(receiver)
# print(edges)

