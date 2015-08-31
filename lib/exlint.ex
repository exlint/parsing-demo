defmodule Exlint do

  # Public API

  def lint(path) do
    {:ok, file_contents} = File.read(path)
    {:ok, ast} = Code.string_to_quoted(file_contents)
    state = %{}
    do_lint(ast, state)
  end


  defp do_lint(nil, state), do: state
  defp do_lint([], state), do: state
  defp do_lint(:ok, state), do: state

  defp do_lint({:defmodule, _meta, args}, state) do
    do_lint_defmodule(args, state)
  end

  defp do_lint({:__aliases__, _meta, args}, state) do
    new_state = state
    do_lint(args, new_state)
  end

  # review this one... shouldn't be do_lint_block instead?
  defp do_lint({:__block__, _meta, args}, state) do
    do_lint_def(args, state) # should loop through the list
  end

  defp do_lint({:def, _meta, args}, state) do
    do_lint_def(args, state)
  end


  defp do_lint_defmodule([{:__aliases__, _meta, [atom]}, [do: body]], state) do
    new_state = Dict.put(state, :defmodule, atom)
    do_lint(body, new_state)
  end


  defp do_lint_def([{def_name, _meta, _args}, [do: body]], state) do
    if (!Dict.has_key?(state, :def)) do
      new_state = Dict.put(state, :def, [])
    end

    new_state = Dict.update!(new_state, :def, fn(defs_list)-> defs_list ++ [def_name] end)
    do_lint_def_body(body, new_state)
  end

  defp do_lint_def(args, state) when is_list(args) do
    new_state = Dict.put(state, :def, [])

    # do_lint_def should return the new state
    Enum.reduce(args, new_state, fn(tuple, state_acc) ->
      def_name = do_lint_def(tuple, new_state)
      Dict.update!(state_acc, :def, fn(defs_list)-> defs_list ++ [def_name] end)
    end)
  end

  defp do_lint_def({:def, _meta, args}, state) do
    do_lint_def_args(args, state)
  end

  defp do_lint_def({def_name, _meta, args}, state) do
    do_lint_def_args(args, state)
  end


  defp do_lint_def_args([{def_name, _meta, args}, [do: body]], state) do
    def_name
  end


  defp do_lint_def_body(body, state) do
    do_lint(body, state)
  end

end
