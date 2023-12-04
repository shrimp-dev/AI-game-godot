
from genetic.brain import Brain

class Agent():
    def __init__(self,brain=Brain(),id:int=0,group="0") -> None:
        self.brain = brain
        self.id = id
        self.life_time = 0
        self.points = 0
        self.group = group


def get_population(group,size=50):
    
    return [ Agent(id=i,group=group) for i in range(size)]