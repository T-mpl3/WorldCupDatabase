
# Do not change code above this line. Use the PSQL variable above to query your database.
$PSQL "TRUNCATE TABLE games, teams"
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
do
if [[ $WINNER != 'winner' ]]
then   
  
  #INSERT WINNER INTO TEAMS
    #CHECK IF WINNER IS ALREADY IN DB
    WINNER_SEARCH_RESULT=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
    #IF IT ISNT THEN ADD IT TO DB
    if [[ -z $WINNER_SEARCH_RESULT ]]
    then
      WINNER_INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi
  #INSERT OPPONENT INTO TEAMS
    #CHECK IF OPPONENT IS ALREADY IN DB
    OPPONENT_SEARCH_RESULT=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
    #IF IT ISNT THEN ADD IT TO DB
    if [[ -z $OPPONENT_SEARCH_RESULT ]]
    then
      OPPONENT_INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    fi
  #GET THE WINNER AND OPPONENT IDS
  WINNER_ID=$($PSQL"SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  #INSERT INTO GAMES
  GAME_INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID','$WINNER_GOALS', '$OPPONENT_GOALS')")
fi
done
