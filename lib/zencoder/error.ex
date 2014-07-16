defmodule Zencoder.Error do
  defstruct stacktrace: nil, kind: nil, error: nil

  def process(kind, error) do
    %__MODULE__{
      stacktrace: Exception.format(kind, error),
      kind: kind,
      error: error
    }
  end

end
