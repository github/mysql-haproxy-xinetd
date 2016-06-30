# mysql-haproxy-xinetd

This repository contains sample config files and scripts used for setting up a context aware MySQL replication pool on HAProxy.

A context aware pool is a pool of backend MySQL servers, such that each _tells_ HAproxy whether it should be included in the pool or not.

HAProxy-wise, the pool is fixed, and MySQL server state changes are not reflected in its config. This setup is resilient to `service haproxy reload/restart`.

A backend server is able to tell HAProxy:

- I'm good to participate in a pool (`HTTP 200`)
- I'm in bad state; don't send traffic my way (`HTTP 503`)
- I'm in maintenance mode. No error on my side, but don't send traffic my way (`HTTP 404`)

The servers respond to an explicit request (check) type sent by HAProxy, such as `/check-lag` or `/ignore-lag`.

HAProxy uses a `main` backend pool and a `backup` backend pool, such that the `backup` pool is activated when the `main` pool runs out of capacity. HAProxy uses different check types for the two pools.
