defmodule Zencoder do
  use Application

  def start(_type, _args) do
    Zencoder.Supervisor.start_link
  end
end
