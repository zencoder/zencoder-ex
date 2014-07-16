defmodule OutputTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "output details" do
    use_cassette "output_details" do
      assert 1280 == Zencoder.Output.details(1234).body[:width]
    end
  end

  test "output progress" do
    use_cassette "output_progress" do
      assert "finished" == Zencoder.Output.progress(1234).body[:state]
    end
  end

end
