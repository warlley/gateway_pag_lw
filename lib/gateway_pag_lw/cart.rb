module GatewayPagLw

  class Cart

    attr_reader :products, :total, :postal_code, :total_weight, :freight_message

    def initialize
      @products = []
      @total = 0.0
      @total_weight = 0.0
      @postal_code = ''
      @freight = 0.0    
      @freight_message = nil
      @freight_valid = false
    end
    
    def add(product, quantity)
      position = product_position(product.id)
      
      if position == -1
        @products << {:product => product, :quantity => quantity}
      else
        @products[position][:quantity] += quantity
      end
      
      recalculate
    end
    
    def remove(product_id)
      position = product_position(product_id)
      
      unless position == -1
        @products.delete_at(position)
      end
      
      recalculate
    end

    def count
      @products.size
    end
    
    def empty?
      @products.empty?
    end
    
    def postal_code=(postal_code)
      @postal_code = postal_code
      freight_calculate
    end
    
    def postal_code
      @postal_code
    end
    
    def freight=(freight)
      @freight = freight
      recalculate
    end
    
    def freight
      @freight
    end
    
    def freight_valid?
      @freight_valid == true
    end

    def recalculate
      @total = @freight || 0.0
      @total_weight = 0.0      

      @products.each do |p|
        @total += p[:quantity] * p[:product].price
        @total_weight += p[:quantity] * p[:product].weight
      end
    end

    private
    
      def product_position(product_id)
        position = 0
        @products.each do |p|
          return position if p[:product].id == product_id
          position += 1
        end
        
        return -1
      end
      
      def freight_calculate
        
        @freight_valid = false
        @freight_message = nil
        
        city = BuscaEndereco.por_cep(@postal_code)[4] rescue nil

        if city and AppConfig.delivery.freight_cities.include?(city)
          self.freight = 0.0; 
          
          @freight_message = "Frete gratuito"
          @freight_valid = true
        else
          
          if @total_weight <= 30.0            
            f = GatewayPagLw::Frete.calculate(AppConfig.delivery.postal_code, @postal_code, @total_weight, :sedex)

            if f[:retorno] == "OK"
              self.freight = f[:valor]
              
              @freight_valid = true
              @freight_message = ""
            else
              self.freight = 0.0
              
              @freight_valid = false
              @freight_message = f[:descricao]
            end
            
          else
            @freight_message = "O peso está acima de 30KG, o máximo atendido por SEDEX."
          end

        end
        
      end
      
  end

end
