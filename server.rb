require 'sinatra'
 require 'pg'
# require 'csv'
# require 'redis'
# require 'json'

# def get_connection
#   if ENV.has_key?("REDISCLOUD_URL")
#     Redis.new(url: ENV["REDISCLOUD_URL"])
#   else
#     Redis.new
#   end
# end

# def read_in_art
#   articles = []
#   CSV.foreach('views/data.csv' , headers: true) do |row|
#     articles << row.to_hash
#   end
#   articles.reverse
# end

# def find_articles
#   redis = get_connection
#   serialized_articles = redis.lrange("slacker:articles", 0, -1)

#   articles = []

#   serialized_articles.each do |article|
#     articles << JSON.parse(article, symbolize_names: true)
#   end

#   articles
# end

# def save_article(url, title, description)
#   article = { url: url, title: title, description: description }

#   redis = get_connection
#   redis.rpush("slacker:articles", article.to_json)
# end

def db_connection()
  begin
    connection = PG.connect(dbname: 'slacker_news')

    yield(connection)
  ensure
    connection.close
  end
end

def save_question(title,description,url)
  sql = "INSERT INTO articles (title, description, url, created_at) " +
    "VALUES ($1, NOW())"

  connection = PG.connect(dbname: 'slacker_news')
  connection.exec_params(sql, [title][description][url])
  connection.close
end






get '/' do
  @read = find_articles
  erb :index
end

get '/article_new' do
  @article = params["article"]
  erb :form_page
end

post '/article_new' do
  @article = params["article"]
  @url = params["article_url"]
  # @source = params["source"]
  @description = params["description"]
   if @description.length <= 20
     erb :form_page
  else
      save_article(@url,@article,@description)
    # CSV.open("views/data.csv", "a") do |csv|
    #   if csv != ''
    #     csv.puts([@article,@url,@source,@description])
      # end
    end
    redirect '/'
  end

