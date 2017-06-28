
# coding: utf-8

# In[7]:

import datetime as dt
import os, sys
import numpy as np



RAWDIR = "/ocean/gsgarbi/analysis-giorgio/time_series/results2/2016+jan2017/"
    
OUTPUTDIR = "/ocean/gsgarbi/selected_days/"


for nday in range(1,101):

    # <b> Parameters </b>
    
    # In[8]:
    
    #Parameters
    
    
    H = 24 #One day in hours
    
    #Ariane parameters
    tunit= 3600
    
    outint = 20 * 60 # 20 min in seconds
    
    pph = int(tunit / outint) #points per hour
    
    lmt = 1896 #points per particle
    
    
    #RUN parameters
    
    
    

    
    dirs = os.listdir(RAWDIR)
    
    dirs = sorted(dirs)
    
    print (dirs)
    
    position = nday * pph * H # d * num/h * h/d = num
    
    
    # <b> Function to get points after <i> nday </i> days from an indiviual month </b>
    
    # In[9]:
    
    def get_pts(direct):
        
        points = []
        
        particle = 1 #start particle counter
        
        start = dt.datetime.now()
        print ("start {}: ".format(direct), start)
    
    
        with open(RAWDIR + direct + "/traj.txt") as file:
    
            for i, line in enumerate(file):
    
                line = line.strip('\n').split()
    
                line = [float(k) for k in line]
    
    
                if line[0] == particle:
                    index = i + position
                    particle += 1
    
                if i == index:
                    points.append (line)
                    
            print ("time: ", dt.datetime.now() - start)
                    
                    
        return points
    
    

    
    # In[12]:
    
    for mon_file in dirs:
        mon = get_pts(mon_file)
        print ("got points for {}".format(mon_file))
        np.array(mon).dump(open(OUTPUTDIR + mon_file[:17] + "_{}d.npy".format(nday), 'wb'))
        print ("saved points for {} \n with nday = {}".format(mon_file, nday))
    





