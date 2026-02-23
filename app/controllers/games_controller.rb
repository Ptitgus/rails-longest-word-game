  require "httparty"

class GamesController < ApplicationController
  def score
  @wordtocheck = params[:word].upcase
  @avail_letters = params[:letters].split(" ")
  @final_result = ""
    # controle lettres vs mot saisi
    if word_vs_letters(@wordtocheck, @avail_letters) == false
      @final_result = "Sorry but #{@wordtocheck} can't be built out of #{@avail_letters}"
    else
      if check_word_API(@wordtocheck) == false
      @final_result = "Sorry but #{@wordtocheck} does not seem to be a valid English word ... "
      else
      @final_result = "Congratulations! #{@wordtocheck} is a valid english word!"
      end
    end
  end

  def word_vs_letters(word, letters)
    mot = word
    lettres_disponibles = letters
    lettres_temp = lettres_disponibles.dup
      mot.each_char do |char|
        indexencours = lettres_temp.index(char)
      if lettres_temp.include?(char)
        lettres_temp.delete_at(indexencours) # Retire la lettre utilisée
      else
        return false # Lettre manquante
      end
    end
    true
  end

  def check_word_API(word)
    api_url = "https://dictionary.lewagon.com/#{word}"
    response = HTTParty.get(api_url)
    post_data = response.parsed_response
    if post_data["found"] == true
      true
    else
      false
    end
  end

  def new
    @letters = ""
    array_letters = []
    array_alphabet = ("A".."Z").to_a

    (1..10).each do ||
      random_letter = array_alphabet.sample
      array_letters << random_letter
    end
    @letters = array_letters
  end
end
