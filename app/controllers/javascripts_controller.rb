class JavascriptController < ApplicationController
	def dynamic_cities
  		@cities = City.all
	end
end