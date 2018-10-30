defmodule Issues.CLI do

  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 4

  @moduledoc """

  Handle the command line parsing and the dispatch to the
  various functions that end up
  generationg a table of the last_n_issues in a gitgub project

  """

  def main(argv) do
    argv
    |> parse_args
    |> process

  end


  defp process(:help) do
    IO.puts """
      usage: issues <user> <project> [count | #@default_count]
    """
    System.halt(0)
  end

  defp process({user,project,count}) do
    Issues.GithubIssues.fetch(user,project)
    |> decode_response()
    |> sort_into_descending_order()
    |> last(count)
    |> print_table_for_columns(["number","created_at","title"])

  end


  def last(list,count) do
    list
    |> Enum.take(count)
    |> Enum.reverse

  end

  def sort_into_descending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort( fn i1,i2 ->
      i1["created_at"] >= i2["created_at"]
    end )
  end

  defp decode_response({:ok, body}), do: body

  defp decode_response({:error, body}) do
    IO.puts "Error fetching from Github: #{body}  "

    System.halt(2)
  end

  @doc """
  'argv' can be -h or --help, which returns :help

  Otherwise it is a github username, project, name and (optionally)

  Return a tuple of '{user,projet,count}' or :help if help was given.

  """
  def parse_args(argv) do

     _parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help] )
    |> elem(1)
    |> args_to_internal_representation()

  end



  defp args_to_internal_representation([user,project,count])do
    {user,project,String.to_integer(count) }
  end

  defp args_to_internal_representation([user,project])do
    {user,project,@default_count }
  end

  defp args_to_internal_representation(_)do
    :help
  end





end
