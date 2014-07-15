defmodule Zencoder.Resource do
  alias Zencoder.Response
  use Jazz

  def get(url, options) do
    Response.process HTTPotion.get("#{Zencoder.base_url}#{url}#{params(options)}", headers(options))
  end

  def post(url, options) do
    Response.process HTTPotion.post("#{Zencoder.base_url}#{url}", body(options), headers(options))
  end

  def put(url, options) do
    Response.process HTTPotion.put("#{Zencoder.base_url}#{url}", body(options), headers(options))
  end

  def headers(options) do
    [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"},
      {"Zencoder-Api-Key", options[:api_key] || Zencoder.api_key}
    ]
  end

  def body(%{} = options) when map_size(options) == 0, do: ""
  def body(%{api_key: _} = options) do
    options
    |> Map.delete(:api_key)
    |> body
  end
  def body(options), do: JSON.encode!(options)

  def params(%{} = options) do
    params = options
             |> Map.delete(:api_key)
             |> URI.encode_query
             |> params
  end
  def params(""),     do: ""
  def params(params), do: "?#{params}"

end
