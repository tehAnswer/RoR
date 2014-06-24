require "action_view/template"
require "rdiscount"

#ActionView::Template.register_template_handler :rb,
#  lambda { |template| template.source }

ActionView::Template.register_template_handler :rb, :source.to_proc

# This handler is really weak. It can cause syntax errors (unless '}' is escaped)
# and block support is poor. To sum up, it ain't robust!

ActionView::Template.register_template_handler :string,
   lambda { |template| "%Q{#{template.source}}" }

# Markdown handler!
ActionView::Template.register_template_handler :md,
  lambda { |template| "RDiscount.new(#{template.source.inspect}).to_html" }

module Handlers
	module MERB

		def self.erb_handler
			@@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
		end

		def self.call(template)
			compiled_source = erb_handler.call(template)
			if template.formats.include?(:html)
				"RDiscount.new(begin;#{compiled_source};end).to_html"
			else
				compiled_source
			end
		end

	end
end

# Markdown + ERB
 ActionView::Template.register_template_handler :merb, Handlers::MERB


