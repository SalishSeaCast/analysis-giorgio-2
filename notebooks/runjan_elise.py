#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 17 12:01:56 2017

@author: gsgarbi
"""

from start_runsnew import runlength



if __name__ == "__main__":
    for month in (1,):
        
        if month == 12:
            
            runlength (first_day = {"year": 2016, "month": month, "day": 1}, last_day = {"year": 2017, "month": 1, "day": 1}, trajlength = (13 - month) * 30)
            
        else:
            runlength (first_day = {"year": 2016, "month": month, "day": 1}, last_day = {"year": 2016, "month": month + 1, "day": 1}, trajlength = (13 - month) * 30)
        

        
        
    
    """example: to run for the month of September with each trajectory length equal to 100 days,
    the arguments should be: first_day = {"year": 2016, "month": 9, "day": 1}, last_day = {"year": 2016, "month": 9, "day": 30}, trajlength = 100"""