Whassup
=======

Whassup is a library for setting up and performing uptime checks.

While there are a number of robust, subscription-based offerings for 
uptime monitoring, Whassup aims to be a basic, open-source alternative.
It is useful for running periodic checks of application end-points
and sending notifications when downtime occurs.

It is comprised of three parts:

1. A Ruby library for exposing uptime end-points from an applicaiton
2. A Rake task for starting a worker to perform checks and send notifications
3. A Sinatra app for managing checks and notifications
4. A status bar application for Mac users

Whassup currently supports the following check types:

1. HTTP(S)
2. TCP port
3. Ping
4. DNS
5. UDP
6. SMTP
7. POP3
8. IMAP

Emails notifications can be configured to be sent to any number of contacts 
based on how long the site/server has to be down before alerts are sent. 

The Whassup frontend displays the current and historical status of uptime checks,
provides an interface for adding and editing checks and contacts for receiving 
notifications.
