defmodule Zencoder.Output do
  import Zencoder.Resource

  def details(output_id, options \\ %{}) do
    get("/outputs/#{output_id}", options)
  end

  def progress(output_id, options \\ %{}) do
    get("/outputs/#{output_id}/progress", options)
  end

end
