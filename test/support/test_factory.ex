defmodule TestFactory do
  @moduledoc false
  def participant(id) do
    %{
      "id" => id,
      "user_id" => id,
      "user_name" => "p-#{id}"
    }
  end
end
