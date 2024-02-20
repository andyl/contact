defmodule Formin.Util.File do
  def mtime(path) do
    case File.stat(path) do
      {:ok, %File.Stat{mtime: mtime}} -> mtime |> format_mtime()
      {:error, _reason} -> {:error, :file_not_found}
    end
  end

  defp format_mtime({{year, month, day}, {hour, minute, second}}) do
    NaiveDateTime.new!(year, month, day, hour, minute, second)
    |> Calendar.strftime("%y%m%d%H%M%S")
  end

  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

  def rand do
    rand(6)
  end

  def rand(length) do
    1..length
    |> Enum.reduce("", fn _, acc ->
      random_char = String.at(@chars, :rand.uniform(String.length(@chars)) - 1)
      acc <> random_char
    end)
  end

end
