## Mailpile Docker Data Volume

This is a simple data volume for substituting data storage inside of a [Mailpile Docker Container](https://github.com/pagekite/Mailpile/blob/master/Dockerfile).

### Usage

Change to a directory where you keep your git repositories, i.e.

```
cd /usr/src
```

Clone the **Mailpile** and **docker-mailpile-data** repositories:

```
git clone https://github.com/pagekite/Mailpile.git mailpile-daemon
git clone https://github.com/almereyda/docker-mailpile-data.git mailpile-data
```

Then build the respective docker images.

```
cd mailpile-daemon && \
  docker build -t mailpile:daemon && \
  cd .. && \
  cd mailpile-data && \
  docker build -t mailpile:data
```

Finally run the `mailpile:data` image to create a data-only `mailpile_data` container which is linked with a newly created `mailpile_daemon` container based on the `mailpile:daemon` image created above.

```
docker run --name="mailpile_data" mailpile:data
docker run --name="mailpile_daemon" --volumes-from="mailpile_data" -d -p 127.0.0.1:33411:33411 mailpile:daemon
```

**Mailpile** is now running!

* If you ran this process on your local machine, start a browser and navigate to `http://localhost:33411` to use it.
* If you ran this process on a webserver, create a TLS-secured reverse proxy rule to make sure passwords are not transferred in plain text.
* You can omit the `127.0.0.1:` characters, if you know what you are doing.

### Further maintenance

You can inspect the data volume from an external container.

```
docker run -it --volumes-from="mailpile_data" busybox:latest /bin/sh
```

An alternative approach to inspect running containers is [`nsenter`](https://blog.docker.com/tag/nsenter/).

Backing up docker data-volume-only containers is a completely different topic, that cannot be taken care of here.

## Closing notes

I am not completely sure if it works in the end, as running a new `mailpile_daemon` linked to an existing data only container shows an empty mailbox first; but the keyphrase is retained.
So probably checking the mail sources locally and fetching new mail remotely is just not sufficently represented in the **Mail Sources** dialogue.

### Licence

```
The MIT License (MIT)

Copyright (c) 2014 Jon Richter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
