defmodule Zencoder.Response do
  defstruct body: nil, success?: nil, raw_body: nil, code: nil, headers: nil, errors: nil

  def process(request) do
    try do
      process_response request.()
    catch
      kind, error ->
        Zencoder.Error.process(kind, error)
    end
  end

  def process_response(response) do
    body = response.body
           |> String.strip
           |> process_body

    %__MODULE__ {
      body: body,
      success?: HTTPotion.Response.success?(response),
      code: response.status_code,
      headers: response.headers,
      raw_body: response.body,
      errors: process_errors(body[:errors])
    }
  end

  def process_body(raw_body) when byte_size(raw_body) == 0, do: %{}
  def process_body(raw_body), do: Poison.decode!(raw_body, keys: :atoms)

  def process_errors(nil), do: []
  def process_errors(errors), do: errors
end
