require "open-uri"
class GamesController < ApplicationController
  def new
    # @letter_array = Array.new(10){[*"A".."Z"].sample}

    @letter_array = ["b", "a","n","a","n","a","q", "q", "q", "q"]
  end

  def score

    #reseies word
    #@api word?
    #calculate score ---- need time from post?
    # display score
  # link to play again

    #word illegal?

    # hello api
    # is valid?
    letters = params[:letters].downcase.chars.reject { |char| char == " " }
    submission = params[:submission].downcase

    # am_i_empty = submission.chars - letters


    @valid = false
    @valid = true if submission.chars - letters == [] && (letters - submission.chars).length == (letters.length - submission.length)

    url = "https://dictionary.lewagon.com/#{submission}"
    response = URI.open(url)
    read = response.read
    data = JSON.parse(read)

    time_post = params[:timestamp].to_datetime
    time_now = Time.now()
    @seconds = time_now - time_post
    # raise
    # def current_user
    #   @_current_user ||= session[:current_user_id] &&
    #     User.find_by(id: session[:current_user_id])
    # end

    @length = data["length"] if @valid
    @points = (((@length**2) / @seconds) * 100).round() if @valid




    def update_score
      session[:score_total] ||= 0
      session[:played_total] ||= 0

      session[:score_total] += @points if @valid
      session[:played_total] += 1
    end

    update_score()

    if data["found"] && @valid
      @message = "Congrats #{submission} is a real word. It took you #{@seconds.round(2)} seconds. You get #{@points} points"
    else
      @length = 0
      @message = "Rubbish mate! #{submission} is a fake word. You get 0 points"
    end


    # raise



    # json = JSON.parse(response)
    # "{\"found\":true,\"word\":\"banana\",\"length\":6}"

#     require 'open-uri'
# require 'json'

# # Define the URL
# url = 'https://dictionary.lewagon.com/banana'

# # Open the URL and read the data
# begin
#   response = URI.open(url)       # Opens the URL
#   response_body = response.read  # Reads the content of the response
#   json_data = JSON.parse(response_body)  # Parses the JSON string into a Ruby hash



#     require 'open-uri'
# require 'json'

# url = 'http://example.com/api/data'  # The API endpoint you are accessing
# begin
#   response = URI.open(url)          # Opens the URL
#   response_body = response.read     # Reads the response from the API
#   json_data = JSON.parse(response_body)  # Parses the JSON response into a Ruby hash
#   puts json_data                    # Prints the parsed data
# rescue OpenURI::HTTPError => e
#   puts "HTTP Error: #{e.message}"   # Handles HTTP errors
# rescue StandardError => e
#   puts "Error: #{e.message}"        # Handles other errors
# end


    # response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
    # raise

    # response2 = HTTParty.get(url)

    # uri = URI(url)
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true

    # request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})

    # request.body = {} # SOME JSON DATA e.g {msg: 'Why'}.to_json

    # response = http.request(request)

    # body = JSON.parse(response.body) # e.g {answer: 'because it was there'}

    # url = URI.parse('http://www.example.com/index.html')
    # req = Net::HTTP::Get.new(url.to_s)
    # res = Net::HTTP.start(url.host, url.port) {|http|
    #   http.request(req)
    # }
    # puts res.body

    # uri = URI(url)
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true

    # request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})

    # request.body = {} # SOME JSON DATA e.g {msg: 'Why'}.to_json

    # response = http.request(request)

    # @body = JSON.parse(response.body) # e.g {answer: 'because it was there'}

    # debugger
    # p params
    # raise
  end
end
