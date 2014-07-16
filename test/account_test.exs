defmodule AccountTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "account creation" do
    use_cassette "account_create" do
      assert "new-api-key" == Zencoder.Account.create(%{email: "zencoder@example.com", terms_of_service: 1}).body[:api_key]
    end
  end

  test "account details" do
    use_cassette "account_details" do
      assert "Launch" == Zencoder.Account.details.body[:plan]
    end
  end

  test "account integration" do
    use_cassette "account_integration" do
      assert 204 == Zencoder.Account.integration.code
    end
  end

  test "account live" do
    use_cassette "account_live" do
      assert 204 == Zencoder.Account.live.code
    end
  end

end
