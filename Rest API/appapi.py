from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy 
from flask_marshmallow import Marshmallow 
import os
import keras
from keras.models import load_model

app = Flask(__name__)

#model = load_model('plate_char_recognition.h5')

basedir = os.path.abspath(os.path.dirname(__file__))
# Database
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'database.sqlite')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
# Init db
db = SQLAlchemy(app)
# Init ma
ma = Marshmallow(app)

class Registration(db.Model):
    __tablename__ = 'registrations'
    id = db.Column(db.Integer, unique_key = True, primary_key = True)
    plate_num = db.Column(db.String(50), unique = True)
    owner = db.Column(db.String(100))
    maker_model = db.Column(db.String(200))
    vehicle_class = db.Column(db.String(100))
    age = db.Column(db.Integer)
    dl_number = db.Column(db.String(50), unique = True)
    address = db.Column(db.String(200))

    def __init__(self, plate_num, owner, maker_model, vehicle_class, age, dl_number, address):
        self.plate_num = plate_num
        self.owner = owner
        self.maker_model = maker_model
        self.vehicle_class = vehicle_class
        self.age = age
        self.dl_number = dl_number
        self.address = address

# Register Schema
class RegisterSchema(ma.Schema):
    class Meta:
        fields = ('id', 'plate_num', 'owner', 'maker_model', 'vehicle_class', 'age', 'dl_number', 'address')

# Init schema
register_schema = RegisterSchema()
registers_schema = RegisterSchema(many = True)

# Create a Registration
@app.route('/registration', methods = ['POST'])
def add_registration():
    plate_num = request.json['plate_num']
    owner = request.json['owner']
    maker_model = request.json['maker_model']
    vehicle_class = request.json['vehicle_class']
    age = request.json['age']
    dl_number = request.json['dl_number']
    address = request.json['address']

    new_registration = Registration(plate_num, owner, maker_model, vehicle_class, age, dl_number, address)

    db.session.add(new_registration)
    db.session.commit()

    return register_schema.jsonify(new_registration)

# Get All Registrations
@app.route('/registration',methods=['GET'])
def get_registrations():
    all_registrations = Registration.query.all()
    result = registers_schema.dump(all_registrations)
    return jsonify(result)

# Get Single Registrations
@app.route('/registration/<id>',methods=['GET'])
def get_registration(id):
    registration = Registration.query.get(id)
    return register_schema.jsonify(registration)

# Update a Registration
@app.route('/registration/<id>',methods=['PUT'])
def update_registration(id):
    registration = Registration.query.get(id)

    plate_num = request.json['plate_num']
    owner = request.json['owner']
    maker_model = request.json['maker_model']
    vehicle_class = request.json['vehicle_class']
    age = request.json['age']
    dl_number = request.json['dl_number']
    address = request.json['address']

    registration.plate_num = plate_num
    registration.owner = owner
    registration.maker_model = maker_model
    registration.vehicle_class = vehicle_class
    registration.age = age
    registration.dl_number = dl_number
    registration.address = address

    db.session.commit()

    return register_schema.jsonify(registration)

# Delete registration
@app.route('/registration/<id>',methods=['DELETE'])
def delete_registration(id):
    registration = Registration.query.get(id)
    db.session.delete(registration)
    Session.query(table).filter_by(userid=user).delete(synchronize_session='fetch')
    db.session.commit()
    return register_schema.jsonify(registration)


if __name__ == '__main__':
    app.debug = True
    app.run()



