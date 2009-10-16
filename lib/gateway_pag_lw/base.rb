module GatewayPagLw

  class Base
  
    VALID_PAG_TYPES = {:boleto => 'BOLETOLOCAWEB', :visa => nil, :redecard => nil}
    VALID_ENVIRONMENT = {:producao => 'PRODUCAO', :teste => 'TESTE'}

    def initialize(pag_type, environment, identification)
      raise "Payment type #{pag_type} unknown" unless VALID_PAG_TYPES.include? pag_type
      raise "Environment type #{environment} unknown" unless VALID_ENVIRONMENT.include? environment
      
      @pag_type       = pag_type
      @identification = identification
      @environment    = environment
      
      @lw_params = { 
        :identificacao => @identification, 
        :ambiente => VALID_ENVIRONMENT[@environment],
        :modulo => VALID_PAG_TYPES[@pag_type]
      }
    end
  
  end

end
