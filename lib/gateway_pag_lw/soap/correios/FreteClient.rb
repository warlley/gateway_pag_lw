#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/defaultDriver.rb'

endpoint_url = ARGV.shift
obj = FreteSoap.new(endpoint_url)

# run ruby with -d to see SOAP wiredumps.
obj.wiredump_dev = STDERR if $DEBUG

# SYNOPSIS
#   Correios(parameters)
#
# ARGS
#   parameters      Correios - {http://tempuri.org/}Correios
#
# RETURNS
#   parameters      CorreiosResponse - {http://tempuri.org/}CorreiosResponse
#
parameters = nil
puts obj.correios(parameters)

# SYNOPSIS
#   CorreiosXml(parameters)
#
# ARGS
#   parameters      CorreiosXml - {http://tempuri.org/}CorreiosXml
#
# RETURNS
#   parameters      CorreiosXmlResponse - {http://tempuri.org/}CorreiosXmlResponse
#
parameters = nil
puts obj.correiosXml(parameters)


endpoint_url = ARGV.shift
obj = FreteSoap.new(endpoint_url)

# run ruby with -d to see SOAP wiredumps.
obj.wiredump_dev = STDERR if $DEBUG

# SYNOPSIS
#   Correios(parameters)
#
# ARGS
#   parameters      Correios - {http://tempuri.org/}Correios
#
# RETURNS
#   parameters      CorreiosResponse - {http://tempuri.org/}CorreiosResponse
#
parameters = nil
puts obj.correios(parameters)

# SYNOPSIS
#   CorreiosXml(parameters)
#
# ARGS
#   parameters      CorreiosXml - {http://tempuri.org/}CorreiosXml
#
# RETURNS
#   parameters      CorreiosXmlResponse - {http://tempuri.org/}CorreiosXmlResponse
#
parameters = nil
puts obj.correiosXml(parameters)


