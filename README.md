# Execd 

Simple HTML form handler. 

This daemon process listens for an HTML form post, then runs a script on the
server to process the form data.

The script can be any executable program: a binary executable, or a script
written in Bash, Elixir, Ruby, Python etc.

To start the server: 
- 1) `mix execd.server "echo HI"`
- 2) `mix execd.server "echo HI > /tmp/myfile.txt"`
- 3) `mix execd.server "echo '@data' > /tmp/myfile.txt"` 

Now the server listens for form data at POST:/submit.

The @data placeholder will be replaced by form data encoded as JSON.

