//dataset: https://data.world/raghav333/fifa-players
fifa = read.csv('fifa_cleaned.csv')
head(fifa)
r = nrow(fifa)
c = ncol(fifa)
print(paste("Number of rows in the dataset: ",r))
print(paste("Number of columns in the dataset: ",c))
attribute = colnames(fifa)
print("Column Names of the data set are:")
attribute
c1 = c('name','age','nationality','positions','overall_rating','value_euro','wage_euro',
       'club_team','crossing','finishing','heading_accuracy', 'short_passing', 'volleys',
       'dribbling','curve','freekick_accuracy', 'long_passing', 'ball_control', 'acceleration',
       'sprint_speed', 'agility', 'reactions', 'balance',  'shot_power', 'jumping', 'stamina',
       'strength', 'long_shots', 'aggression', 'interceptions', 'positioning', 'vision',
       'penalties', 'composure', 'marking', 'standing_tackle', 'sliding_tackle', 'GK_diving',
       'GK_handling', 'GK_kicking', 'GK_positioning', 'GK_reflexes')
fifa = fifa[,c1]
fifa = na.omit(fifa)
fifa = subset(fifa, overall_rating >= 75)
attacking = c('finishing','heading_accuracy','freekick_accuracy','shot_power','penalties')
a = c('Finish','','Head','','Freekick','','Shot Pow','','Pen','')
playmaking = c('crossing','short_passing','dribbling','long_passing','vision')
p = c('Cross','','Short Pass','','Drib','','Long Pass','','Vision','')
physicality = c('sprint_speed','reactions','jumping','stamina','strength')
p1 = c('Speed','','React','','Jump','','Stamina','','Strength','')
defending = c('interceptions', 'positioning','marking', 'standing_tackle', 'sliding_tackle')
d = c('Intercept','', 'Position','', 'Mark','', 'Stand Tackle','', 'Slide Tackle','')
goalkeeping = c('GK_diving','GK_handling', 'GK_kicking', 'GK_positioning', 'GK_reflexes')
g = c('Dive','', 'Handle','', 'Kick','', 'Position','', 'Reflex','')
random_names = sample(fifa$name, size = 2)
n1 = random_names[1]
n2 = random_names[2]

r1 = which(fifa$name == n1)
r2 = which(fifa$name == n2)

name1 = fifa$name[r1]
age1 = fifa$age[r1]
nationality1 = fifa$nationality[r1]
position1 = fifa$positions[r1]
rating1 = fifa$overall_rating[r1]
value1 = fifa$value_euro[r1]
attacking1 = unlist(fifa[r1,attacking])
playmaking1 = unlist(fifa[r1,playmaking])
physicality1 = unlist(fifa[r1,physicality])
defending1 = unlist(fifa[r1,defending])
goalkeeping1 = unlist(fifa[r1,goalkeeping])
name2 = fifa$name[r2]
age2 = fifa$age[r2]
nationality2 = fifa$nationality[r2]
position2 = fifa$positions[r2]
rating2 = fifa$overall_rating[r2]
value2 = fifa$value_euro[r2]
attacking2 = unlist(fifa[r2, attacking])
playmaking2 = unlist(fifa[r2, playmaking])
physicality2 = unlist(fifa[r2, physicality])
defending2 = unlist(fifa[r2, defending])
goalkeeping2 = unlist(fifa[r2, goalkeeping])

print(paste(name1,' vs ', name2, ' Comparison'))
print(paste('Age: ', age1, ' | ', age2))
print(paste('Nationality: ', nationality1, ' | ', nationality2))
print(paste('Position: ', position1, ' | ', position2))
print(paste('Rating: ', rating1, ' | ', rating2))
print(paste('Value(Euros): ', value1, ' | ', value2))
barplot(c(attacking1,attacking2),col = c('red','blue'),width = 2,names.arg = a, main = paste(name1,' vs ', name2, ' Attacking stats'))
legend("topright", legend = c(name1,name2), fill = c('red','blue'))

barplot(c(playmaking1,playmaking2),col = c('red','blue'),width = 2,names.arg = p, main = paste(name1,' vs ', name2, ' Playmaking stats'))
legend("topright", legend = c(name1,name2), fill = c('red','blue'))

barplot(c(physicality1,physicality2),col = c('red','blue'),width = 2,names.arg = p1, main = paste(name1,' vs ', name2, ' Physicality stats'))
legend("topright", legend = c(name1,name2), fill = c('red','blue'))

barplot(c(defending1,defending2),col = c('red','blue'),width = 2,names.arg = d, main = paste(name1,' vs ', name2, ' Defending stats'))
legend("topright", legend = c(name1,name2), fill = c('red','blue'))

barplot(c(goalkeeping1,goalkeeping2),col = c('red','blue'),width = 2,names.arg = g, main = paste(name1,' vs ', name2, ' Goalkeeping stats'))
legend("topright", legend = c(name1,name2), fill = c('red','blue'))

corelation = function(z){
  if(z==0){
    print('No relation')
  }else if(z<0){
    print('Negative corelation')
  }else{
    print("Positive corelation")
  }
  z = abs(z)
  if(z == 1){
    print("Perfect Relation")
  }else if(z>0.7){
    print("Strong Relation")
  }else if(z>0.3){
    print("Moderate Relation")
  }else{
    print("Weak Relation")
  }
}

fifa$attacking = (fifa$finishing + fifa$heading_accuracy + fifa$freekick_accuracy + fifa$shot_power + fifa$penalties)/5
fifa$playmaking = (fifa$crossing + fifa$short_passing + fifa$dribbling + fifa$long_passing + fifa$vision)/5
fifa$physicality = (fifa$sprint_speed + fifa$reactions + fifa$jumping + fifa$stamina + fifa$strength)/5
fifa$defending = (fifa$interceptions + fifa$positioning + fifa$marking + fifa$standing_tackle + fifa$sliding_tackle)/5
fifa$goalkeeping = (fifa$GK_diving + fifa$GK_handling + fifa$GK_kicking + fifa$GK_positioning + fifa$GK_reflexes)/5
pairs(fifa[,c('age','value_euro','overall_rating')])
x = cor(fifa$age,fifa$value_euro)
print(paste('Age and Value Corelation is: ',x))
corelation(x)
x = cor(fifa$age,fifa$overall_rating)
print(paste('Age and Rating Corelation is: ',x))
corelation(x)
x = cor(fifa$value_euro,fifa$value_euro)
print(paste('Rating and Value Corelation is: ',x))
corelation(x)
plot(fifa$attacking,fifa$overall_rating)
x = cor(fifa$attacking,fifa$overall_rating)
print(paste('Attacking and Rating Corelation is: ',x))
corelation(x)

plot(fifa$playmaking,fifa$overall_rating)
x = cor(fifa$playmaking,fifa$overall_rating)
print(paste('Playmaking and Rating Corelation is: ',x))
corelation(x)

plot(fifa$physicality,fifa$overall_rating)
x = cor(fifa$physicality,fifa$overall_rating)
print(paste('Physicality and Rating Corelation is: ',x))
corelation(x)

plot(fifa$defending,fifa$overall_rating)
x = cor(fifa$defending,fifa$overall_rating)
print(paste('Defending and Rating Corelation is: ',x))
corelation(x)

plot(fifa$goalkeeping,fifa$overall_rating)
x = cor(fifa$goalkeeping,fifa$overall_rating)
print(paste('Goalkeeping and Rating Corelation is: ',x))
corelation(x)
