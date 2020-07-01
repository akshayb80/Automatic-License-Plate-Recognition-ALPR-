from flask import Flask
from flask_restful import Resource, Api, reqparse

app = Flask(__name__)
api = Api(app)

REGISTRATIONS = {
    '1': {'owner name': 'Akshay Bakshi',
            'Maker model': 'Cadilac Escalade Year 2019',
            'Vehicle class': 'SUV', 
            'age': 19, 
            'DL number': 12345678,
            'address': '9611 W Hampton Avenue',
            },
    '2': {'owner name': 'Nikhil Sharma',
            'Maker model': 'Buick Enclave Year 2019',
            'Vehicle class': 'SUV', 
            'age': 19, 
            'DL number': 87654321,
            'address': '9617 W Hampton Avenue',
            },
    '3': {'owner name': 'Vivek',
            'Maker model': 'Honda Civic Year 2019',
            'Vehicle class': 'Car', 
            'age': 19, 
            'DL number': 123789456,
            'address': '9627 W Hampton Avenue',
            },
    '4': {'owner name': 'Shivam',
            'Maker model': 'Nissan Altima Year 2019',
            'Vehicle class': 'Car', 
            'age': 19, 
            'DL number': 456123789,
            'address': '9637 W Hampton Avenue',
            },
}

parser = reqparse.RequestParser()

class RegisterList(Resource):
    def get(self):
        return REGISTRATIONS

    def post(self):
        parser.add_argument("owner name")
        parser.add_argument("Maker model")
        parser.add_argument("Vehicle class")
        parser.add_argument("age")
        parser.add_argument("DL number")
        parser.add_argument("address")
        args = parser.parse_args()
        plate_id = int(max(REGISTRATIONS.keys())) + 1
        plate_id = '%i' % plate_id
        REGISTRATIONS[plate_id] = {
            "owner name": args["owner name"],
            "Maker model": args["Maker model"],
            "Vehicle class": args["Vehicle class"],
            "age": args["age"],
            "DL number": args["DL number"],
            "address": args["address"],
        }
        return REGISTRATIONS[plate_id], 201


class Registration(Resource):
    def get(self, plate_id):
        if plate_id not in REGISTRATIONS:
            return "Not found", 404
        else:
            return REGISTRATIONS[plate_id]

    def put(self, plate_id):
        parser.add_argument("owner name")
        parser.add_argument("Maker model")
        parser.add_argument("Vehicle class")
        parser.add_argument("age")
        parser.add_argument("DL number")
        parser.add_argument("address")
        args = parser.parse_args()
        if plate_id not in REGISTRATIONS:
            return "Record not found", 404
        else:
            registration = REGISTRATIONS[plate_id]
            registration["owner name"] = args["owner name"] if args["owner name"] is not None else registration["owner name"]
            registration["Maker model"] = args["Maker model"] if args["Maker model"] is not None else registration["Maker model"]
            registration["Vehicle class"] = args["Vehicle class"] if args["Vehicle class"] is not None else registration["Vehicle class"]
            registration["age"] = args["age"] if args["age"] is not None else registration["age"]
            registration["DL number"] = args["DL number"] if args["DL number"] is not None else registration["DL number"]
            registration["address"] = args["address"] if args["address"] is not None else registration["address"]
            return registration, 200

    def delete(self, plate_id):
        if plate_id not in REGISTRATIONS:
            return "Not found", 404
        else:
            del REGISTRATIONS[plate_id]
            return '', 204

api.add_resource(RegisterList, '/registrations/')
api.add_resource(Registration, '/registrations/<plate_id>')


if __name__ == "__main__":
  app.run(debug=True)



