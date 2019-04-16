// Treehouse Tech Degree, Unit 1, Assignment 1
// Student: Casey Conway

//------------PART 1---------------
//Create a single collection 'players' that contains all information for all 18 players as dictionaries with string keys.
/*
 --Key--
 "name" = Player name
 "height" = Player height in inches
 "isExperienced" is true if they have soccer experience. False if they don't.
 "guardians" = Player's guardian name(s)
 */
let players: [[String:Any]] = [["name": "Joe Smith", "height": 42, "isExperienced": true, "guardians": "Jim and Jan Smith"],["name": "Jill Tanner", "height": 36, "isExperienced": true, "guardians": "Clara Tanner"],["name": "Bill Bon", "height": 43, "isExperienced": true, "guardians": "Sara and Jenny Bon"],["name": "Eva Gordon", "height": 45, "isExperienced": false, "guardians": "Wendy and Mike Gordon"],["name": "Matt Gill", "height": 40, "isExperienced": false, "guardians": "Charles and Sylvia Gill"],["name": "Kimmy Stein", "height": 41, "isExperienced": false, "guardians": "Bill and Hilary Stein"],["name": "Sammy Adams", "height": 45, "isExperienced": false, "guardians": "Jeff Adams"],["name": "Karl Saygan", "height": 42, "isExperienced": true, "guardians": "Heather Bledsoe"],["name": "Suzane Greenberg", "height": 44, "isExperienced": true, "guardians": "Henrietta Dumas"],["name": "Sal Dali", "height": 41, "isExperienced": false, "guardians": "Gala Dali"],["name": "Joe Kavalier", "height": 39, "isExperienced": false, "guardians": "Sam and Elaine Kavalier"],["name": "Ben Finkelstein", "height": 44, "isExperienced": false, "guardians": "Aaron and Jill Finkelstein"],["name": "Diego Soto", "height": 41, "isExperienced": true, "guardians": "Robin and Sarika Soto"],["name": "Chloe Alaska", "height": 47, "isExperienced": false, "guardians": "David and Jamie Alaska"],["name": "Arnold Willis", "height": 43, "isExperienced": false, "guardians": "Claire Willis"],["name": "Phillip Helm", "height": 44, "isExperienced": true, "guardians": "Thomas Helm and Eva Jones"],["name": "Les Clay", "height": 42, "isExperienced": true, "guardians": "Wynonna Brown"],["name": "Herschel Krustofski", "height": 45, "isExperienced": true, "guardians": "Hyman and Rachel Krustofski"]]

//Create empty arrays for each of the teams and one way to store all of them
var teamSharks: [[String: Any]] = []
var teamDragons: [[String: Any]] = []
var teamRaptors: [[String: Any]] = []
var teams: [[[String: Any]]] = [teamSharks, teamDragons, teamRaptors]


//------------PART 2---------------
//Sort the players in experienced and inexperienced groups
var experiencedPlayers: [[String: Any]] = []
var inexperiencedPlayers: [[String: Any]] = []

for player in players {
    if let playerIsExperienced = player["isExperienced"] as? Bool {
        if playerIsExperienced == true {
            experiencedPlayers.append(player)
        } else {
            inexperiencedPlayers.append(player)
        }
    } else {
        print("No dictionary key \"isExperienced\" or conversion failed")
    }
}

// This evenly distributes players from a group into the number of teams in the "teams" array.
//It handles uneven number of players and any number of teams
func distributePlayers(fromPlayerGroup playerGroup: [[String:Any]]) {
    let numberOfTeams: Int = teams.count
    //Decide which team to start with by determining the first team with the least players, otherwise the first team team tied for last, or, if all equal, the first team in the teams array. Capture that team by the position in the array "teams"
    var teamWithLeastPlayersArrayPosition: Int = 0 //initialize with the first team in the teams array
    for n in 1...(teams.count-1) {
        if teams[n].count < teams[teamWithLeastPlayersArrayPosition].count {
            teamWithLeastPlayersArrayPosition = n
        }
    }
    //Distribute the players, starting with team with least players, if exists
    var teamNumber: Int = teamWithLeastPlayersArrayPosition //Team number corresponds to the position in the array.
    
    for player in playerGroup {
        //loop back to the first team if we've completed round 1 of distributing players across each team
        if teamNumber == numberOfTeams {
            teamNumber = 0
        }
        teams[teamNumber].append(player)
        teamNumber += 1
    }
}

//Call the distributePlayers function twice in order to distribute of the inexperienced player group and then the experienced player groups across the three teams and store it in the teams array
distributePlayers(fromPlayerGroup: experiencedPlayers)
distributePlayers(fromPlayerGroup: inexperiencedPlayers)

//Once division is complete, assign three teams the list of players from the "teams" array
teamSharks = teams[0]
teamDragons = teams[1]
teamRaptors = teams[2]


//------------PART 3---------------
/* Write code that iterates through all three teams of players and generates a personalized letter to the guardians...
 */

//Where the letters are stored:
var letters: [String] = []
//Generates all the letters for a given team. Depends on pre-initialized var "letters"
func generateLetters(forTeam team: [[String:Any]], ofName teamName: String, forPracticeOn practiceDateAndTime: String) {
    for player in team {
        //Safely unwrap optionals, method inspired by article:
        //https://parussini.codes/posts/the-techdegree-blog-optionals-in-swift-and-how-to-deal-with-them
        if let playerName = player["name"] as? String {
            if let guardianNames = player["guardians"] as? String {
                let letter = """
                Dear \(guardianNames),
                
                This year we've taken extra care to make sure the teams are fairly matched by evenly dividing the number of experienced players between the teams. \(playerName) has been placed on... DRUM ROLL PLEASE... the \(teamName)!
                
                The first team practice for the \(teamName) is on \(practiceDateAndTime). Let the games begin!
                
                Best,
                Casey Conway
                League Coordinator
                
                
                """
                letters.append(letter)
            } else {
                print("No dictionary key \"guardians\" or conversion failed")
            }
        } else {
            print("No dictionary key \"name\" or conversion failed")
        }
    }
}

//Generate letters team by team
generateLetters(forTeam: teamSharks, ofName: "Sharks", forPracticeOn: "March 17th at 3pm")
generateLetters(forTeam: teamDragons, ofName: "Dragons", forPracticeOn: "March 17th at 1pm")
generateLetters(forTeam: teamRaptors, ofName: "Raptors", forPracticeOn: "March 18th at 1pm")

//print out all the letters in the console
for letter in letters {
    print(letter)
}
