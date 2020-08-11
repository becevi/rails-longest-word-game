require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (0...8).map { (65 + rand(26)).chr }.join
    # raise
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    included = included?(@word, @letters) 
    english_word = english_word?(@word)
    if included
      if  english_word
        @text = "Congratulations! #{@word} is an english word."
      else
        @text = "So sad! #{@word} is not an english word."
      end
    else
      @text = "#{@word}is not included inside #{@letters}"
    end
  end

  private

  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    json["found"]
  end
end

