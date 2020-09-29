defmodule Zencoder.Resource do
  alias Zencoder.Response

  def get(url, options) do
    Response.process fn ->
      HTTPotion.get("#{Zencoder.base_url}#{url}#{params(options)}", [headers: headers(options), timeout: timeout(options)])
    end
  end

  def post(url, options) do
    Response.process fn ->
      HTTPotion.post("#{Zencoder.base_url}#{url}", [headers: headers(options), body: body(options), timeout: timeout(options)])
    end
  end

  def put(url, options) do
    Response.process fn ->
      HTTPotion.put("#{Zencoder.base_url}#{url}", [headers: headers(options), body: body(options), timeout: timeout(options)])
    end
  end

  def headers(options) do
    {:ok, version} = :application.get_key(:zencoder, :vsn)

    [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"},
      {"Zencoder-Api-Key", options[:api_key] || Zencoder.api_key},
      {"User-Agent", "Zencoder-Elixir v#{version}"}
    ]
  end

  def body(%{} = options) when map_size(options) == 0, do: ""
  def body(%{} = options) do
    options
    |> Map.delete(:api_key)
    |> Map.delete(:timeout)
    |> Jason.encode!
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
