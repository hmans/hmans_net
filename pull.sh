set -e
set -x
MONGO_URL="mongodb://localhost/schreihals" heroku mongo:pull
