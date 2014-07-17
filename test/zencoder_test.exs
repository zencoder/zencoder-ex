defmodule ZencoderTest do
  use ExUnit.Case

  setup context do

    if env_api_key = context[:env_api_key] do
      System.put_env("ZENCODER_API_KEY", env_api_key)
    end

    if env_url = context[:env_url] do
      System.put_env("ZENCODER_BASE_URL", env_url)
    end

    if env_timeout = context[:env_timeout] do
      System.put_env("ZENCODER_TIMEOUT", env_timeout)
    end

    on_exit fn ->
      Zencoder.api_key(nil)
      Zencoder.base_url(nil)
      Zencoder.timeout(nil)
      System.delete_env("ZENCODER_API_KEY")
      System.delete_env("ZENCODER_BASE_URL")
      System.delete_env("ZENCODER_TIMEOUT")
    end

    :ok
  end

  test "gets default base_url" do
    assert "https://app.zencoder.com/api/v2" == Zencoder.base_url
  end

  @tag env_url: "https://app.zencoder.com/api/v1"
  test "gets base_url from environment" do
    assert "https://app.zencoder.com/api/v1" == Zencoder.base_url
  end

  test "sets base_url" do
    assert "https://app.zencoder.com/api/v2" == Zencoder.base_url
    Zencoder.base_url "http://example.com"
    assert "http://example.com" == Zencoder.base_url
  end

  @tag env_api_key: "some-api-key"
  test "gets api_key from environment" do
    assert "some-api-key" == Zencoder.api_key
  end

  test "sets api_key" do
    assert nil == Zencoder.api_key
    Zencoder.api_key "api-key"
    assert "api-key" == Zencoder.api_key
  end

  test "gets default timeout" do
    assert 30000 == Zencoder.timeout
  end

  @tag env_timeout: "60000"
  test "gets timeout from environment" do
    assert 60000 == Zencoder.timeout
  end

  test "sets timeout" do
    assert 30000 == Zencoder.timeout
    Zencoder.timeout 60000
    assert 60000 == Zencoder.timeout
  end

end
