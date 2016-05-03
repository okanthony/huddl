# Huddl
Recreational sports team management app

![Build Status](https://codeship.com/projects/1256c450-e870-0133-544b-46bb3aa6b241/status?branch=master)
![Code Climate](https://codeclimate.com/github/okanthony/huddl.png)
![Coverage Status](https://coveralls.io/repos/okanthony/huddl/badge.png)

Huddl: http://huddl.herokuapp.com

## What is it?
No longer will players on a company or intramural sports team be out of sync. Delete that convoluted group text thread because Huddl is an easy-to-use, dynamic web app geared towards keeping players in the know at all times. Team captains can create a team and quickly invite other players via email as well as add, edit and delete upcoming games. Once players have logged in they can submit their RSVP for each game. By opting to add their cell phone numbers to their account, players will receive text message alerts when a game has been added, modified, or if they have yet to RSVP for an upcoming game.

## What's in it?
Huddl is built in Ruby on Rails, utilizing Devise for account management and DeviseInvitable for email invitations. Text alerts are managed via Twilio.
