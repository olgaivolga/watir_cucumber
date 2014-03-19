Feature: Login to AppServer 

Scenario: Login as non admin
Given a front page 
When a user logs in as "" with password ""
Then a message for non admins is displayed
And a user logs out

Scenario: Login as admin
Given a front page
When a user logs in as "" with password ""
Then a message for admins is displayed
And a user logs out

