module Scrabble

     class Letter

          attr_reader :name, :point

          SCORING_CHART = { %w(A E I O U L N R S T) => 1, %w(D G) =>  2, %w(B C M P) =>  3, %w(F H  V W Y) =>  4, %w(K) =>  5, %w(J X) => 8, %w(Q Z) => 10 }

          def initialize(name)
              raise ArgumentError.new "That's not a letter" unless ("A".."Z").include?(name)
              @name = name
              @point = assign_points
          end

          def assign_points
               SCORING_CHART.each do | key, value |
                    return value if key.include?(@name)
               end
          end
     end
end
