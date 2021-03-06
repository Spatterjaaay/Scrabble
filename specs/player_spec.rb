require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/score'
require_relative '../lib/letter'
require_relative '../lib/player'
require_relative '../lib/tilebag'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new


describe "ScrabblePlayer" do

       before do
         @player = Scrabble::Player.new("Boo")
       end

            describe "Player#initialize" do
                   it "takes a name" do
                     name = "Boo"
                     player = Scrabble::Player.new(name)

                     player.must_respond_to :name
                     player.name.must_equal name
                   end

                   it "is a kind of Player" do
                     @player.must_be_kind_of Scrabble::Player
                   end

                   it "returns an array of played words" do
                     played_words = ["books", "quiver", "pen"]
                     3.times { |n| @player.play(played_words[n]) }

                     @player.plays.must_equal played_words
                   end

                 end

                 describe "Player#play" do
                   it "returns a number" do
                     @player.play("aaaa").must_be_kind_of Integer
                   end

                   it "does not allow invalid word" do
                     proc {
                       @player.play("gre@8t")
                     }.must_raise ArgumentError
                   end

                   it "returns false if game is alredy won" do
                     played_words = ["jjjjjjj", "zzzzzzz"]
                     2.times { |n| @player.play(played_words[n]) }
                     @player.play("book").must_equal false
                   end

                   it "does not allow invalid word input" do
                     proc {
                       @player.play
                     }.must_raise ArgumentError
                   end

              end

  describe "ScrabblePlayer" do
         before do
           @played_words = %w(grits gravy biscuit greens)
           @player = Scrabble::Player.new("Ada", @played_words)
         end

         describe 'Total score of player' do
           it 'Returns the score of the highest_scoring_word' do
             @player.total_score.must_equal 86
           end
         end

         describe 'Whether player won' do
           it 'Returns false until player has exceed 100 points. Then returns true.' do
             @player.play("bacon")
             @player.won?.must_equal false

             @player.play("bacon")
             @player.won?.must_equal true
           end
         end

         describe 'Highest scoring word played by player' do
           it 'Returns string with the most points.' do
             @player.highest_scoring_word.must_equal "biscuit"
           end
      end

           it "raises argument error if no words played yet" do
             player = Scrabble::Player.new("Boo")

             proc {
               player.highest_scoring_word
             }.must_raise ArgumentError
           end


         describe 'Score of highest scoring word played by player' do
           it 'Returns value of string with the most points.' do
             @player.highest_word_score.must_equal 61
           end
      end

           it "returns 0 if there is no word" do
             player = Scrabble::Player.new("Boo")
             player.highest_word_score.must_equal 0
           end
     end

     describe "draw_tiles(tile_bag)" do

           it "Allows player a collection of tiles" do

                player = Scrabble::Player.new("Ada")
                player.tiles.must_be_kind_of Array
                player.tiles.length.must_equal 0

          end

          it "Selects 3 tiles when the player has 4" do

               current_tiles = %w(e e t v)
               bag = Scrabble::TileBag.new
               player = Scrabble::Player.new("Ada", nil, current_tiles)

               player.draw_tiles(bag).length.must_equal 7
          end

         it "Selects 4 tiles when the player has 3" do

              tiles = %w(e e v)
              bag = Scrabble::TileBag.new
              player = Scrabble::Player.new("Ada", nil, tiles)

              player.draw_tiles(bag).length.must_equal 7
         end

        it "Selects 0 tiles when the player has 7" do

             bag = Scrabble::TileBag.new
             player = Scrabble::Player.new("Ada")

             player.draw_tiles(bag).length.must_equal 7
         end
      end

end
