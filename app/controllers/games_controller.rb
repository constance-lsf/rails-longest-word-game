require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10).join(' ').upcase
  end

  # @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
  # @letters.shuffle!

  def score
    @letters = ('a'..'z').to_a.sample(10).join(' ').upcase
    @word = params[:word]

    @result = if !english_word?(@word)
                "Sorry but #{@word.upcase} doesn't seem to be a valid English word..."
              elsif used_letters?(@word)
                "Sorry but #{@word.upcase} can't be build out of #{@letters}"
              else
                "Congratulations! #{@word.upcase} is a valid English word!"
              end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    check_english_word = URI.open(url).read
    JSON.parse(check_english_word)['found']
  end

  def used_letters?(word)
    word.chars.all? { |letter| @letters.include?(letter) }
  end
end
