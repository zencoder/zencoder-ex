defmodule InputTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "input details" do
    use_cassette "input_details" do
      assert 1280 == Zencoder.Input.details(1234).body[:width]
    end
  end

  test "input progress" do
    use_cassette "input_progress" do
      assert "finished" == Zencoder.Input.progress(1234).body[:state]
    end
  end

end
