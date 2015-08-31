defmodule FizzBuzz do
  def print(n) do
    generate
    |> Stream.take(n)
    |> Stream.each(&IO.puts/1)
    |> Stream.run
  end

  def generate do
    fizzes = Stream.cycle(["Fizz", "", ""])
    buzzes = Stream.cycle(["Buzz", "", "", "", ""])

    Stream.zip(fizzes, buzzes)
    |> Stream.map(&concat/1)
    |> Stream.with_index
    |> Stream.map(&translate/1)
    |> Stream.drop(1)
  end

  defp concat({f, b}), do: f <> b

  defp translate({"",   n}), do: to_string(n)
  defp translate({str, _n}), do: str
end
