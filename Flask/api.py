  
#performing flask imports
from cv2 import cv2
import numpy as np
import imutils
from flask import Flask, render_template, request, redirect, url_for,session,make_response
app = Flask(__name__) #intance of our flask application 
UPLOAD_FOLDER = r'C:\Users\johny\OneDrive\Desktop\Work\api\images'

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
#############################################
# now have to implement deep learning model into flask and send back a proper responds 
# check latency
# check any issues presist
#############################################
@app.route('/', methods=['GET'])
def home():
    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"
#Route '/' to facilitate get request from our flutter app
@app.route('/upload', methods=['POST','GET'])
def upload_file():
    if request.method == "POST":
        if request.files['file'].filename != '':
            image = request.files['file']
            npimg = np.fromfile(image,np.uint8)
            img =(cv2.imdecode(npimg,cv2.IMREAD_COLOR))
            resized = imutils.resize(img, width=900)
            print(image.filename)
            cv2.imshow("hello",resized)
            cv2.waitKey(0)
            return("hello")
        return("None")


if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5000) #debug will allow changes without shutting down the server 