module GatewayPagLw

  class Boleto
  
    def initialize(environment, identification)
      raise "Environment type #{environment} unknown" unless GatewayPagLw::VALID_ENVIRONMENT.include? environment
      
      @identification = identification
      @environment = environment
      
      @lw_params = {
        :identificacao => @identification,
        :ambiente => GatewayPagLw::VALID_ENVIRONMENT[@environment],
        :modulo => 'BOLETOLOCAWEB'
      }
    end
  
    def add(name, value, format = "")

      case value.class.name
        when "Date"
          @lw_params[name] = value.strftime('%d/%m/%Y')
        when "Float"
          @lw_params[name] = format("%.2f", value).gsub('.', ',')
        else
          @lw_params[name] = value.to_s
      end
      
    end
    
    def url
      ret = ""
      @lw_params.each { |p,v| ret << "#{p}=#{v}&" }
      ret[0..ret.size-2]
    end
  
  end

end
