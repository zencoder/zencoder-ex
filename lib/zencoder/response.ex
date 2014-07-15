defmodule Zencoder.Response do
  defstruct body: nil, success?: nil, raw_body: nil, code: nil, headers: nil, errors: nil

  use Jazz

  def process(response) do
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

  def process_body(nil), do: %{}
  def process_body(raw_body) when byte_size(raw_body) == 0, do: %{}
  def process_body(raw_body), do: JSON.decode!(raw_body, keys: :atoms)

  def process_errors(nil), do: []
  def process_errors(errors), do: errors
end
