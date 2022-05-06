
from flask import Flask,request,jsonify


app=Flask(__name__)
@app.route("/api")
def helloworld():
  d={}
  d["Query"]="data"
  return jsonify(d)
app.run()