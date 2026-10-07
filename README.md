# Moon Stack 🌙

Moon Stack is a stack, not a framework.

It doesn't reinvent routing, databases, styling, or HTTP.

It brings together tools that already do those jobs well and provides a convenient starting point for Ruby web apps.

Use what you want. Replace what you don't.

Happy hacking under the moon 🌙

## Stack

- Ruby
- Sinatra
- Rack
- Puma
- Sequel
- SQLite (you can also use postgresql and mysql)
- ERB
- htmx
- Tailwind CSS

## Install

```bash
gem install moon-stack
```

## Create an app

```bash
# domyślnie SQLite
moon new myapp

# PostgreSQL
moon new myapp --database=postgresql

# MySQL
moon new myapp --database=mysql
cd myapp
bundle install
bundle exec puma
```

Then open:

```text
http://localhost:6767
```

## Philosophy

Moon Stack generates normal Ruby files.

There is no Moon runtime.

Once your app has been generated, Moon Stack is no longer required.

Replace anything you want.
