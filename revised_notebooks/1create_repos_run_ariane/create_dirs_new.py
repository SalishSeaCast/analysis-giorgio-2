"""Creates reposities where results and basic infomartion will be stored"""
# In[1]:

import os


import datetime as dt

months = ['', 'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']



# In[2]:
    

import errno

def make_sure_path_exists(path):
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise

def createdirs (first_date, tlength, runlength, basedir = "/ocean/gsgarbi/hindcast/"):

    last_date = first_date + dt.timedelta(hours = 24*runlength)
  

    fdate = '{:%Y%m%d}'.format(first_date) + "_" + '{:%Y%m%d}'.format(last_date) + "_" + "{}d".format(tlength)

    arianedir = basedir + "arianefiles/" + fdate
    resultsdir = basedir + "results/" + fdate

    make_sure_path_exists(arianedir)

    make_sure_path_exists(resultsdir)

    
    return {'arianedir': arianedir, 'resultsdir': resultsdir}
    
