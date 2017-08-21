#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 17 12:01:56 2017

@author: gsgarbi
"""

import datetime as dt
from dateutil.relativedelta import relativedelta
import inspect

from start_run import pre_run

'''
Runs the year of 2016 up the most recent avaliable data on nowcast green
This codes assumes that the data up to [(present day) - 2 days] 
is available on nowcast, hindcast or other velocities data source.

example: if one runs this program on Feb 20 2019, the code expects 
the velocity data files to be available on nowcast/hindcast
at least up to Feb 18 2019

'''


if __name__ == "__main__":
    
    for m in range (7, 9):
    
        DATA_LIMIT = dt.date.today() - relativedelta(days = 2)
    
    
        first_day = dt.date(
                            year = 2016,
                            month = m,
                            day = 1
                            )
                 
        
        last_day = first_day + relativedelta(months = 1) - relativedelta(days = 1) #up to the last day of that month
        
    
        
        trajectory_length = min((DATA_LIMIT - last_day).days, 1)
        
        
        #copies code that originated the run to the results directory
        code_src = inspect.stack()[0][1]
    
        #print (first_day, last_day, DATA_LIMIT, trajectory_length)
    
    
        
        pre_run (
                     first_day = first_day, 
                     last_day = last_day, 
                     trajectory_length = trajectory_length, 
                     src = code_src,
                     ds = 'hindcast'
                )        
