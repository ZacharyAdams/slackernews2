require 'sinatra'
require 'csv'
require 'pry'

def read_in_art
  articles = []
  CSV.foreach('views/data.csv' , headers: true) do |row|
    articles << row.to_hash
  end
  articles.reverse
end

get '/' do
  @read = read_in_art
  erb :index
end

get '/article_new' do
  @article = params["article"]
  erb :form_page
end

post '/article_new/apple' do
  @article = params["article"]
  @url = params["article_url"]
  @source = params["source"]
  @description = params["description"]
   if @description.length <= 20
     erb :form_page
  else
    CSV.open("views/data.csv", "a") do |csv|
      if csv != ''
        csv.puts([@article,@url,@source,@description])
      end
    end
    redirect '/'
  end
end

