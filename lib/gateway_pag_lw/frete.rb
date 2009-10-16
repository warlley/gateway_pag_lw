require 'nokogiri'
require File.dirname(__FILE__)+'/soap/correios/defaultDriver'

module GatewayPagLw

  class Frete

    VALID_MODALIDADES = {
      :sedex   => ['40096', 'Sedex'],
      :e_sedex => ['81019', 'E-Sedex'],
      :pac     => ['41025', 'PAC Normal'],
      :pac_tab => ['41068', 'PAC Tabelas com pesos cúbicos']
    }
    
    def self.calculate(cep_origem, cep_destino, peso, volume, modalidade)

      raise "Modalidade #{modalidade} unknown" unless VALID_MODALIDADES.include?(modalidade)

      response = FreteSoap.new.correiosXml( 
        :cepOrigem => cep_origem,
        :cepDestino => cep_destino,
        :peso => peso.to_s.gsub('.', ','),
        :codigo => VALID_MODALIDADES[modalidade][0],
        :volume => volume.to_s.gsub('.', ',')
      )

      xml = Nokogiri::XML(response.CorreiosXmlResult)

      if xml.search('//CalculoFrete//retorno').text == 'OK'
        { 
          :retorno => xml.search('//CalculoFrete//retorno').text, 
          :valor => xml.search('//CalculoFrete//valor').text.gsub('.', '').gsub(',', '.').to_f, 
          :codigo => xml.search('//CalculoFrete//codigo').text
        }
      else
        {
          :retorno => xml.search('//CalculoFrete//retorno').text,
          :descricao => xml.search('//CalculoFrete//descricao').text
        }      
      end
      
    rescue
      {
        :retorno => 'ERRO',
        :descricao => 'Problema durante a tentativa de conexão com o webservice'
      }
    end
    
  end

end
