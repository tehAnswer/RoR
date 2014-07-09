require "action_controller"
require "responders/flash"
require "active_support/i18n"
require "responders/http_cache"

module Responders
	class AppResponder < ActionController::Responder
		include Flash
		include HttpCache
	end

	ActionController::Base.responder = Responders::AppResponder
	I18n.load_path << File.expand_path("../responders/locales/en.yml", __FILE__)


end
