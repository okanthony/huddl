team1 = Team.create(name: "Athletics", sport: "Baseball")
User.create(first_name: "John", last_name: "Farrell", email: "admin@admin.com", password: "password", admin: true, team: team1)
Game.create(street: "32 Main Street", city: "Boston", state: "MA", zip: "01233", game_day: "2016/06/13", game_time: "6:00 PM", opponent: "Astros", team: team1)
