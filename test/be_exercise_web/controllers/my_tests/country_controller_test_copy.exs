defmodule ExerciseWeb.CountryControllerTest do
  use ExerciseWeb.ConnCase

  alias Exercise.Countries
  alias Exercise.Countries.Country

  @curr_valid_attrs %{
    code: "some code", 
    name: "some name",
    symbol: "&",
    currency_id: 1
  }

  @create_attrs %{
    code: "some code",
    name: "some name",
    currency_id: 1
  }

  @update_attrs %{
    code: "some updated code",
    name: "some updated name",
    currency_id: 1
  }
  @invalid_attrs %{code: nil, name: nil, currency_id: nil}

   def fixture_currency(:currency) do
    {:ok, currency} =
        Countries.create_currency(@curr_valid_attrs)
    #Countries.get_country!(currency.id)
    IO.inspect(currency, label: "CURRENCY")
    
    currency
    end


  def fixture(:country) do
    # {:ok, currency} =
    #     Countries.create_currency(@curr_valid_attrs)
    # #Countries.get_country!(currency.id)
    # IO.inspect(currency, label: "CURRENCY")
    # attrs = Map.put(@create_attrs, :currency_id, currency.id)
    # IO.inspect(attrs, label: "ATTRS")

    {:ok, country} = Countries.create_country(@create_attrs)
    country
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  # describe "index" do
  #   test "lists all countries", %{conn: conn} do
  #     conn = get(conn, Routes.country_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  describe "create country" do
    test "renders country when data is valid", %{conn: conn} do
      {:ok, currency} = Countries.create_currency(@curr_valid_attrs)
      attrs = Map.put(@create_attrs, :currency_id, currency.id)
      attrs = Map.put(attrs, :id, nil)
      IO.inspect(attrs, label: "ATTRS")
      conn = post(conn, Routes.country_path(conn, :create), country: attrs)
      IO.inspect(json_response(conn, 201)["data"], label: "201 JSON RSP")
      assert %{"id" => id} = json_response(conn, 201)["data"]
      #assert %{"currency_id" => curr_id} = json_response(conn, 201)["data"]
      IO.inspect(json_response(conn, 201)["data"], label: "201 JSON RSP")

      IO.inspect(%Exercise.Countries.Country{}, label: "EXERCISE COUNTRY")
      #conn = get(conn, Routes.country_path(conn, :show, id))
      #IO.inspect(json_response(conn, 200)["data"], label: "200 JSON RSP")

      # assert %{
      #          "currency_id" => ^id,
      #          "code" => "some code",
      #          "name" => "some name"
      #        } = json_response(conn, 200)["data"]
    end

    # test "renders errors when data is invalid", %{conn: conn} do
    #   conn = post(conn, Routes.country_path(conn, :create), country: @invalid_attrs)
    #   assert json_response(conn, 422)["errors"] != %{}
    # end
  end

  # describe "update country" do
  #   setup [:create_country]

  #   test "renders country when data is valid", %{conn: conn, country: %Country{id: id} = country} do
  #     conn = put(conn, Routes.country_path(conn, :update, country), country: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.country_path(conn, :show, id))

  #     assert %{
  #              "id" => ^id,
  #              "code" => "some updated code",
  #              "name" => "some updated name"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, country: country} do
  #     conn = put(conn, Routes.country_path(conn, :update, country), country: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete country" do
  #   setup [:create_country]

  #   test "deletes chosen country", %{conn: conn, country: country} do
  #     conn = delete(conn, Routes.country_path(conn, :delete, country))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.country_path(conn, :show, country))
  #     end
  #   end
  # end

  defp create_country(_) do
    IO.inspect(:country, label: ":COUNTRY")
    country = fixture(:country)
    IO.inspect(country, label: "FIXTURE COUNTRY")
    %{country: country}
  end

   defp create_currency(_) do
    IO.inspect(:country, label: ":COUNTRY")
    currency = fixture_currency(:currency)
    IO.inspect(currency, label: "FIXTURE COUNTRY")
    %{currency: currency}
  end
end
