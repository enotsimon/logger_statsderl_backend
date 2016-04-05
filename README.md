# logger_statsderl_backend

## overwiev

backend for Logger that sends counters to graphite using statsderl


## install

add

`{:logger_statsderl_backend, git: "https://github.com/enotsimon/logger_statsderl_backend.git", branch: "master"}`

to your `mix.exs` file in `deps()` section


## usage

add to your config files something like this

```
config :logger,
  level: :info,
  backends: [LoggerStatsderlBackend]

config :logger, LoggerStatsderlBackend,
  level: :warn
```

