# Formin 

Simple HTML form input handler.  The daemon process listens for HTML form
inputs, converts the form data to JSON, then writes the data to an output
channel.

| Output Channel Options | Description       |
|------------------------|-------------------|
| logfile `path`         | NDJSON log file   |
| tcp `server:port`      | TCP service       |
| fifo `path`            | Unix named pipe   |
| socket `path`          | Unix socket       |
| amqp `host:port/queue` | RabbitMQ Exchange |


