defmodule ReportTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "all" do
    use_cassette "report_all" do
      assert 0 == Zencoder.Report.all.body[:total][:live][:stream_minutes]
    end
  end

  test "live" do
    use_cassette "report_live" do
      assert 0 == Zencoder.Report.live.body[:total][:stream_minutes]
    end
  end

  test "vod" do
    use_cassette "report_vod" do
      assert 0 == Zencoder.Report.vod.body[:total][:encoded_minutes]
    end
  end

end
