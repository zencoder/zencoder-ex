defmodule Zencoder do
  use Application
  alias Zencoder.Config

  def start(_type, _args) do
    Zencoder.Supervisor.start_link
  end

  def base_url do
    Config.base_url || System.get_env("ZENCODER_BASE_URL") || "https://app.zencoder.com/api/v2"
  end

  def base_url(url) do
    Config.base_url(url)
  end

  def api_key do
    Config.api_key || System.get_env("ZENCODER_API_KEY")
  end

  def api_key(key) do
    Config.api_key(key)
  end

end
