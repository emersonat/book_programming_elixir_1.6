defmodule Issues.GithubIssues do

  @user_agent [{"User-agent","Elixir dave@pragprog.com"}]
  @github_url Application.get_env(:issues, :github_url)
  require Logger

  def fetch(user, project) do

    issues_url(user,project)
    |> HTTPoison.get(@user_agent)
    |> handle_response

  end

  defp issues_url(user, project) do
    Logger.info("URL GIT: " <> "#{@github_url}/repos/#{user}/#{project}/issues")

    "#{@github_url}/repos/#{user}/#{project}/issues"
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
    Logger.error("Erro GIT: " <> body )
    {:error, body}
  end

end
