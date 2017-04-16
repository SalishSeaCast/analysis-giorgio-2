
# In[27]:

def initp(directory):
    txt = """303 445 24.5 1 1.0
303 445 25.5 2 1.0
303 445 26.5 3 1.0
303 445 24.5 4 1.0
303 445 25.5 5 1.0
303 445 26.5 6 1.0
303 445 24.5 7 1.0
303 445 25.5 8 1.0
303 445 26.5 9 1.0
303 445 24.5 10 1.0
303 445 25.5 11 1.0
303 445 26.5 12 1.0
303 445 24.5 13 1.0
303 445 25.5 14 1.0
303 445 26.5 15 1.0
303 445 24.5 16 1.0
303 445 25.5 17 1.0
303 445 26.5 18 1.0
303 445 24.5 19 1.0
303 445 25.5 20 1.0
303 445 26.5 21 1.0
303 445 24.5 22 1.0
303 445 25.5 23 1.0
303 445 26.5 24 1.0"""
    
    file = open (directory + "/initial_positions.txt", "w")
    file.write(txt)
    
    print ("initial_positions.txt created in ", directory)
    

def longinitp(directory, numdays):    

    txt = ''    




    for i in range(1, 24*numdays+1):
        editp = {'p': i}
        txt = '\n'.join( (txt, "303 445 24.5 {p} 1.0\n303 445 25.5 {p} 1.0\n303 445 26.5 {p} 1.0".format( **editp ))   )

    file = open (directory + "/initial_positions.txt", "w")
    file.write(txt)
    
    print ("initial_positions.txt created in ", directory)


# In[28]:




# In[ ]:




# In[24]:




# In[ ]:



