defmodule FoundIt.Repo do
  use Ecto.Repo,
    otp_app: :found_it,
    adapter: Ecto.Adapters.Postgres
end
