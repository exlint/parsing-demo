defmodule Hello do

  def hi(name) do
    IO.puts "Hello " <> name
  end

end

# {:defmodule, 
#  [line: 1],
#  [{:__aliases__, 
#    [counter: 0, line: 1], 
#    [:Hello]
#   },
#   [do: 
#    {:def, 
#     [line: 3],
#     [{:hi, 
#       [line: 3], 
#       [{:name, 
#        [line: 3], 
#        nil
#        }
#       ]
#      },
#      [do: 
#       {
#        {:., 
#         [line: 4],
#         [{:__aliases__, 
#           [counter: 0, line: 4],
#           [:IO]
#          }, :puts
#         ]
#        }, 
#        [line: 4],
#        [{:<>, 
#          [line: 4], 
#          ["Hello ", 
#           {:name, [line: 4], nil}
#          ]
#         }
#        ]
#       }
#      ]
#     ]
#    }
#   ]
#  ]
# }
