team1 = Team.create(name: "Red Sox", sport: "Baseball")
User.create(first_name: "John", last_name: "Farrell", email: "admin@admin.com", password: "password", admin: true, team: team1)
User.create(first_name: "Nomar", last_name: "Garciapara", email: "user1@user.com", password: "password", team: team1)
Game.create(street: "32 Main Street", city: "Boston", state: "MA", zip: "01233", game_day: "2016/06/13", game_time: "6:00 PM", opponent: "Athletics", team: team1)
