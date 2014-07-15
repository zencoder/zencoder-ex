# Zencoder

[![Build Status](https://travis-ci.org/zencoder/zencoder-ex.svg?branch=master)](https://travis-ci.org/zencoder/zencoder-ex)

An Elixir library for interacting with the [Zencoder](http://zencoder.com) API.

Requires Elixir ~> 0.14.3

### Installation

Install the [Hex.pm](http://hex.pm) package

1. Add zencoder `mix.exs` dependencies:

    ```elixir
    def deps do
      [{:zencoder, "~> 0.0.1"}]
    end
    ```

2. Add `:zencoder` to your application dependencies:

    ```elixir
    def application do
      [applications: [:zencoder]]
    end
    ```

### API Key

To communicate with the Zencoder API you need to provide your API key, you can find your API key by logging into your Zencoder account and visiting https://app.zencoder.com/api

There are three ways to provide your API key to the Elixir library.

1. Set it from within your application
    ```elixir
    Zencoder.api_key "your-api-key"
    ```

2. Set it as the environment variable `ZENCODER_API_KEY`
    ```
    ZENCODER_API_KEY=your-api-key iex -S mix
    ```

3. Every request takes a map as its final argument, you may provide your API key there
    ```elixir
    Zencoder.Job.progress(12345, %{api_key: "your-api-key"})
    ```

### Base URL

By default the integration library will send all requests to version 2 of our API. "https://app.zencoder.com/api/v2". If, for whatever reason, you want to send requests to a different url you may configure your base URL in two ways.

1. Set it from within your application
    ```elixir
    Zencoder.base\_url "https://app.zencoder.com/api/v1"
    ```

2. Set it as the environment variable `ZENCODER_BASE_URL`
    ```
    ZENCODER\_BASE\_URL=https://app.zencoder.com/api/v1 iex -S mix
    ```

### Responses

All API request functions will return either a `%Zencoder.Response{}` struct (which may or may not be successful) or a `%Zencoder.Error{}` struct if an exception occurred.

#### %Zencoder.Response{}

A Zencoder response has the following fields:

1. body: A Map containing the parsed body of the response, or an empty map if the response body could not be parsed
2. success?: true or false depending on if the request was successful
3. code: The HTTP status code of the response
4. headers: The response headers
5. raw_body: The raw string of the response body. (Likely JSON or an empty string)
6. errors: An List of errors, or an empty List. This is a shortcut for `response.body[:errors]`

#### %Zencoder.Error{}

A Zencoder error has the following fields:

1. message:    The message from the exception
2. stacktrace: The formatted exception
3. kind:       The type of error
4. error:      The exception

The message and stacktrace fields are the result of calling Exception.message(error) and Exception.format(kind, error) respectively. The kind and error are provided if you wish to do your own formatting.

#### Pattern Matching

You can pattern match to determine how to handle the response:

    ```elixir
      case Zencoder.Job.create %{test: true, input: "http://s3.amazonaws.com/zencodertesting/test.mov"} do
        %Zencoder.Response{success?: true} = response ->
          # some happy path stuff here
        %Zencoder.Response{success?: false} = response ->
          # uh oh, maybe something is wrong with your request? better check the [docs](https://app.zencoder.com/docs)
        %Zencoder.Error{} = response ->
          # timed out, Zencoder down?! Perhaps some nice retry logic, check our [integration reliability guide](https://app.zencoder.com/docs/guides/advanced-integration/stable-integration)
      end
    ```

## [Jobs](https://app.zencoder.com/docs/api/jobs)

Create a [new job](https://app.zencoder.com/docs/api/jobs/create).

    ````elixir
    Zencoder.Job.create(%{input: "http://s3.amazonaws.com/zencodertesting/test.mov"})
    ````

Get [details](https://app.zencoder.com/docs/api/jobs/show) about a job.

    ````elixir
    Zencoder.Job.details(12345)
    ````

Get [progress](https://app.zencoder.com/docs/api/jobs/progress) on a job.

    ````elixir
    Zencoder.Job.progress(12345)
    ````

[List jobs](https://app.zencoder.com/docs/api/jobs/list). By default this returns the last 50 jobs, but this can be altered in an optional Map.

    ````elixir
    Zencoder.Job.list(%{page: 1, per_page: 5, state: "finished"})
    ````


[Cancel](https://app.zencoder.com/docs/api/jobs/cancel) a job

    ````elixir
    Zencoder.Job.cancel(12345)
    ````

[Resubmit](https://app.zencoder.com/docs/api/jobs/resubmit) a job

    ````elixir
    Zencoder.Job.resubmit(12345)
    ````

## [Inputs](https://app.zencoder.com/docs/api/inputs)

Get [details](https://app.zencoder.com/docs/api/inputs/show) about an input.

    ````elixir
    Zencoder.Input.details(12345)
    ````

Get [progress](https://app.zencoder.com/docs/api/inputs/progress) for an input.

    ````elixir
    Zencoder.Input.progress(12345)
    ````

## [Outputs](https://app.zencoder.com/docs/api/outputs)

Get [details](https://app.zencoder.com/docs/api/outputs/show) about an output.

    ````elixir
    Zencoder.Output.details(12345)
    ````

Get [progress](https://app.zencoder.com/docs/api/outputs/progress) for an output.

    ````elixir
    Zencoder.Output.progress(12345)
    ````

## [Reports](https://app.zencoder.com/docs/api/reports)

Reports are great for getting usage data for your account. All default to 30 days from yesterday with no [grouping](https://app.zencoder.com/docs/api/encoding/job/grouping), but this can be altered in the optional Map. These will return `422 Unprocessable Entity` if the date format is incorrect or the range is greater than 2 months. Correct date format is `YYYY-MM-DD`.

Get [all usage](https://app.zencoder.com/docs/api/reports/all) (Live + VOD).

    ````elixir
    Zencoder.Report.all
    ````

    // For a specific date range
    ````elixir
    Zencoder.Report.all %{from: "2013-05-01", to: "2013-06-01"}
    ````

    // For a specific grouping
    ````elixir
    Zencoder.Report.all %{grouping: "aperture-testing"}
    ````

Get [VOD usage](https://app.zencoder.com/docs/api/reports/vod).

    ````elixir
    Zencoder.Report.vod
    ````

    // For a specific date range
    ````elixir
    Zencoder.Report.vod %{from: "2013-05-01", to: "2013-06-01"}
    ````

    // For a specific grouping
    ````elixir
    Zencoder.Report.vod %{grouping: "aperture-testing"}
    ````

Get [Live usage](https://app.zencoder.com/docs/api/reports/live).

    ````elixir
    Zencoder.Report.live
    ````

    // For a specific date range
    ````elixir
    Zencoder.Report.live %{from: "2013-05-01", to: "2013-06-01"}
    ````

    // For a specific grouping
    ````elixir
    Zencoder.Report.live %{grouping: "aperture-testing"}
    ````

## [Accounts](https://app.zencoder.com/docs/api/accounts)

Create a [new account](https://app.zencoder.com/docs/api/accounts/create). A unique email address and terms of service are required, but you can also specify a password (and confirmation) along with whether or not you want to subscribe to the Zencoder newsletter. New accounts will be created under the Test (Free) plan.

  ````elixir
  Zencoder.Account.create %{email: "tedjones@example.com", terms_of_service: 1}
  ````

  ````elixir
  Zencoder.Account.create %{
    email: "tedjones2@example.com",
    terms_of_service: 1,
    password: "sureamgladforssl",
    password_confirmation: "sureamgladforssl",
    newsletter: 0
  }
  ````

Get [details](https://app.zencoder.com/docs/api/accounts/show) about the current account.

  ````elixir
  Zencoder.Account.details
  ````

Turn [integration mode](https://app.zencoder.com/docs/api/accounts/integration) on (all jobs are test jobs).

    ````elixir
    Zencoder.Account.integration
    ````

Turn off integration mode, which means your account is live (and you'll be billed for jobs).

  ````elixir
  Zencoder.Account.live
  ````
----