#importa as bibliotecas 
require "sinatra"
require "json"
#importa o arquivo que faz a requisição para o gemini, e retorna a response em texto
require_relative 'req_genai/prompt'

#rotas post

post '/piresGpt' do
    #post por meio de requisição json
    json = request.body.read
    texto = JSON.parse(json)
    @txt = prompt(texto['prompt'])
    erb :index
end

post '/piresGpt/:prompt' do 
    #post por meio do parametros
    @txt = prompt(params['prompt'])
    erb :index
end