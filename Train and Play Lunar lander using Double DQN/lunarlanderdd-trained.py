import gym
import random
import torch
import numpy as np
from collections import deque
import matplotlib.pyplot as plt


env = gym.make('LunarLander-v2')
env.seed(0)
print('State shape: ', env.observation_space.shape)
print('Number of actions: ', env.action_space.n)

from ddqn_agent import Agent

agent = Agent(state_size=8, action_size=4, seed=0)



# load the weights from file
agent.qnetwork_local.load_state_dict(torch.load('checkpointdd.pth'))

for i in range(3):
    state = env.reset()
    score=0 
    for j in range(200):
        action = agent.act(state)
        env.render()
        state, reward, done, _ = env.step(action)
        score+=reward
        if done:
            break 
    print('Score: %d' %score)
            
env.close()
