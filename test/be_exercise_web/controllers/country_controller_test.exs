defmodule ExerciseWeb.CountryControllerTest do
  use ExerciseWeb.ConnCase

  alias Exercise.Countries
  alias Exercise.Countries.Country

  @cntry_valid_attrs %{
    code: "some code",
    name: "some name",
    currency_id: 1
  }
  @cntry_update_attrs %{
    code: "some updated code",
    name: "some updated name",
  }
  @invalid_attrs %{code: nil, name: nil}
  
  @curr_valid_attrs %{
    code: "some code", 
    name: "some name", 
    symbol: "some symbol"}

  def fixture(:country) do
    {:ok, currency} = Countries.create_currency(@curr_valid_attrs)
    attrs = Map.put(@cntry_valid_attrs, :currency_id, currency.id)

    {:ok, country} = Countries.create_country(attrs)

    country
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all countries", %{conn: conn} do
      conn = get(conn, Routes.country_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create country" do
    test "renders country when data is valid", %{conn: conn} do
      {:ok, currency} = Countries.create_currency(@curr_valid_attrs)
      attrs = Map.put(@cntry_valid_attrs, :currency_id, currency.id)

      conn = post(conn, Routes.country_path(conn, :create), country: attrs)
      assert %{"id" => id, "name" => name, "code" => code, 
               "currency_id" => currency_id} = json_response(conn, 201)["data"]

      assert name == "some name"
      assert code == "some code"
      assert currency_id == currency.id
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.country_path(conn, :create), country: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update country" do
    setup [:create_country]

    test "renders country when data is valid", %{conn: conn, country: %Country{id: id} = country} do
      conn = put(conn, Routes.country_path(conn, :update, country), country: @cntry_update_attrs)
      assert %{"name" => name, "code" => code,
               "currency_id" => currency_id} = json_response(conn, 200)["data"]

      assert name == "some updated name"
      assert code == "some updated code"
      assert currency_id = country.currency_id
    end

    test "renders errors when data is invalid", %{conn: conn, country: country} do
      conn = put(conn, Routes.country_path(conn, :update, country), country: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete country" do
    setup [:create_country]

    test "deletes chosen country", %{conn: conn, country: country} do
      conn = delete(conn, Routes.country_path(conn, :delete, country))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.country_path(conn, :show, country))
      end
    end
  end

  defp create_country(_) do
    country = fixture(:country)
    %{country: country}
  end
end
