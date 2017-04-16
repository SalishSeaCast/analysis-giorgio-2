from start_runsnew import runlength

if __name__ == "__main__":
    runlength (first_day = {"year": 2016, "month": 7, "day": 1}, last_day = {"year": 2016, "month": 7, "day": 2}, trajlength = 5)
    
    runlength (first_day = {"year": 2016, "month": 2, "day": 10}, last_day = {"year": 2016, "month": 9, "day": 13}, trajlength = 1)
    
    """example: to run for the month of September with each trajectory length equal to 100 days,
    the arguments should be: first_day = {"year": 2016, "month": 9, "day": 1}, last_day = {"year": 2016, "month": 9, "day": 30}, trajlength = 100"""