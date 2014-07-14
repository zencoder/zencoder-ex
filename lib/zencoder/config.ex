defmodule Zencoder.Config do
  use GenServer


  #############
  # Client API

  def base_url do
    GenServer.call(:zencoder_config, :get_base_url)
  end

  def base_url(url) do
    GenServer.cast(:zencoder_config, {:set_base_url, url})
  end

  def api_key do
    GenServer.call(:zencoder_config, :get_api_key)
  end

  def api_key(api_key) do
    GenServer.cast(:zencoder_config, {:set_api_key, api_key})
  end


  ###################
  # Server Callbacks

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :zencoder_config)
  end

  def init(config) do
    {:ok, config}
  end

  def handle_call(:get_base_url, _from, config) do
    {:reply, config[:base_url], config}
  end

  def handle_call(:get_api_key, _from, config) do
    {:reply, config[:api_key], config}
  end

  def handle_cast({:set_base_url, url}, config) do
    {:noreply, Map.put(config, :base_url, url)}
  end

  def handle_cast({:set_api_key, api_key}, config) do
    {:noreply, Map.put(config, :api_key, api_key)}
  end


end