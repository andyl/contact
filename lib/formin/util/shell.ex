defmodule Formin.Util.Shell do

  def bash("") do
    :ok
  end

  def bash(cmd) do
    args = ["-c", cmd]
    System.cmd("bash", args)
  end

  def bash("", _data) do
    :ok
  end

  def bash(cmd, data) do
    newcmd = String.replace(cmd, "@data", data)
    bash(newcmd)
  end

end
