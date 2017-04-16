import time
import datetime as dt
from shutil import copyfile
import inspect

from create_dirs_new import createdirs
from create_namelist import namelist
from create_inpos import initp
from create_inpos import longinitp
from link_vels import link as link
from run_ariane import check_error


    
    

def main(first_day, tlength, runlength):
    '''comments'''

    time_before = dt.datetime.now()
    #create directories
    dirs = createdirs(first_day, tlength, runlength)
    
    arianedir = dirs["arianedir"]
    
    resultsdir = dirs["resultsdir"]
    

       
    #create namelist
    namelist(arianedir, tlength + runlength, tlength)
    
    #create initial_positions.txt
    longinitp(arianedir, runlength)
    
    #link velocties (.nc files, U, V, W as default)
    link(tlength + runlength, first_day, arianedir)

    

    #copy basic files
    src = arianedir + "/namelist"
    dst = resultsdir + "/namelist"
    copyfile(src, dst)

    
    src = arianedir + "/initial_positions.txt"
    dst = resultsdir + "/initial_positions.txt"
    copyfile(src, dst)
    
    
    
    #run ariane
    error, log, final_message = check_error(arianedir, resultsdir)
    

    #copy results
    src = arianedir + "/traj.txt"
    dst = resultsdir + "/traj.txt"
    copyfile(src, dst)
    
    
    
    
        
    if error:

        ferrormsg = {"day" : first_day, "time_before": dt.datetime.now(), "time_after": dt.datetime.now()}
        errormsg = "Error encountered for file {day}, started at {time_before}," 
        "finished at {time_after}".format(format(**ferrormsg))
        
        print (errormsg.format(**ferrormsg))
        
        errorfilename = "/error.txt"
        
        

        
    if not error:
        
        ferrormsg = {"day" : first_day, "time_after": dt.datetime.now()}
        errormsg = "No error encountered for file {day}, on {time_after}"
        "with initial_positions.txt and namelist files in this folder,"
        " ".format(**ferrormsg)
        
        errorfilename = "/no_error.txt"
        
        print (errormsg.format(**ferrormsg))
        

        
    with open(resultsdir + errorfilename, 'w') as file:
        file.write(errormsg.format(**ferrormsg)) 

    with open(resultsdir + "/log.txt", 'w') as file:
        file.write(log)

    


    
def runlength (first_day, last_day, trajlength):
          
    
    first_day = dt.datetime(
             year = first_day["year"], 
             month = first_day["month"], 
             day = first_day["day"]
             )
    
    
    last_day = dt.datetime(
             year = last_day["year"], 
             month = last_day["month"], 
             day = last_day["day"]
             )
    
    rlength = (last_day - first_day).days

    main(first_day, trajlength, rlength)

        




