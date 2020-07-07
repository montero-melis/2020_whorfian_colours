"""
This script tries to get the difficulty angle as determined by the staircase for a certain subject as defined by 
the variable 'subno'. It gets all entries for subject 'subno' number from the database, then checks whether this subno is
uniuqe (i.e. there aren't multiple sessions with the same subno), then (if no duplicate) gets the last value for that subject,
which should contain the proper angle.

"""
# modify the three values below
subno=161 # modify this 
pynexpath = r'C:\Users\user\Desktop\desktop\Pynex' 
password = ''

import os
import pynex

os.chdir(pynexpath)


#Variables below can be modified to fit different experiments and types of data 
#(but the rest of the code assumes 'participants' data from 'discat_test').

experiment_name='discat_test'
which_data='participants'


alldata=pynex.grab_frinex_data(experiment_name,password,which_data)

output=list(filter(lambda submissions: submissions['subjectID'] == str(subno), alldata))

# Could be more elegant, but this finds all unique userIds (system-generated value) 
# belonging to the current subjectID (user-defined value. There should be only one value,
# if not then the same subject Id has been used in multiple sessions, meaning something went wrong.

uniqueids={x['userId']:x for x in output}.values() 
if len(uniqueids)>1:
	print('This subjectID is not unique! There are multiple sessions with the same ID!')
	
# This gets the last entry for subject 'subno' and checks if it has the info we need (referenceAngle and mainTrialsDifficulty).
# If it does not then either user did not complete the staircase or something went wrong.

else:
	
	mainTrialsDifficulty = output[-1]['mainTrialsDifficulty']
	referenceAngle=output[-1]['referenceAngle']
	
	if mainTrialsDifficulty !='none' and int(mainTrialsDifficulty) > 0: 
		print('mainTrialsDifficulty for subject ' + str(subno) + ' is: ' + mainTrialsDifficulty + ' . referenceAngle is: ' + referenceAngle)
	else:
		print('No valid value for mainTrialDifficulty, either something went wrong or the user did not finish the staircase!')
