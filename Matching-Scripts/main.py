
import pandas as pd

# user = pd.read_csv("UserDetails.csv")

# user["id"] = user["User"] + user["Blood Group"]

# # c = user["Blood Group"].value_counts()
# # print(c)

# user['id'] = user['id'].str.replace('+','p')
# user['id'] = user['id'].str.replace('-','n')

# users = user["id"].to_list()

# print(users)

# from regex import edgecreate


def csvtolist(don, rec):

    don["userbg"] = don["UID"] + don["BloodGroup"]
    don['userbg'] = don['userbg'].str.replace('+','p')
    don['userbg'] = don['userbg'].str.replace('-','n')

    rec["userbg"] = rec["UID"] + rec["BloodGroup"]
    rec['userbg'] = rec['userbg'].str.replace('+','p')
    rec['userbg'] = rec['userbg'].str.replace('-','n')

    dons = don["userbg"].to_list()
    recs = rec["userbg"].to_list()

    return dons ,recs
