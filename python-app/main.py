# import boto3, botocore

# s3 = boto3.client(
#     "s3",
#     aws_access_key_id=os.getenv('AWS_ACCESS_KEY'),
#     aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY')
# )

from flask import Flask, render_template, request
import boto3
import os
app = Flask(__name__)
from werkzeug.utils import secure_filename
import pymongo
from pymongo import MongoClient


#Connection to Mongodb Atlas
client = pymongo.MongoClient("mongodb+srv://admin:soum123@cluster0.5w7mucc.mongodb.net/?retryWrites=true&w=majority")
db = client.soum
collection = db['soum-collection']


s3 = boto3.client('s3',
                    aws_access_key_id=os.getenv('AWS_ACCESS_KEY'),
                    aws_secret_access_key= os.getenv('AWS_SECRET_ACCESS_KEY')
                     )
# s3 = boto3.session.Session(profile_name=os.getenv('AWS_PROFILE'))

BUCKET_NAME=os.getenv('AWS_BUCKET_NAME')

@app.route('/')  
def home():
    return render_template("upload.html")

@app.route('/upload',methods=['post'])
def upload():
    if request.method == 'POST':
        img = request.files['file']
        if img:
                filename = secure_filename(img.filename)
                img.save(filename)
                s3.upload_file(
                    Bucket = BUCKET_NAME,
                    Filename=filename,
                    Key = filename   
                )
                
                location = boto3.client('s3').get_bucket_location(Bucket=BUCKET_NAME)['LocationConstraint']
                # Creating URL 
                url = "https://%s.s3.%s.amazonaws.com/%s" % (BUCKET_NAME, location, filename)
                msg = url
                db_insert = {
                    "name": BUCKET_NAME,
                    "url": msg
                }
                add_collection = collection.insert_one(db_insert)
                print(add_collection)

    return render_template("upload.html",msg =msg)


if __name__ == "__main__":
    # upload()
    app.run(host='0.0.0.0')
