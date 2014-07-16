defmodule ResponseTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "error handling" do
    use_cassette "on_error" do
      assert :error == Zencoder.Job.cancel(1234, %{api_key: "api-key"}).kind
    end
  end

end
