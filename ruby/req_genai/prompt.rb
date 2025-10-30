#importar bibliotecas
require 'net/http'
require 'uri'
require 'json'


#chave da api (gemini)
GeminiKey  = 'SUA_CHAVE_API'


def prompt(texto)


  #url da api, adicionando a chave com a biblioteca URI
  uri = URI.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=#{GeminiKey}")

  #configurando a requisicao
  requisicao = Net::HTTP::Post.new(uri) # tipo de requisicao (post, get, put, delete)
  requisicao["Content-Type"] = "application/json" #tipo de conteudo, no caso json

  #criando o corpo da requisicao
  requisicao.body =  {contents: [{parts: [{text: texto}]}]}.to_json #forma o corpo da requisicao que irá ser enviada (tendo que seguir este formato)

  #fazendo a requisicao
  resposta = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http| #abre a conexão com o servidor e um bloco ruby
    http.request(requisicao) #faz a requisicao
  end

  dados = JSON.parse(resposta.body) #transforma a resposta em json
  return dados["candidates"][0]["content"]["parts"][0]["text"] #imprime a resposta separadando o json para pegar apenas o texto
end