class SessionsController < ApplicationController
  
end

# Build a SessionsController.
# Add a singular session resource.
# There is at most one session in the user's life; they don't need to have routes to address multiple sessions.
# Write a new form that has the user input their username and password.
# In SessionsController#create:
# Verify the user_name/password.
# (Re)set the User's session_token.
# Update the session.
# Redirect the user to the cats index.
