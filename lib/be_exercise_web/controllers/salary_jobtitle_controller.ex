defmodule ExerciseWeb.SalaryJobtitleController do
  use ExerciseWeb, :controller

  alias Exercise.Metrics

  action_fallback ExerciseWeb.FallbackController

  def index(conn, _params) do
    salary_jobtitles = Metrics.list_salary_jobtitles()
    render(conn, "index.json", salary_jobtitles: salary_jobtitles)
  end

  def show(conn, %{"id" => id}) do
    salary_jobtitle = Metrics.get_salary_jobtitle!(id)
    render(conn, "show.json", salary_jobtitle: salary_jobtitle)
  end
end
