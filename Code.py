import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

fifa = pd.read_csv('fifa_cleaned.csv')

r, c = fifa.shape
print(f'Number of rows in the dataset: {r}')
print(f'Number of columns in the dataset: {c}')
print('Column Names of the dataset are:')
print(fifa.columns.tolist())

c1 = ['name', 'age', 'nationality', 'positions', 'overall_rating', 'value_euro', 'wage_euro',
      'club_team', 'crossing', 'finishing', 'heading_accuracy', 'short_passing', 'volleys',
      'dribbling', 'curve', 'freekick_accuracy', 'long_passing', 'ball_control', 'acceleration',
      'sprint_speed', 'agility', 'reactions', 'balance', 'shot_power', 'jumping', 'stamina',
      'strength', 'long_shots', 'aggression', 'interceptions', 'positioning', 'vision',
      'penalties', 'composure', 'marking', 'standing_tackle', 'sliding_tackle', 'GK_diving',
      'GK_handling', 'GK_kicking', 'GK_positioning', 'GK_reflexes']
fifa = fifa[c1].dropna()
fifa = fifa[fifa['overall_rating'] >= 75]

attacking = ['finishing', 'heading_accuracy', 'freekick_accuracy', 'shot_power', 'penalties']
playmaking = ['crossing', 'short_passing', 'dribbling', 'long_passing', 'vision']
physicality = ['sprint_speed', 'reactions', 'jumping', 'stamina', 'strength']
defending = ['interceptions', 'positioning', 'marking', 'standing_tackle', 'sliding_tackle']
goalkeeping = ['GK_diving', 'GK_handling', 'GK_kicking', 'GK_positioning', 'GK_reflexes']

random_players = fifa.sample(2)
player1, player2 = random_players.iloc[0], random_players.iloc[1]

def print_comparison():
    print(f"{player1['name']} vs {player2['name']} Comparison")
    print(f"Age: {player1['age']} | {player2['age']}")
    print(f"Nationality: {player1['nationality']} | {player2['nationality']}")
    print(f"Position: {player1['positions']} | {player2['positions']}")
    print(f"Rating: {player1['overall_rating']} | {player2['overall_rating']}")
    print(f"Value(Euros): {player1['value_euro']} | {player2['value_euro']}")

print_comparison()

def plot_comparison(attrs, title):
    values1 = player1[attrs].values
    values2 = player2[attrs].values
    labels = attrs
    
    x = np.arange(len(labels))
    width = 0.4
    
    fig, ax = plt.subplots()
    ax.bar(x - width/2, values1, width, label=player1['name'], color='red')
    ax.bar(x + width/2, values2, width, label=player2['name'], color='blue')
    
    ax.set_xlabel('Attributes')
    ax.set_ylabel('Scores')
    ax.set_title(title)
    ax.set_xticks(x)
    ax.set_xticklabels(labels, rotation=45, ha='right')
    ax.legend()
    plt.show()

plot_comparison(attacking, 'Attacking Stats')
plot_comparison(playmaking, 'Playmaking Stats')
plot_comparison(physicality, 'Physicality Stats')
plot_comparison(defending, 'Defending Stats')
plot_comparison(goalkeeping, 'Goalkeeping Stats')

def correlation_strength(z):
    if z == 0:
        print('No relation')
    elif z < 0:
        print('Negative correlation')
    else:
        print('Positive correlation')
    
    z = abs(z)
    if z == 1:
        print('Perfect Relation')
    elif z > 0.7:
        print('Strong Relation')
    elif z > 0.3:
        print('Moderate Relation')
    else:
        print('Weak Relation')

fifa['attacking'] = fifa[attacking].mean(axis=1)
fifa['playmaking'] = fifa[playmaking].mean(axis=1)
fifa['physicality'] = fifa[physicality].mean(axis=1)
fifa['defending'] = fifa[defending].mean(axis=1)
fifa['goalkeeping'] = fifa[goalkeeping].mean(axis=1)

attributes = ['age', 'value_euro', 'overall_rating']
pd.plotting.scatter_matrix(fifa[attributes], alpha=0.2, figsize=(8, 8), diagonal='hist')
plt.show()

correlations = [
    ('Age and Value', fifa['age'].corr(fifa['value_euro'])),
    ('Age and Rating', fifa['age'].corr(fifa['overall_rating'])),
    ('Rating and Value', fifa['overall_rating'].corr(fifa['value_euro'])),
    ('Attacking and Rating', fifa['attacking'].corr(fifa['overall_rating'])),
    ('Playmaking and Rating', fifa['playmaking'].corr(fifa['overall_rating'])),
    ('Physicality and Rating', fifa['physicality'].corr(fifa['overall_rating'])),
    ('Defending and Rating', fifa['defending'].corr(fifa['overall_rating'])),
    ('Goalkeeping and Rating', fifa['goalkeeping'].corr(fifa['overall_rating']))
]

for label, corr in correlations:
    print(f'{label} Correlation: {corr:.3f}')
    correlation_strength(corr)
