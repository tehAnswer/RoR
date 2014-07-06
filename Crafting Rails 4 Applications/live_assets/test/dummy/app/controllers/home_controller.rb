class HomeController < ApplicationController
  def index
    render text: "Just gimme the money, okay?", layout: true
  end
end