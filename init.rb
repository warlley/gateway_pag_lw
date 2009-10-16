require 'gateway_pag_lw'

ActionController::Base.send(:include, GatewayPagLw)
ActionView::Base.send(:include, GatewayPagLw)
