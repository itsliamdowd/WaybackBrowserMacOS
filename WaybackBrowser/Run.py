from flask import Flask, request
from flask import render_template
import jinja2
import jinja2.ext
import logging

app = Flask(__name__)
log = logging.getLogger('werkzeug')
log.disabled = True

@app.route("/loadpage/")
def loadpage():
    url = request.args.get('url')
    print(url)
    year = request.args.get('year')
    print(year)
    month = request.args.get('month')
    print(month)
    day = request.args.get('day')
    print(day)
    url = "https://web.archive.org/web/" + str(year) + str(month) + str(day) + "043326if_/" + url
    print(url)
    return render_template("loadpage.html", url=url)

@app.route("/home")
def home():
    return render_template("home.html")
    
if __name__ == "__main__":
    app.run(debug=False)
