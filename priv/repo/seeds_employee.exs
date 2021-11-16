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
alias Exercise.Countries

# List of salaries * 1000 below
salaries = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]       

# Get list of countries to randomly pick for each new employee record
countries = Countries.list_countries()
        
# Extract just the country and currency ids
clist = for c <- countries do
  [c.id, c.currency_id]
end
#IO.inspect(clist, label: "CLIST: ")
        
# Parse the first_names file and builda liast of first names
with {:ok, first_names} = File.read("./priv/data/first_names.txt") do 
    fnm=  first_names
    |> String.split("\r\n", trim: true) 
    #|> IO.inspect
    
    # Parse the last_names file and build a list of last names
    with {:ok, last_names} = File.read("./priv/data/last_names.txt") do 
      lnm =  last_names
      |> String.split("\r\n", trim: true) 
      #|> IO.inspect
      
      # Pparse the job_titles file and build a list of job titles
      with {:ok, job_titles} = File.read("./priv/data/job_titles.txt") do 
        jt =  job_titles
        |> String.split("\r\n", trim: true) 
        #|> IO.inspect
        
        # Now we needd to create 10,000 employee records by matching a 
        # first name to a last name, a random job title, a salary, and 
        # country of citizens ship.   For salary we will generate a range
        # of 50,0000 to 100,000 in a non-desccript values

        # Pick random first name
        rfnm = Enum.random(fnm)
        #IO.puts(rfnm)

        # Pick random last name
        rlnm = Enum.random(lnm)
        #IO.puts(rlnm)

        # Pick random job title 
        rjt = Enum.random(jt)
        #IO.puts(rjt)

        # Pick random salary
        rs = (Enum.random(salaries) * 1000)
        #IO.puts(rs)

        # Pick a random country and currency id pairing
        rcc = Enum.random(clist)
        [cid, curr_id] = rcc
        #IO.puts(cid)
        #IO.puts(curr_id)

        IO.puts("#{rfnm}  #{rlnm}  #{rjt}  #{rs}  #{cid}  #{curr_id}")
      end
  end
end
