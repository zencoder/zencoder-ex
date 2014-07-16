defmodule Zencoder.Account do
  import Zencoder.Resource

  def create(options) do
    post("/account", options)
  end

  def details(options \\ %{}) do
    get("/account", options)
  end

  def integration(options \\ %{}) do
    put("/account/integration", options)
  end

  def live(options \\ %{}) do
    put("/account/live", options)
  end

end
