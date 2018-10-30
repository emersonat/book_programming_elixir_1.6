defmodule Issues.GithubIssues do

  @user_agent [{"User-agent","Elixir dave@pragprog.com"}]

  def fetch(user, project) do

    issues_url(user,project)
    |> HTTPoison.get(@user_agent)
    |> handle_response

  end

  defp issues_url(user, project) do
    "https://api.github.com/repos/elixir-lang/elixir/issues"
  end

  defp handle_response( {_,%{status_code: status_code, body: body} }) do

    {
      status_code |> check_for_erro,
      body |> Poison.Parser.parse!()
    }
  end

  defp check_for_erro(200), do: :ok
  defp check_for_erro(_), do: :error

  defp handle_response( {_,%{status_code: status_code, body: body} }) do
    {:error, body}
  end

end