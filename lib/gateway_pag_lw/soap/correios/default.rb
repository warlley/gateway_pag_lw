require 'xsd/qname'

# {http://tempuri.org/}Correios
class Correios
  @@schema_type = "Correios"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["cepOrigem", "SOAP::SOAPString"], ["cepDestino", "SOAP::SOAPString"], ["peso", "SOAP::SOAPString"], ["volume", "SOAP::SOAPString"], ["codigo", "SOAP::SOAPString"]]

  attr_accessor :cepOrigem
  attr_accessor :cepDestino
  attr_accessor :peso
  attr_accessor :volume
  attr_accessor :codigo

  def initialize(cepOrigem = nil, cepDestino = nil, peso = nil, volume = nil, codigo = nil)
    @cepOrigem = cepOrigem
    @cepDestino = cepDestino
    @peso = peso
    @volume = volume
    @codigo = codigo
  end
end

# {http://tempuri.org/}CorreiosResponse
class CorreiosResponse
  @@schema_type = "CorreiosResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["correiosResult", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "CorreiosResult")]]]

  def CorreiosResult
    @correiosResult
  end

  def CorreiosResult=(value)
    @correiosResult = value
  end

  def initialize(correiosResult = nil)
    @correiosResult = correiosResult
  end
end

# {http://tempuri.org/}CorreiosXml
class CorreiosXml
  @@schema_type = "CorreiosXml"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["cepOrigem", "SOAP::SOAPString"], ["cepDestino", "SOAP::SOAPString"], ["peso", "SOAP::SOAPString"], ["volume", "SOAP::SOAPString"], ["codigo", "SOAP::SOAPString"]]

  attr_accessor :cepOrigem
  attr_accessor :cepDestino
  attr_accessor :peso
  attr_accessor :volume
  attr_accessor :codigo

  def initialize(cepOrigem = nil, cepDestino = nil, peso = nil, volume = nil, codigo = nil)
    @cepOrigem = cepOrigem
    @cepDestino = cepDestino
    @peso = peso
    @volume = volume
    @codigo = codigo
  end
end

# {http://tempuri.org/}CorreiosXmlResponse
class CorreiosXmlResponse
  @@schema_type = "CorreiosXmlResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["correiosXmlResult", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "CorreiosXmlResult")]]]

  def CorreiosXmlResult
    @correiosXmlResult
  end

  def CorreiosXmlResult=(value)
    @correiosXmlResult = value
  end

  def initialize(correiosXmlResult = nil)
    @correiosXmlResult = correiosXmlResult
  end
end
