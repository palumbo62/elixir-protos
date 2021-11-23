defmodule Exercise.Metrics do
  @moduledoc """
  The Metrics context.
  """

  import Ecto.Query, warn: false
  alias Exercise.Repo

  alias Exercise.Metrics.SalaryJobtitle

  @doc """
  Returns the list of salary_jobtitles.

  ## Examples

      iex> list_salary_jobtitles()
      [%SalaryJobtitle{}, ...]

  """
  def list_salary_jobtitles do
    q = from(e in "employees",
              join: c in "countries", 
              join: cr in "currencies",
              on: e.country_id == c.id,
              on: c.currency_id == cr.id,    
              select: %Exercise.Metrics.SalaryJobtitle{
                        jobtitle: e.job_title, 
                        avg: avg(e.salary), 
                        name: c.name, 
                        symbol: cr.symbol},
              group_by: [e.job_title, c.name, cr.symbol])

    Repo.all(q)
  end

  @doc """
  Gets a single salary_jobtitle.

  Raises `Ecto.NoResultsError` if the Salary jobtitle does not exist.

  ## Examples

      iex> get_salary_jobtitle!(123)
      %SalaryJobtitle{}

      iex> get_salary_jobtitle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_salary_jobtitle!(id), do: Repo.get!(SalaryJobtitle, id)
  
  @doc """
  Returns the list of salary_countries.

  ## Examples

      iex> list_salary_countries()
      [%SalaryCountry{}, ...]

  """
  def list_salary_countries do
    q = from(e in "employees",
              join: c in "countries", 
              join: cr in "currencies",
              on: e.country_id == c.id,
              on: c.currency_id == cr.id,    
              select: %Exercise.Metrics.SalaryCountry{code: c.code, 
                        crcode: cr.code, 
                        avg: avg(e.salary), 
                        min: min(e.salary), max: max(e.salary)},
              group_by: [c.code, cr.code])
    Repo.all(q)
  end

  @doc """
  Gets a single salary_country.

  Raises `Ecto.NoResultsError` if the Salary country does not exist.

  ## Examples

      iex> get_salary_country!(123)
      %SalaryCountry{}

      iex> get_salary_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_salary_country!(id), do: Repo.get!(SalaryCountry, id)

end
