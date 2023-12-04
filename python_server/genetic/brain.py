import torch
from torch import nn

class Brain(nn.Module):
    
    def __init__(self,input_size=16, output_size=2, hidden_size=30):
        super().__init__()

        self.input = nn.Sequential(

            nn.Linear(in_features=input_size,out_features=hidden_size),
            nn.ReLU(),
            nn.Linear(in_features=hidden_size,out_features=hidden_size),
            nn.ReLU(),
            nn.Linear(in_features=hidden_size,out_features=hidden_size),
            nn.ReLU()
            )

        self.output = nn.Sequential(
            nn.Linear(in_features=hidden_size,out_features=hidden_size),
            nn.ReLU(),
            nn.Linear(in_features=hidden_size,out_features=hidden_size),
            nn.ReLU(),
            nn.Linear(in_features=hidden_size,out_features=output_size),
            nn.Tanh()
            )
        # Initialize the weights
        self.initialize_weights()
    def initialize_weights(self):
        for module in self.modules():
            if isinstance(module, nn.Linear):
                # Apply Xavier initialization to linear layers
                nn.init.xavier_uniform_(module.weight)
    def forward(self, x):
        # print(x)
        x = self.input(x)
        # print(x)
        y = self.output(x)
        return y
    
    def save_model(self,file_name="QNet_model.pth"):
        torch.save(self.state_dict(),file_name)
        
    def brain_move(self,sensors_array):
        sensors = torch.tensor( sensors_array, dtype= torch.float)
        result = self.forward(sensors).tolist()
        # velocity = torch.argmax(result).item()
        return result