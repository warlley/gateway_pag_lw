require 'mechanize'

module GatewayPagLw

  class Visa
    
    VALID_PAYMENT_TYPES = {'10' => 'A VISTA', '20' => 'COM JUROS DO LOJISTA', '30' => 'COM JUROS DO EMISSOR'}
    URL_REQUEST = 'https://comercio.locaweb.com.br/comercio.comp'
    
    def initialize(environment, identification, options)
      raise "Environment type #{environment} unknown" unless GatewayPagLw::VALID_ENVIRONMENT.include? environment
      
      @identification = identification
      @environment = environment
      
      @options = options.reverse_merge(
        :tipo_pagamento => '10', 
        :operacao       => 'Pagamento',
        :parcelas       => '01',
        :visa_antipopup => '1',
        :authenttype    => '0',
        :free           => '',
        :language       => 'pt',
        :bin            => ''
      )
      
      validate_options
      
      @request_params = {
        :identificacao  => @identification,
        :ambiente       => GatewayPagLw::VALID_ENVIRONMENT[@environment],
        :modulo         => 'VISAVBV',
        :operacao       => @options[:operacao],
        :tid            => generate_transaction_code,
        :orderid        => @options[:orderid],
        :order          => @options[:order],
        :price          => format("%.2f", @options[:price]).gsub('.', ''),
        :damount        => 'R$ '+format("%.2f", @options[:price]).gsub('.', ','),
        :tipo_pagamento => @options[:tipo_pagamento],
        :operacao       => @options[:operacao],
        :parcelas       => @options[:parcelas],
        :visa_antipopup => @options[:visa_antipopup],
        :authenttype    => @options[:authenttype],
        :free           => @options[:free],
        :language       => @options[:language],
        :bin            => @options[:bin]
      }
    end
    
    def generate_transaction_code

      now = Time.now; v = {        
        :numero_filiacao   => @options[:numero_filiacao][5..9],
        :ultimo_digito_ano => now.strftime('%Y')[3..3],
        :data_juliana      => now.strftime('%j'),
        :hora              => now.strftime('%H'),
        :minutos           => now.strftime('%M'),
        :segundos          => now.strftime('%S'),
        :decimo_de_segundo => second_decimal(now),
        :tipo_pagamento    => @options[:tipo_pagamento],
        :parcelas          => @options[:parcelas]        
      }

      v[:numero_filiacao]+v[:ultimo_digito_ano]+v[:data_juliana]+v[:hora]+v[:minutos]+v[:segundos]+v[:decimo_de_segundo]+v[:tipo_pagamento]+v[:parcelas]
    end
    
    def form_transaction_request(image)
      <<FORM_FIELDS
<form name="visaVBV" method="POST" action="#{URL_REQUEST}">
  <input type="hidden" name="identificacao" value="#{@request_params[:identificacao]}">
  <input type="hidden" name="ambiente" value="#{@request_params[:ambiente]}">
  <input type="hidden" name="modulo" value="#{@request_params[:modulo]}">
  <input type="hidden" name="operacao" value="#{@request_params[:operacao]}">
  <input type="hidden" name="tid" value="#{@request_params[:tid]}">
  <input type="hidden" name="orderid" value="#{@request_params[:orderid]}">
  <input type="hidden" name="order" value="#{@request_params[:order]}">
  <input type="hidden" name="price" value="#{@request_params[:price]}">
  <input type="hidden" name="damount" value="#{@request_params[:damount]}">
  <input type="hidden" name="visa_antipopup" value="#{@request_params[:visa_antipopup]}">
  <input type="hidden" name="authenttype" value="#{@request_params[:authenttype]}">
  <input type="hidden" name="free" value="#{@request_params[:free]}">
  <input type="hidden" name="language" value="#{@request_params[:language]}">
  <input type="hidden" name="bin" value="#{@request_params[:bin]}">
  <input type="image" src="#{image}" value="submit">
</form>
FORM_FIELDS
    end
    
    def request_second_post(url_return, tid)
      
      agent = WWW::Mechanize.new

      agent.post(URL_REQUEST, {
        :identificacao  => @identification,
        :ambiente       => GatewayPagLw::VALID_ENVIRONMENT[@environment],
        :modulo         => 'VISAVBV',
        :operacao       => 'Retorno',
        :tid            => tid,
        :URLRetornoVisa => url_return
      })
    end
    
    private
      
      def validate_options
        raise "Options without numero_filiacao value Hash" unless @options[:numero_filiacao]
        raise "Options without price value Hash" unless @options[:price]
        raise "Options without orderid value Hash" unless @options[:orderid]
        raise "Options without order value Hash" unless @options[:order]
      end     
      
      def second_decimal(now)
        format('%0.1f', now.to_f - now.to_i)[2..2]
      end

  end

end
