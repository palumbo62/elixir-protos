# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Exercise.Repo.insert!(%Exercise.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


with {:ok, first_names} = File.read("./priv/data/first_names.txt") do 
    xx =  first_names
    |> String.split("\r\n", trim: true) 
    |> IO.inspect
    
    for f <- xx do
      IO.inspect(f)
    end

   
end
