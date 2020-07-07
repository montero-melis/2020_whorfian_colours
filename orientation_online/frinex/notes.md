Notes
=====

Link to staircase for discrimination task:
https://frinexstaging.mpi.nl/discat_test/

https://frinexstaging.mpi.nl/discat_test?subjectID=999


Categorization task (for now):
http://frinexstaging.mpi.nl/categorization_session/


To erase data:
Enter ?debug after the link and then pressing the button 'erase data' (different from clearing the cache).


Get data
--------

http://frinexstaging.mpi.nl/categorization_session-admin/login
- Data is always at the experiment link plus -admin so discat_test-admin
- username is experiment name
- password is needed


Different sessions -- input requirements
--------------------------------------

Discat_test now represents day one of the test battery, categorization_session the other days. Only the last day (which includes transfer test) has not been implemented but this is trivial and I will do that when I re-deploy the experiments for each day (transfer test is already implemented in discat_test).

Both experiments now require input variables or will not run/throw an error: 
- Day1 (discat_test for now) needs a numerical subjectID in the link ‘?subjectID=’.
- Other days (categorization_session for now) need subjectID, referenceAngle, and difficulty angle, making the end of link like so: categorization_session?subjectID=999&referenceAngle=50&difficultyAngle=8

The experiments do not run properly without that but this should always be provided anyway, so the exps. does not provide default/dummy values for this.


Run experiments (for test) 200705
---------------------------------

Experiments are deployed at:

https://frinexstaging.mpi.nl/discat_test_day1
https://frinexstaging.mpi.nl/discat_test_day2
Etcetera until day 5

There is also a ‘categorization_session_day1’, but discat_test_day1 links there (see below).

Notes:

- Links to days after the first now need two values, subjectID and mainTrialsDifficulty, like so: https://frinexstaging.mpi.nl/discat_test_day2/?subjectID=2&mainTrialsDifficulty=4
- Reference angle is redundant now, since it's determined by counterbalancing group (i.e. subjectID).
- First number of stimulus label is still a unique (within that presenter) ID, so just ignore it while parsing. This seems to be necessary (and is part of the reason there are 3400+ stim and not 4).
- I think some instructions need changing but perhaps best to have an RA check that and do that in one batch. One thing I already noticed is that the instructions for the Discrimination test are not counterbalanced (I just copied the text that was there which says that Z is same orientation, but obviously you want counterbalancing there, will add that)
- discat_test_day1 now links to categorization_dession_day1, had to be a separate link to prevent going over maximum lines of code. However, I think doing a full categorisation session right after staircasing etc. will be quite tiring, I’d say even the regular sessions are tiring enough.

Testing this will take ages, as said I will deploy a 'quick' version later but this is of course not a reflection of the real task then.

Just a reminder for later: please tell the RAs to exclude any participant that has ‘no shows’ and check for other remarks. In another experiment I noticed a participant who just messed around for easy money. This is quite an issue because it’s actually not so easy to just not pay them if they mess up. Excluding them from follow-up sessions should be possible though, as long as it’s clear that this is an option. I discussed this with Reiner, but for the time being it seems that if pp complete an experiment (in this case I think one of the days), we have to pay them for it. I hope other researchers check for this and make notes in the participant database, that should solve the issue quickly enough because I think it will just be a few pp.



Output explanation
==================

Hi Guillermo,

Some quick answers:

tagpairdata.csv seems to be the most relevant file. I say 'seems' because I don't completely understand the structure of files but it is the file I have the most control over. The developer actually recommends the use of the JSON data that can be gotten via HTML-commands, though pretty much everyone but Teun uses tagpairdata.

I don't know how to reset the data so I've deployed a new version of discat_test as discat_test_day1. 

The column names will not change though, those are fixed. This means the column headers actually do 'match' the data but the data can be confusing plus it does change when I update the experiment i.e. a lot. 

I've attached a snippet of the latest trials, most output should now look something like this (this is from discat_test). The first bit until 'Timeout' is a trial where there was a timeout, the last bit is a trial with an answer. You'll notice that the structure changes slightly (last two rows) but I cannot change that, it's auto-logged. 

It looks like there are no correct/incorrect answers in the data but that's because the file is clogged with timeouts because I constantly re-run the script in the background to check for issues. To avoid confusion, you can have a look at attached file for now and my redeployed discat_test_day1 later.

For most of these rows, I can change columns B, C, and D to provide you with relevant info. For some I cant, in this case rows 12, 14 and 15 are auto-logged and to make things confusing the 'stale nextStimulus blocked' only pops up ocassionally, I can guess from the name what it more or less means but don't know why/when it pops up. This means you need a parser that works with variable characteristics instead of structure, because the structure is not the same for each trial. Usually it's easiest to use 'EventTag' for that, which I notice has two times 'Event' for two different things, I'll change that. You'll need that kind of parser anyway because there are multiple parts to each day with a slightly different output. 

Bearing in mind the restrictions mentioned above, just let me know what you want to be written and I'll update the output insofar that is possible. 

I hope this clarifies things a bit, more tomorrow!

Best,
Maarten
