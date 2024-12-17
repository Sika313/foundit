# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoundIt.Repo.insert!(%FoundIt.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias FoundIt.Users
alias FoundIt.Category
alias FoundIt.Roles

admin = %{
  fname: "Janet",
  lname: "Lemygrace",
  password: "janet",
  phone: "0975749165",
  role: "ADMIN"
}

Users.create_user(admin)

category = [
%{name: "phone"},
%{name: "laptop"},
%{name: "accessories"},
%{name: "jewery"},
%{name: "bag"},
%{name: "document"}

]

for i <- category do
Category.create_categories(i)
end

roles = [
%{name: "ADMIN"},
%{name: "DATA ENTRY"}
]

for i <- roles do

  Roles.create_role(i)
end
