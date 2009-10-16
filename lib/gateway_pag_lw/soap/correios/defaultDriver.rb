require File.dirname(__FILE__)+'/default.rb'

require 'soap/rpc/driver'

class FreteSoap < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://comercio.locaweb.com.br/correios/frete.asmx"
  MappingRegistry = ::SOAP::Mapping::Registry.new

  Methods = [
    [ "http://tempuri.org/Correios",
      "correios",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "Correios"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "CorreiosResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/CorreiosXml",
      "correiosXml",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "CorreiosXml"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "CorreiosXmlResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = MappingRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end

