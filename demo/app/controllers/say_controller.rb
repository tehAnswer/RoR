class SayController < ApplicationController
  def Hello
  	@time = Time.now
  	@files = Dir.glob('*')
  end

  def goodbye
  end
end
