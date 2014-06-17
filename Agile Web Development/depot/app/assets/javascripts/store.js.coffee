# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready", ->
	$('.media').children('.pull-left').children('.media-object').click ->
		$(this).parent().parent().find(':submit').click()