import csv
import numpy as np
import random



def EGREEDY(state,Transitions,epsilon):
	cols = ["id","stateId","actionid","nextstateid","reward","probability","qvalue"]
	Avail_Transitions=Transitions[np.ix_(Transitions[:,1]==float(state),np.array([True,True,True,True,True,True]))];
	
	if np.random.rand() < epsilon:
		
		action= np.argmax(Avail_Transitions[:,5])
	else:
		action = random.randint(0,len(Avail_Transitions))
	
	return int(Avail_Transitions[action-1][0])
	
def SARSA(States,Transitions,alpha,gamma,epsilon,episodes):
	count=0
	for episode in range(0,episodes):
		count+= 1
		print (Transitions[:,5])
		current_reward = 0
		s=random.randint(1,8)
		#print "Episode %d "%episode
		#print "Initial State:%d"%s
		a = EGREEDY(s,Transitions, epsilon)
		#print "Action Taken:%d"%a
		while States[s-1][2] != "TRUE":
			
			s1 = int(Transitions[a-1][3])
			a1 = EGREEDY(s,Transitions, epsilon)
			#print "Action Taken:%d"%a
			
			s=int(Transitions[a-1][3])
			#print "Next state State:%d"%s 
			if States[s1-1][2] == "TRUE":
				Transitions[a-1][5] = float(Transitions[a-1][5]) + (alpha * ( float(States[s1-1][1])  - float(Transitions[a-1][5]) ))
			else:
				Transitions[a-1][5]= float(Transitions[a-1][5])+(alpha * ( float(States[s1-1][1]) + (gamma * float(Transitions[a1-1][5]) ) - float(Transitions[a-1][5]) ))
			s=s1
			a=a1
	print (count)
	return Transitions[:,5]
            

StateFileName = input("Enter the file name of all the states:")
ActionFileName = input("Enter the file name of all the states:")
TransitionFileName = input("Enter the file name of all the states:")

with open(StateFileName) as csvfile1:
	States = csv.reader(csvfile1, delimiter=',')
	StatesMatrix = np.asarray(list(States))
	

with open(ActionFileName) as csvFile2:
	Actions = csv.reader(csvFile2,delimiter=',')
	ActionsMatrix = np.asarray(list(Actions))

with open(TransitionFileName) as csvFile3:
	Transitions = csv.reader(csvFile3,delimiter=',')
	TransitionsMatrix=np.asarray(list(Transitions),np.float)


alpha = float(input("Enter alpha:"))
gamma = float(input("Enter gamma:"))
epsilon = float(input("Enter epsilon:"))
episodes = int(input("Enter the number of episodes:"))

Total_reward_matrix = SARSA(StatesMatrix,TransitionsMatrix,alpha,gamma,epsilon,episodes)

print (Total_reward_matrix)
