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

#Building and configuring the plugin 
Note that in order to compile the plugin
you will require a copy of the Mosquitto source code and you must also have
OpenSSL and the cURL Development kit installed (see http://curl.haxx.se/) in
order to build the plugin. Assuming this to be the case, building the plugin
should be straightforward:

    git clone https://github.com/nippelapp/mosquitto_auth_plugin_http
    cd mosquitto_auth_plugin_keystone

Now edit `makefile` and modify the include path (`INC`) as appropriate so that
the compiler can find the Mosquitto header files, or specify existing BUILD_DIR
and MOSQUITTO_VERSION directly:

    BUILD_DIR=/build MOSQUITTO_VERSION=1.4.8 make

By default we're assuming that if anyone can log in then can do all sorts of stuff.
If your Mosquitto use an additional procedure to check the ACL's, 
it may be necessary to always return `false` when ACL checking:

    BUILD_DIR=/build MOSQUITTO_VERSION=1.4.8 make CFLAGS+=-DMQAP_ACL_DENY

You should now have mosquitto_auth_plugin_http.so.

To configure the plugin, copy the shared library
(`mosquitto_auth_plugin_http.so`) to somewhere sensible and edit your
Mosquitto configuration file to include the following details, modifying the
URL and proxy address as appropriate:

Note that specifying a proxy server is optional, and if no URL is specified for
the Keystone Identity service, then as currebntly coded the plugin will attempt
to use the service provided by HP Cloud (http://www.hpcloud.com).

    # Authentication plugin (specify path to UNIX shared library or OpenVMS
    # shareable image)
    auth_plugin /etc/mosquitto/mosquitto_auth_plugin_http.so

    # Keystone identity service URI and proxy server details (if you go through a
    # proxy)
    auth_opt_keystone_uri https://exapmle.com/mqtt
    auth_opt_http_proxy 10.1.1.1:8080

You might also wish to set `allow_anonymous` to `false` in your configuration
file to disable anonymous (unathenticated) logins. It is probably also a good
idea for testing purposes to initially compile the plugin with `MQAP_DEBUG`
defined, as this will cause messages to be written to the brokers' `stderr`
about the operation of the plugin.

#Versions 
=========
This version of the code has been tested with Mosquitto 1.4.8.
=========
The previous tagged keystone version of the code has been tested with Mosquitto
1.1.3; however it should work with 1.2. Testing was done using HP Cloud
(http://www.hpcloud.com); some tweaks might be required for other OpenStack
deployments. The plugin has also be tested on HP OpenVMS Integrity using an OpenVMS port of Mosquitto 1.1.3.

