defmodule Zencoder.Input do
  import Zencoder.Resource

  def details(input_id, options \\ %{}) do
    get("/inputs/#{input_id}", options)
  end

  def progress(input_id, options \\ %{}) do
    get("/inputs/#{input_id}/progress", options)
  end

end
