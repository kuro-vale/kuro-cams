defmodule KuroCams.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KuroCams.Accounts` context.
  """

  def unique_user_username, do: "user#{System.unique_integer([:positive])}"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      username: unique_user_username(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> KuroCams.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_username} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_username.text_body, "[TOKEN]")
    token
  end
end
