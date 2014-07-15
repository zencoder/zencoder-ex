defmodule Zencoder.Report do
  import Zencoder.Resource

  def all(options \\ %{}) do
    get("/reports/all", options)
  end

  def live(options \\ %{}) do
    get("/reports/live", options)
  end

  def vod(options \\ %{}) do
    get("/reports/vod", options)
  end

end
