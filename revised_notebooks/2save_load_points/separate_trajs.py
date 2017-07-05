import datetime as dt
import os, sys
import numpy as np

#72 particulas por dia e 72 pontos por dia por trajetoria

RAWDIR = "/ocean/gsgarbi/analysis-giorgio/time_series/results2/2016+jan2017/"
    
OUTPUTDIR = "/ocean/gsgarbi/selected_days/"

H = 24

pph = 3

ppd = H * pph

depths_num = 3

traj_len = 2 # traj len in days

date = dt.datetime(2016, 7, 2)

def find_direct (direct = RAWDIR, date = date):
    y = str(date.year)
    m = str(date.month)
    if len (m) == 1:
        m = "0"+str(m)
    
    direct = [i for i in os.listdir(direct) if y+m == i[:6]]
    
    return direct[0]

def clean_file(direct):
    rtn = []
    with open(RAWDIR + direct + "/traj.txt") as file:

        for line in enumerate(file):
            line = line.strip('\n').split()
            line = [float(k) for k in line]
            rtn.append(line)
    return rtn
    

def get_points(direct, date):
    pts = []
    d = date.day
    

    
    parts = range (d*ppd, d*ppd + ppd)
    part = parts[0]
       
    with open(RAWDIR + direct + "/traj.txt") as file:

        count = 0

        
        for i, line in enumerate(file):                  
            line = line.strip('\n').split()
            line = [float(k) for k in line]
            if line[0] == part:
                pts.append(line)
                count +=1
            if count == traj_len*ppd:
                count = 0
                part += 1
            if part == parts[-1]+1:
                break 
        
                



    return pts


direct = find_direct()

print (direct)
#
pts = get_points(direct, date)
#
print (len(pts))
#d1 = pts[0:traj_len*ppd:3]
#d2 = pts[1:traj_len*ppd:3]
#d3 = pts[2:traj_len*ppd:3]
#print (len(d1), d1)


