mosquitto-auth-plugin-http
==============================

#Overview
A simple authetication plugin for the Mosquitto MQTT broker (http://mosquitto.org) that
provides the ability for the broker to authenticate users using the HTTP or
HTTPS authorization service. In its present form the plugin verifies
only that valid username and password credentials have been supplied; 

We are currently using Json POST request to server structure:
     {"username":"user", "password":"secret"}

It does nothing to control what authenticated users can and cannot do once they are
connected to the broker.

This code was forked against an original Keystone Identity service plugin from
https://github.com/brc859844/mosquitto-auth-plugin-keystone 
