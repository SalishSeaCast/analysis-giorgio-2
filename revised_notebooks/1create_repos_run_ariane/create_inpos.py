def longinitp(directory, numdays):    

    txt = ''    

    for i in range( 1, 24*(numdays) + 1):
        editp = {'p': i}
        txt = '\n'.join( 
                (txt, 
                "303 445 24.5 {p} 1.0\n303 445 25.5 {p} 1.0\n303 445 26.5 {p} 1.0".format( **editp ))
                )

    file = open (directory + "/initial_positions.txt", "w")
    file.write(txt)
    
    print ("initial_positions.txt created in ", directory)