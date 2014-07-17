defmodule Zencoder do
  use Application
  alias Zencoder.Config

  def start(_type, _args) do
    Zencoder.Supervisor.start_link
  end

  def api_key do
    Config.api_key || System.get_env("ZENCODER_API_KEY")
  end

  def api_key(key) do
    Config.api_key(key)
  end

  def base_url do
    Config.base_url || System.get_env("ZENCODER_BASE_URL") || "https://app.zencoder.com/api/v2"
  end

  def base_url(url) do
    Config.base_url(url)
  end

  def timeout do
    Config.timeout || env_timeout(System.get_env("ZENCODER_TIMEOUT")) || 30000
  end

  def timeout(time_in_ms) do
    Config.timeout(time_in_ms)
  end

  defp env_timeout(timeout) when is_binary(timeout), do: String.to_integer(timeout)
  defp env_timeout(timeout), do: timeout
end
