defmodule Loop do
   def create_emp_dataset(imap, n) when n <= 1 do
      #IO.puts "OUT #{msg}  #{n}"
      IO.inspect(imap, label: "OUT: ")
      MapSet.put(imap, n)
      end

   def create_emp_dataset(imap, n) do
      IO.inspect(imap, label: "IN: ")
      imap = MapSet.put(imap, n)
      create_emp_dataset(imap, n - 1)
   end
   
end

imap = MapSet.new()
imap = Loop.create_emp_dataset(imap, 10)
IO.inspect(imap, label: "FINAL MAP: ")