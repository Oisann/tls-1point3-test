# TLS 1.3 Test

A test web server that only accepts TLS 1.3.

## Paths

- `/` is a basic check to see if your application can talk to the server. It just returns a basic text response.
- `/content` will serve a custom file.

## Custom content file

The `/content` path will look for a file in `./files/` named `content` and serve that.
If it isn't there, the server will panic.
You can use `--restart=always` to restart the image automatically.

## Self-signed certificate

The server comes with a self-signed certificate. This can easily be updated by changing out the files in `./certs/`, just make sure to keep the names the same.
