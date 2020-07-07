import requests
import json
import re
session = requests.Session()

def grab_frinex_data(experiment_name,password,which_data):

	#login
	url = 'https://frinexstaging.mpi.nl/'+experiment_name+'-admin/'
	auth = {'username': experiment_name,'password': password}
	x = session.post(url+'login', data = auth,  allow_redirects=True)

	#get basic info for parsing (page size and number of pages)
	iteration_info=session.get(url+which_data)
	jsondata = json.loads(iteration_info.text)
	lastpage=jsondata['page']['totalPages']
	pagesize=jsondata['page']['size']
	alldata=[]
	#iterate trough pages
	for counter in range(0,lastpage):
		temp=session.get(url +which_data +'?page=' +str(counter)+ '&size='+str(pagesize))
		tempdict=json.loads(temp.text)
		addthis=tempdict['_embedded'][which_data]
		alldata=alldata+addthis
	return alldata

