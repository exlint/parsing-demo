defmodule ExlintTest do
  use ExUnit.Case

  test "can parse an empty file" do
    result = Exlint.lint("lib/empty.ex")
    assert result == %{}
  end

  test "can parse an empty module" do
    result = Exlint.lint("lib/empty_module.ex")
    assert result == %{defmodule: :Empty} #[{:defmodule, [:Empty]}]
  end

  test "can parse bar" do
    result = Exlint.lint("lib/bar.ex")
    assert result == %{defmodule: :Bar, def: [:foo]} # [{:defmodule, {:def, [:foo]}]
  end

  test "can parse foo" do
    result = Exlint.lint("lib/foo.ex")
    assert result == %{defmodule: :Foo, 
                       def: [:one, :two, :three, :four]}
    # assert result == [
    #   {:defmodule, [:Foo]}, 
    #   {:def, [:one, :two, :three, :four]}
    # ]
  end
end
