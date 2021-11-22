defmodule ExerciseWeb.CurrencyControllerTest do
  use ExerciseWeb.ConnCase

  alias Exercise.Countries
  alias Exercise.Countries.Currency

  @create_attrs %{
    code: "some code",
    name: "some name",
    symbol: "some symbol"
  }

  @update_attrs %{
    code: "some updated code",
    name: "some updated name",
    symbol: "some updated symbol"
  }
  
  @invalid_attrs %{code: nil, name: nil, symbol: nil}

  def fixture(:currency) do
    {:ok, currency} = Countries.create_currency(@create_attrs)
    currency
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all currencies", %{conn: conn} do
      conn = get(conn, Routes.currency_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create currency" do
    test "renders currency when data is valid", %{conn: conn} do
      conn = post(conn, Routes.currency_path(conn, :create), currency: @create_attrs)
      IO.inspect(json_response(conn, 201)["data"], label: "CURRENCY JSON RSP")
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.currency_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "code" => "some code",
               "name" => "some name",
               "symbol" => "some symbol"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.currency_path(conn, :create), currency: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

    defp create_currency(_) do
    currency = fixture(:currency)
    %{currency: currency}
  end
end
