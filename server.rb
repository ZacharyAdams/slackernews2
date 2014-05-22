require 'sinatra'


get '/' do
  erb :index
end


get '/article_new' do

  article = params["article"]

  erb :form_page

end


post '/article_new' do

  article = params["article"]
  url = params["article_url"]
  source = params["source"]

  CSV.open("data.csv", "a") do |csv|
    csv << [article, url, source]
  end
  redirect '/'
end

