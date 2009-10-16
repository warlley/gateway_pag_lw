module GatewayPagLw

  class Boleto < GatewayPagLw::Base
  
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
