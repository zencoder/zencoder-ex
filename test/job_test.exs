defmodule JobTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "job creation" do
    use_cassette "job_create" do
      assert 1234 == Zencoder.Job.create(%{
                       test: true,
                       input: "http://s3.amazonaws.com/zencodertesting/test.mov"
                     }).body[:id]
    end
  end

  test "job listing" do
    use_cassette "job_list" do
      assert 10 == Zencoder.Job.list(%{page: 1, per_page: 10}).body |> length
    end
  end

  test "job details" do
    use_cassette "job_details" do
      assert "2014-07-16T03:31:41Z" == Zencoder.Job.details(1234).body[:job][:created_at]
    end
  end

  test "job progress" do
    use_cassette "job_progress" do
      assert "finished" == Zencoder.Job.progress(1234).body[:state]
    end
  end

  test "job resubmission" do
    use_cassette "job_resubmission" do
      assert 204 == Zencoder.Job.resubmit(1234).code
    end
  end

  test "job cancellation" do
    use_cassette "job_cancellation" do
      assert 204 == Zencoder.Job.cancel(1234).code
    end
  end

  test "job finish" do
    use_cassette "job_finish" do
      response = Zencoder.Job.finish(103923454)
      assert 409 == response.code
      assert ["Only Live streaming jobs can be finished."] == response.errors
    end
  end

end
