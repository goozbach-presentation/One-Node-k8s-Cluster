#!/usr/bin/env python

from flask import Flask, jsonify

app = Flask(__name__)

mydoors = ['front', 'back', 'side']

@app.route('/api/v0.1/ring_chime/<string:door>', methods=["Get"])

def ring_chime(door):
    print door
    if door not in mydoors:
        retobj = { 'status': 'fail', 'msg': 'door does not exist', 'door': door}
    else:
        retobj = { 'status': 'success', 'ringing': door }
    return jsonify(retobj)

if __name__ == '__main__':
    app.run(debug=True)
