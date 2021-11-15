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

# Parse the first_names file and builda liast of first names
with {:ok, first_names} = File.read("./priv/data/first_names.txt") do 
    fnm=  first_names
    |> String.split("\r\n", trim: true) 
    |> IO.inspect
    
    for f <- fnm do
      IO.inspect(f)
    end

    # Parse the last_names file and build a list of last names
    with {:ok, last_names} = File.read("./priv/data/last_names.txt") do 
      lnm =  last_names
      |> String.split("\r\n", trim: true) 
      |> IO.inspect
      
      for l <- lnm do
        IO.inspect(l)
      end

      # Pparse the job_titles file and build a list of job titles
      with {:ok, job_titles} = File.read("./priv/data/job_titles.txt") do 
        jt =  job_titles
        |> String.split("\r\n", trim: true) 
        |> IO.inspect
        
        for j <- jt do
          IO.inspect(j)
        end

        # Now we needd to create 10,000 employee records by matching a 
        # first name to a last name, a random job title, a salary, and 
        # country of citizens ship.   For salary we will generate a range
        # of 50,0000 to 100,000 in a non-desccript values
      end
  end
end
