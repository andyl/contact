defmodule Execd.Util.Test do

  def base_dir do
    "/tmp/test_dir"
  end

  def base_file do
    base_dir() <> "/test1.md"
  end

  def base_text do
    """
    # Base Text

    Some Text

    ## Section1

    This is section1

    ## Section2

    This is section2
    """
  end

  # -----

  def test_dir do
    "/home/aleak/src/org_db/data"
  end

  def test_file do
    "/home/aleak/src/org_db/data/TopMOC.md"
  end

  def test_text do
    test_file() |> File.read!()
  end

  # -----

  def org_dir do
    "/home/aleak/util/org"
  end

  def org_file do
    "/home/aleak/util/org/OrgMOC.md"
  end

  def org_text do
    org_file() |> File.read!()
  end

  # -----

  def setup do
    File.rm_rf(base_dir())
    File.mkdir_p(base_dir())
    File.write(base_file(), base_text())
  end

  def teardown do
    File.rm_rf(base_dir())
  end

end
