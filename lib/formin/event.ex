defmodule Formin.Event do

  alias Formin.Svc.Runner.Writer

  def process(action, path, data) do
    case lookup(action, path) do
      {:ok, outputs} -> dispatch(action, path, data, outputs)
      :not_found -> {400, "NOT FOUND"}
    end
  end

  def lookup(action, path) do
    routes = Formin.Cfg.Opts.default_routes()
    fullpath = "#{action}/#{path}"

    case Map.get(routes, fullpath) do
      nil -> :not_found
      dispatch -> {:ok, dispatch}
    end
  end

  def dispatch(action, path, data, outputs) do
    json =
      data
      |> Map.merge(%{action: action, path: path})
      |> Jason.encode!()

    result =
      outputs
      |> Enum.map(fn {type, address} -> Writer.output(type, address, json) end)
      |> Enum.all?(fn val -> val == :ok end)

    case result do
      true -> {200, "ok"}
      _ -> {500, "not ok"}
    end
  end

end
