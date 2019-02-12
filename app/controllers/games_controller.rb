# frozen_string_literal: true

require 'open-uri'
require 'json'

# Games Controller
class GamesController < ApplicationController
  def new
    @letters = generate_radon_letters(10)
    @score = session[:score]
  end

  def score
    @word = params[:word]
    @msg = validate_word(params[:grid].split, @word.upcase)
    @valid = @msg.blank?
    session[:score] = @valid ? session[:score] + calculate_score(@word) : 0
    @score = session[:score]
  end

  private

  def generate_radon_letters(grid_size)
    Array.new(grid_size) { [*'A'..'Z'].sample }
  end

  def msg_not_include_at_grid(grid)
    "can't be built out of #{grid.join(',')}"
  end

  def msg_not_a_english_word
    'does not seem to be a valid English word ...'
  end

  def includes?(grid, word)
    word
      .chars
      .all? { |char| grid.delete_at(grid.index(char) || grid.length) }
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(URI.parse(url).open.read)
  end

  def english_word?(word)
    check_word(word)['found']
  end

  def validate_word(grid, word)
    return msg_not_include_at_grid(grid) unless includes?(grid, word)

    msg_not_a_english_word unless english_word?(word)
  end

  def calculate_score(word)
    word.length
  end
end
