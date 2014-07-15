defmodule Zencoder.Error do
  defstruct message: nil, stacktrace: nil, kind: nil, error: nil

  def process(kind, error) do
    %__MODULE__{
      message: Exception.message(error),
      stacktrace: Exception.format(kind, error),
      kind: kind,
      error: error
    }
  end

end
