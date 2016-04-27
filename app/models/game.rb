class Game < ActiveRecord::Base
  has_many :confirmations
  geocoded_by :full_address
  after_validation :geocode

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :game_day, presence: true
  validates :game_time, presence: true

  after_create :reminder
  @@REMINDER_TIME = 180.minutes
  @@CLIENT = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])

  STATES = [
    ["Alaska", "AK"], ["Alabama", "AL"], ["Arkansas", "AR"], ["Arizona", "AZ"],
    ["California", "CA"], ["Colorado", "CO"], ["Connecticut", "CT"], ["District of Columbia", "DC"],
    ["Delaware", "DE"], ["Florida", "FL"], ["Georgia", "GA"], ["Hawaii", "HI"], ["Iowa", "IA"],
    ["Idaho", "ID"], ["Illinois", "IL"], ["Indiana", "IN"], ["Kansas", "KS"], ["Kentucky", "KY"],
    ["Louisiana", "LA"], ["Massachusetts", "MA"], ["Maryland", "MD"], ["Maine", "ME"], ["Michigan", "MI"],
    ["Minnesota", "MN"], ["Missouri", "MO"], ["Mississippi", "MS"], ["Montana", "MT"], ["North Carolina", "NC"],
    ["North Dakota", "ND"], ["Nebraska", "NE"], ["New Hampshire", "NH"], ["New Jersey", "NJ"],
    ["New Mexico", "NM"], ["Nevada", "NV"], ["New York", "NY"], ["Ohio", "OH"], ["Oklahoma", "OK"],
    ["Oregon", "OR"], ["Pennsylvania", "PA"], ["Rhode Island", "RI"], ["South Carolina", "SC"], ["South Dakota", "SD"],
    ["Tennessee", "TN"], ["Texas", "TX"], ["Utah", "UT"], ["Virginia", "VA"], ["Vermont", "VT"],
    ["Washington", "WA"], ["Wisconsin", "WI"], ["West Virginia", "WV"], ["Wyoming", "WY"]
  ].freeze

  def full_address
    "#{street}, #{city}, #{state}"
  end

  def text(action, game, indicator)
    if indicator == true
      @closing_remark = ". Log on to Huddl to confirm your roster spot!"
    else
      @closing_remark = "."
    end
    @@CLIENT.messages.create(
      from: ENV["TWILIO_PHONE_NUMBER"],
      to: 19788080213,
      body: "Your captain #{action} a game, #{game.game_day.strftime('%b %eth, %Y')}#{@closing_remark}"
    )
  end

  def reminder
    @client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    time_str = self.game_time.strftime('%l:%M %p')
    reminder = "Just a reminder, you have a game today at #{time_str}!"
    @client.messages.create(
      from: ENV["TWILIO_PHONE_NUMBER"],
      to: 19788080213,
      body: reminder
    )
  end

  def when_to_run
    d = game_day
    t = game_time
    date_time = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    date_time - @@REMINDER_TIME 
  end

  handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run }
end
