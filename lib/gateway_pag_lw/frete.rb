require 'nokogiri'
require 'open-uri'

module GatewayPagLw

  class Frete

    VALID_MODALIDADES = {
      :sedex   => ['40010', 'Sedex'],
    }
    
    URL_CORREIOS = "http://www.correios.com.br/encomendas/precos/calculo.cfm?resposta=xml&"
    
    def self.calculate(cep_origem, cep_destino, peso, modalidade = :sedex)

      raise "Modalidade #{modalidade} unknown" unless VALID_MODALIDADES.include?(modalidade)

      xml = Nokogiri::XML(open(URL_CORREIOS+"servico=#{VALID_MODALIDADES[modalidade][0]}&cepOrigem=#{cep_origem}&cepDestino=#{cep_destino}&peso=#{peso.to_s}"))

      if xml.search('//calculo_precos//erro//codigo').text == '0'
        { 
          :retorno       => 'OK', 
          :valor         => xml.search('//calculo_precos//dados_postais//preco_postal').text.to_f, 
          :uf_origem     => xml.search('//calculo_precos//dados_postais//uf_origem').text,
          :local_origem  => xml.search('//calculo_precos//dados_postais//local_origem').text,
          :uf_destino    => xml.search('//calculo_precos//dados_postais//uf_destino').text,
          :local_destino => xml.search('//calculo_precos//dados_postais//local_destino').text
          
        }
      else
        {
          :retorno   => 'ERRO',
          :codigo    => xml.search('//calculo_precos//erro//codigo').text,
          :descricao => xml.search('//calculo_precos//erro//descricao').text
        }
      end
    
    end  
    #rescue
    #  {
    #    :retorno => 'ERRO',
    #    :descricao => 'Problema durante a tentativa de conexão com o webservice'
    #  }
    #end
    
  end

end
