defmodule Zencoder.Resource do
  alias Zencoder.Response
  use Jazz

  def get(url, options) do
    Response.process fn ->
      HTTPotion.get("#{Zencoder.base_url}#{url}#{params(options)}", headers(options), [{:timeout, timeout(options)}])
    end
  end

  def post(url, options) do
    Response.process fn ->
      HTTPotion.post("#{Zencoder.base_url}#{url}", body(options), headers(options), [{:timeout, timeout(options)}])
    end
  end

  def put(url, options) do
    Response.process fn ->
      HTTPotion.put("#{Zencoder.base_url}#{url}", body(options), headers(options), [{:timeout, timeout(options)}])
    end
  end

  def headers(options) do
    [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"},
      {"Zencoder-Api-Key", options[:api_key] || Zencoder.api_key},
      {"User-Agent", "Zencoder-Elixir v#{Zencoder.Mixfile.project[:version]}"}
    ]
  end

  def body(%{} = options) when map_size(options) == 0, do: ""
  def body(%{} = options) do
    options
    |> Map.delete(:api_key)
    |> Map.delete(:timeout)
    |> JSON.encode!
  end

  def params(%{} = options) do
    options
    |> Map.delete(:api_key)
    |> Map.delete(:timeout)
    |> URI.encode_query
    |> params
  end
  def params(""),     do: ""
  def params(params), do: "?#{params}"

  def timeout(%{timeout: timeout} = _options), do: timeout
  def timeout(_options), do: Zencoder.timeout

end
