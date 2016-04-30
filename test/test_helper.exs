ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Chowmonger.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Chowmonger.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Chowmonger.Repo)

