class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @name = current_user.first_name
    @team = current_user.team
    @game = Game.where("game_day >= ?", Date.today).order("game_day ASC").limit(1).first
    @roster = Confirmation.where(game: @game, rsvp: true).order(updated_at: :asc)
    @quote = QUOTES.sample
  end

  def invite
    User.invite!(email: "degennaro.anthony@gmail.com", first_name: "Anthony", last_name: "DeGennaro")
    @name = current_user.first_name
    @team = current_user.team
    @game = Game.where("game_day >= ?", Date.today).order("game_day ASC").limit(1).first
    @roster = Confirmation.where(game: @game, rsvp: true).order(updated_at: :asc)
    @quote = QUOTES.sample
    render :index
  end

  QUOTES = [
    "'I\'m a ballplayer, not an actor.' - Joe DiMaggio",
    "'Baseball is like poker; nobody wants to quit when they\'re losing, nobody wants you to quit when you\'re ahead.' - Jackie Robinson",
    "'It isn\'t over until it\'s over\'. - Yogi Berra",
    "'Superstition? Just one. Whenever I hit a home run, I make certain I touch all four bases.' - Babe Ruth?",
    "'Hitting the ball was easy. Running around the bases was the tough part.' - Micky Mantle",
    "'They invented the All-Star game for Willie Mays.' - Ted Williams",
    "'They throw the ball, I hit it. They hit the ball, I catch it.' - Willie Mays",
    "'I never worried about the fastball, they couldn\'t throw it past me. None of them.' - Willie Mays",
    "'A ball bat is a wondrous weapon.' - Ty Cobb",
    "'Baseball is dull only to dull minds.' - Red Barber",
    "'If I\'d just tried for them singles I could\'ve batted around .600.' - Babe Ruth",
    "'The ballplayer who loses his head, who can\'t keep his cool, is worse than no ballplayer at all.' - Lou Gehrig",
    "'The last thing you want to do is go down in the history as the only injury sustained during the team picture.' - Cal Ripken, Jr.",
    "'A team is where a boy can prove his courage on his own.' - Micky Mantle",
    "'It\'s unbelievable how much you don\'t know about the game you\'ve been playing all your life.' -  Micky Mantle",
    "'Hitting is fifty percent above the shoulders.' -  Ted Williams",
    "'If I have my choice between a pennant and a triple crown, I\'ll take the pennant every time.' - Carl Yastrzemski",
    "'It gets late early out there.' - Yogi Berra",
    "'All pitchers are born pitchers.' - Joe DiMaggio",
    "'I think the most privacy I had was when the game was going on.' - Roger Marris",
    "'Above anything else, I hate to lose.' - Jackie Robinson",
    "'Honestly, at one time I though Babe Ruth was a cartoon character.' - Don Mattingly"
  ].freeze
end
