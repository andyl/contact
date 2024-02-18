defmodule Execd.Util.File do

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

end

