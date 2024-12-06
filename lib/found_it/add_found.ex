defmodule FoundIt.AddItem do
  alias FoundIt.Items

  def add_found(params) do
    IO.inspect(params, label: "RECEIVED PARAMS--->")
    holder = Path.absname(params["image"])
    source = "/home/oem/Pictures/" <> params["image"]
    destination = "/home/oem/Documents/PROJECTS/found_it/priv/static/images/found/" <> params["image"]
    case File.cp( source, destination ) do
    :ok -> 
    token = Enum.random(1000..100000)
    new_params = %{
      "category" => params["category"],
      "description" => params["description"],
      "image" => params["image"],
      "location" => params["location"],
      "lost_or_found" => "found",
      "status" => false,
      "phone" => params["phone"],
      "token" => token,
      "receiver_phone" => ""
    }
    Items.create_item(new_params)
    {:ok, token} 
    {:error} -> {:error}
    end
  end

end
