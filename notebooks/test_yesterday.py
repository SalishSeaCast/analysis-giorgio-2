#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 17 12:01:56 2017

@author: gsgarbi
"""

import datetime as dt

from dateutil.relativedelta import relativedelta

from start_runsnew2 import pre_run

'''
Runs the month of July 2016 up the most recent avaliable data
This codes assumes that the data up to (present day) - 30 days is available on nowcast green

example: if one runs it on Feb 20 2019, the code expects the data to be available on now cast green at least up to Jan 2019

example: in order to run for the month of September with each trajectory length equal to 100 days, the arguments should be: 
    first_day = {"year": 2016, "month": 9, "day": 1}, 
    last_day = {"year": 2016, "month": 9, "day": 30}, 
    trajectory_length = 100
'''


if __name__ == "__main__":
    
    DATA_LIMIT = dt.date.today() - relativedelta(months=1)


    first_day = dt.date.today() - relativedelta(days = 31)
             
    
    last_day = first_day + relativedelta(days = 1)
    

    
    trajectory_length = (DATA_LIMIT - last_day).days

    print (first_day, last_day, DATA_LIMIT, trajectory_length)



    pre_run (
                 first_day = first_day, 
                 last_day = last_day, 
                 trajectory_length = trajectory_length 
                 )
        

        
