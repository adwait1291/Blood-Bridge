
import pandas as pd

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
