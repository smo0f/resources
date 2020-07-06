# Twitter API:
# https://github.com/bear/python-twitter

import twitter

CONSUMER_KEY = '9eQTtwanNETSl7gJyKqUIoC67'
CONSUMER_SECRET = 'Mc6gLSMmXw3p886D2Tu8qsYISrbChlwMUSZXzDoxFVwNmd8Rzi'
ACCESS_TOKEN = '15837902-jNP854A0rIpaQSzVBL9XhwcowxJRzKbSdgCauVKzt'
ACCESS_TOKEN_SECRET = '1LfP4Q8qQMwOPgqSS75dtTwg7xno9H9lcxgZdZ6HH1jvF'

api = twitter.Api(
              consumer_key=CONSUMER_KEY
              , consumer_secret=CONSUMER_SECRET
              , access_token_key=ACCESS_TOKEN
              , access_token_secret=ACCESS_TOKEN_SECRET
              )

users = api.GetFriends()

print([u.screen_name for u in users])