get '/' do
  erb :index
end

get '/greetings' do
  erb :_greetings, { locals: {  name: "World" } }
end

