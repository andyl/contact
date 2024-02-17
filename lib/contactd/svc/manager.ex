# defmodule Contactd.Svc.Manager do
#
#   @moduledoc "Database Manager"
#
#   use GenServer
#
#   alias Contactd.Fts.Db
#   alias Contactd.Doc.Dir
#   alias Contactd.Util
#
#   @procname :svc_manager
#
#   # ----- api
#
#   @doc "Search the database"
#   def search(query) do
#     GenServer.call(@procname, {:sm_search, query})
#   end
#
#   @doc "Retrieve all records"
#   def select_all do
#     GenServer.call(@procname, :sm_selectall)
#   end
#
#   @doc "Insert file"
#   def insert(filepath) do
#     GenServer.call(@procname, {:sm_insert, filepath})
#   end
#
#   @doc "Delete sections with a given filepath"
#   def delete(filepath) do
#     GenServer.call(@procname, {:sm_delete, filepath})
#   end
#
#   @doc "Update / Insert filepath"
#   def upsert(filepath) do
#     GenServer.call(@procname, {:sm_delete, filepath})
#     GenServer.call(@procname, {:sm_insert, filepath})
#   end
#
#   @doc "Reload the database"
#   def reload do
#     GenServer.call(@procname, :sm_reload)
#   end
#
#   # ----- startup
#
#   @doc false
#   def start_link(args) do
#     Util.IO.puts("Starting FTS DB Manager")
#     GenServer.start_link(__MODULE__, args, name: @procname)
#   end
#
#   @doc false
#   def init(args) do
#     basedir = Keyword.get(args, :base_dir, "/home/aleak/util/org")
#     db = Db.open(":memory:")
#          |> reload(basedir)
#     {:ok, %{basedir: basedir, db: db}}
#   end
#
#   # ----- callbacks
#
#   def handle_call(:sm_reload, _from, state) do
#     reload(state.db, state.basedir)
#     {:reply, :ok, state}
#   end
#
#   def handle_call({:sm_search, query}, _from, state) do
#     results = Db.search(state.db, query)
#     {:reply, results, state}
#   end
#
#   def handle_call(:sm_selectall, _from, state) do
#     results = Db.select_all(state.db)
#     {:reply, results, state}
#   end
#
#   def handle_call({:sm_delete, filepath}, _from, state) do
#     Db.delete(state.db, filepath)
#     {:reply, :ok, state}
#   end
#
#   def handle_call({:sm_insert, filepath}, _from, state) do
#     Db.load_file(state.db, filepath)
#     {:reply, :ok, state}
#   end
#
#   # ----- helpers
#
#   defp reload(db, base_dir) do
#     Db.empty(db)
#     Db.load(db, md_data(base_dir))
#   end
#
#   defp md_data(dir) do
#     dir
#     |> Dir.ingest()
#     |> List.flatten()
#   end
#
# end
#
