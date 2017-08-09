#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 17 12:01:56 2017

@author: gsgarbi
"""

import datetime as dt
from dateutil.relativedelta import relativedelta

from start_run import pre_run

'''
Runs the year of 2016 up the most recent avaliable data on nowcast green
This codes assumes that the data up to [(present day) - 30 days] is available on nowcast green

example: if one runs it on Feb 20 2019, the code expects the velocity data to files be available on now cast green at least up to Jan 2019

'''


if __name__ == "__main__":
    
    for m in range (1, 13):
    
        DATA_LIMIT = dt.date.today() - relativedelta(days = 2)
    
    
        first_day = dt.date(
                            year = 2016,
                            month = m,
                            day = 1
                            )
                 
        
        last_day = first_day + relativedelta(months = 1) - relativedelta(days = 1) #up to the last day of that month
        
    
        
        trajectory_length = min((DATA_LIMIT - last_day).days, 101)
    
        print (first_day, last_day, DATA_LIMIT, trajectory_length)
    
    
        
        pre_run (
                     first_day = first_day, 
                     last_day = last_day, 
                     trajectory_length = trajectory_length 
                     )
        
