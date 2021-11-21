defmodule Exercise.MetricsTest do
  use Exercise.DataCase

  alias Exercise.Metrics

  describe "salary_jobtitles" do
    alias Exercise.Metrics.SalaryJobtitle

    @valid_attrs %{avg: "120.5", jobtitle: "some jobtitle", name: "some name", symbol: "some symbol"}
    @update_attrs %{avg: "456.7", jobtitle: "some updated jobtitle", name: "some updated name", symbol: "some updated symbol"}
    @invalid_attrs %{avg: nil, jobtitle: nil, name: nil, symbol: nil}

    def salary_jobtitle_fixture(attrs \\ %{}) do
      {:ok, salary_jobtitle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Metrics.create_salary_jobtitle()

      salary_jobtitle
    end

    test "list_salary_jobtitles/0 returns all salary_jobtitles" do
      salary_jobtitle = salary_jobtitle_fixture()
      assert Metrics.list_salary_jobtitles() == [salary_jobtitle]
    end
  end

  describe "salary_countries" do
    alias Exercise.Metrics.SalaryCountry

    @valid_attrs %{avg: "120.5", code: "some code", crcode: "some crcode", max: "120.5", min: "120.5"}
    @update_attrs %{avg: "456.7", code: "some updated code", crcode: "some updated crcode", max: "456.7", min: "456.7"}
    @invalid_attrs %{avg: nil, code: nil, crcode: nil, max: nil, min: nil}

    def salary_country_fixture(attrs \\ %{}) do
      {:ok, salary_country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Metrics.create_salary_country()

      salary_country
    end

    test "list_salary_countries/0 returns all salary_countries" do
      salary_country = salary_country_fixture()
      assert Metrics.list_salary_countries() == [salary_country]
    end
  end
end
