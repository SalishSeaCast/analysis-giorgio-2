import datetime as dt
from shutil import copyfile
import inspect

from create_dirs import createdirs
from create_namelist import namelist
from create_inpos import longinitp
from link_vels import link as link
from run_ariane import run_ariane


    
def pre_run (first_day, last_day, trajectory_length):
    '''
    Prepares the run and starts the run
    Arguments: 
    initial day of the run(dicitonary)
    last day of the trajectory (dicitonary)
    trajectory length in days (positive integer)
    '''
          


    
    run_length = (last_day - first_day).days

    #starts the runs
    start_run(first_day = first_day, 
              last_day = last_day, 
              run_length = run_length, 
              trajectory_length = trajectory_length)
    
    

def start_run(first_day, last_day, trajectory_length, run_length):
    '''
    starts the run and collects the results
    '''
    
    #creates directories
    dirs = createdirs(first_day, trajectory_length, run_length)
    arianedir = dirs["arianedir"]
    resultsdir = dirs["resultsdir"]
    

    #creates namelist
    namelist(arianedir, trajectory_length + run_length, trajectory_length)
    
    
    #creates initial_positions.txt
    longinitp(arianedir, run_length)
    
    
    #links velocties (.nc files, U, V, W as default)
    link(trajectory_length + run_length, first_day, arianedir)


    #copies basic files
    src = arianedir + "/namelist"
    dst = resultsdir + "/namelist"
    copyfile(src, dst)

    src = arianedir + "/initial_positions.txt"
    dst = resultsdir + "/initial_positions.txt"
    copyfile(src, dst)
    
    #copies code that originated the run to the results directory
    source = inspect.stack()[2][1]
    src = source
    dst = resultsdir + "/source.py"
    copyfile(src, dst)
    
    
    #runs ariane
    time_before = dt.datetime.now()
    error, log, final_message = run_ariane(arianedir, resultsdir)
    time_after = dt.datetime.now()

    
    #copies results to the results directory
    src = arianedir + "/traj.txt"
    dst = resultsdir + "/traj.txt"
    copyfile(src, dst)
    
        

    
    
    #writes the information about the run and adds it to the respective result directory
    run_info = {
                "first_day" : first_day, 
                "last_day" : last_day, 
                "time_before": time_before, 
                "time_after" : time_after, 
                "time_delta" : time_after - time_before, 
                "source" : source,
                }
    
    run_message = (
    "The simulated run starts on {first_day} and finishes on {last_day}\n"
    "The code that simulates the run was run at {time_before} and ended at {time_after}, taking {time_delta} to complete\n"
    "Please refer to {source} to see the code that originated these results (also available in this directory)\n"
                  ).format (**run_info)
        
    with open(resultsdir + "/run_info", 'w') as file:
        file.write(run_message.format(**run_info)) 

    with open(resultsdir + "/run_log.txt", 'w') as file:
        file.write(log)

        




