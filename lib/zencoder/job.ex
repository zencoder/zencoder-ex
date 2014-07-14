defmodule Zencoder.Job do
  import Zencoder.Resource

  def create(options) do
    post("/jobs", options)
  end

  def list(options \\ %{}) do
    options = options
             |> update_in([:page],     &(&1 || 1))
             |> update_in([:per_page], &(&1 || 50))
    get("/jobs", options)
  end

  def details(job_id, options \\ %{}) do
    get("/jobs/#{job_id}", options)
  end

  def progress(job_id, options \\ %{}) do
    get("/jobs/#{job_id}/progress", options)
  end

  def resubmit(job_id, options \\ %{}) do
    put("/jobs/#{job_id}/resubmit", options)
  end

  def cancel(job_id, options \\ %{}) do
    put("/jobs/#{job_id}/cancel", options)
  end

  def finish(job_id, options \\ %{}) do
    put("/jobs/#{job_id}/finish", options)
  end

end



# Zencoder.Job.create(%{test: true, input: "http://s3.amazonaws.com/zencodertesting/test.mov"})

