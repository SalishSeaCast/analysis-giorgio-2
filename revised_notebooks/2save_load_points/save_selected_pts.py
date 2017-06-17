
# coding: utf-8

# In[7]:

import datetime as dt
import os, sys
import netCDF4 as nc
import matplotlib as mpl
import numpy as np
import numpy.ma as ma
from scipy.spatial import distance
import matplotlib
from matplotlib import pyplot as plt
from matplotlib.patches import Ellipse
from matplotlib import cm
import matplotlib.colors as mpl_colors
from matplotlib import rc
from mpl_toolkits.axes_grid1 import make_axes_locatable


from salishsea_tools import geo_tools, viz_tools

RAWDIR = "/ocean/gsgarbi/analysis-giorgio/time_series/results2/2016+jan2017/"
    
OUTPUTDIR = "/ocean/gsgarbi/selected_days/"


for nday in (50,100):

    # <b> Parameters </b>
    
    # In[8]:
    
    #Parameters
    
    cmap = plt.get_cmap('nipy_spectral')
    cmap.set_bad('burlywood')
    
    H = 24 #One day in hours
    
    #Ariane parameters
    tunit= 3600
    
    outint = 20 * 60 # 20 min in seconds
    
    pph = int(tunit / outint) #points per hour
    
    lmt = 1896 #points per particle
    
    
    #RUN parameters
    
    
    

    
    dirs = os.listdir(RAWDIR)
    
    dirs = sorted(dirs)
    
    dirs = dirs[:12]
    
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
    
    for mon_file in ("/20170101_20170131_120d",):
        mon = get_pts(mon_file)
        print ("got points for {}".format(mon_file))
        np.array(mon).dump(open(OUTPUTDIR + mon_file[:17] + "_{}d.npy".format(nday), 'wb'))
        print ("saved points for {} \n".format(mon_file))
    





