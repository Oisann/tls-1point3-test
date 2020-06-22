# TLS 1.3 Test

A test web server that only accepts TLS 1.3.

## Paths

- `/` is a basic check to see if your application can talk to the server. It just returns a basic text response.
- `/content` will serve a custom file. If the file is not present, the server will crash. I recommend `--restart=always`
