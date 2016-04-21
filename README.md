# osquery-tls-server

## Why do you want this

If you're running `osquery` you may want an easy-to-manage way of delivering
configuration file updates to the osquery process on your running servers. This
software provides a TLS server that delivers configuration to osquery and also
allows you to roll out new configs to small samples of servers to make sure that
the new config does not cause problem before deploying to all machines.

## Getting started

To run the server run the following commands. The first two commands should only
need to be run once

```
bundle install
rake db:setup
rails server
```

If you want to use the faster puma server you can run the app with this command:

```
puma -C puma.rb
```

## Compatibility

This has been tested most recently against osquery version 1.6.0

## Configuring osqueryd

The easiest way to configure osqueryd is to put your command line options
into a flag file. By default on linux systems, osqueryd will look for
`/etc/osquery/osquery.flags` You need to have the following options set there
for osqueryd to look to your server.

```
--tls_hostname=dns.name.of.your.server.with.no.https.on.the.front.com
--config_plugin=tls
--config_tls_endpoint=/api/v1/config
--config_tls_refresh=14400
--enroll_tls_endpoint=/api/enroll
--enroll_secret_path=/etc/osquery/osquery.secret
```

The lines above seem to be the minimum necessary to make osquery pull config
from a TLS endpoint. You will need to populate the `/etc/osqueryd/osqueryd.secret`
file with the value of your NODE_ENROLL_SECRET environment variable. Additional
lines that you may include in your osquery.flags file include:

```
--database_path=/var/osquery/osquery.db
--schedule_splay_percent=10
--logger_plugin=syslog
--logger_syslog_facility=3
--log_results_events=true
--verbose
```

Then you can start osqueryd (on linux) with a simple `/etc/init.d/osqueryd start`
or `service start osqueryd`

### API Authentication

If you've logged into the windmill server you can create api keys with either
read or read/write permission. The resulting key must be passed with every
api call as an http header called Authentication. For example, using curl you
could get a list of configuration groups with this command:

```
curl http://localhost:3000/api/v1/status -H 'Authorization: Token token="2f85240abb627ff45545a1b57715a09de4a23b2f02dac0713348a0939551b37d"'
```

A key with write permission is necessary for any request
that doesn't use the GET method.

## Enrolling osquery endpoints

The osquery endpoints will reach out to the TLS server and send a POST to
`/api/enroll` with a `enroll_secret` value that it read from it's own filesystem
(`/etc/osquery/osquery.secret` if you followed the `osquery.flags` file above).
The value in that file must match the node secret being used by the TLS server
and specify a configuration group. The TLS server takes node secret value from
an environment variable named NODE_ENROLL_SECRET. If you have not set that
variable then it defaults to "valid_test".

If the server sends a valid node_secret then it will be enrolled and joined to
the configuration group that was specified. The endpoint will receive a node key
that it can use to pull its configuration from the server.

You can also store a host identifier for osquery endpoints by adding a host
identifier to the front of the group label and enroll secret stored in
`/etc/osquery/osquery.secret`. The values are separated by a colon.

### Example osquery.secret

 `www-1:web:bigrandomstringofcharactersforthewin`

That will label the endpoint with an identifier of `www-1` and join it to the
`web` configuration group. From that point on it will receive the configuration
file that the `web` configuration group assigns to that endpoint.

If you enroll an endpoint with an invalid configuration group name or a missing
configuration group name it will be added to the `default` configuration group.

## Serving configuration files

Configuration files are kept in a database and are assigned to endpoints by the
configuration group to which they belong. When the application is initialized a
configuration group named `default` is created automatically and a default
configuration file is added to that group.

Additional configuration groups and configuration files can be added by pointing
your browser at the root of the application. There you will find a GUI for
adding new configuration groups and new configuration files.

After an endpoint is enrolled it will make a POST request to /api/config and
provide the node secret it was given when it enrolled. The Windmill server will
look up that node secret and find the configuration file that is assigned to
that endpoint and provide that back to the endpoint.

## Helpful links

* The reference implementation in python: https://github.com/facebook/osquery/blob/master/tools/tests/test_http_server.py
* The documentation: https://github.com/facebook/osquery/blob/master/docs/wiki/deployment/remote.md

## Running tests

The tests are written in RSpec.

## Command-line utilities
Windmill comes with one command-line utility: `endpoint-cleanup`.

### endpoint-cleanup
The `endpoint-cleanup` utility deletes endpoints that have not polled for their configuration recently.  This can be useful if hosts in your infrastructure frequently come and go.  It is not strictly necessary to delete old endpoints, but doing so can make the Windmill UI easier to manage.

Run the `endpoint-cleanup` utility like this:
```
heroku run bundle exec bin/endpoint-cleanup --help
```

With no arguments, this utility will **automatically** purge all endpoints that have not checked in within the past day, without confirmation.  The `-i` option prompts you for confirmation and allows you to view a list of endpoints that will be deleted.

If desired, this utility is designed to be run in non-interactive mode using Heroku Scheduler or a similar scheduling add-on.

