defmodule FoundIt.EditItem do
  
  alias FoundIt.Repo
  alias FoundIt.Items.Item

  def retrieve_item(token) do
    case Repo.get_by(Item, "token": String.to_integer(token)) do
      %FoundIt.Items.Item{} = result -> {:ok, result}
      nil -> {:not_found}
    end
  end

end
