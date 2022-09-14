defmodule KuroCams.Repo do
  use Ecto.Repo,
    otp_app: :kuro_cams,
    adapter: Ecto.Adapters.Postgres
end
