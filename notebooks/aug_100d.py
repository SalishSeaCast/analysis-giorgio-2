#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 17 12:01:56 2017

@author: gsgarbi
"""

from start_runsnew import runlength

if __name__ == "__main__":
    runlength (first_day = {"year": 2016, "month": 8, "day": 1}, last_day = {"year": 2016, "month": 8, "day": 31}, trajlength = 100)
    
    
    """example: to run for the month of September with each trajectory length equal to 100 days,
    the arguments should be: first_day = {"year": 2016, "month": 9, "day": 1}, last_day = {"year": 2016, "month": 9, "day": 30}, trajlength = 100"""