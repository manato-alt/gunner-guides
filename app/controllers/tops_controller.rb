class TopsController < ApplicationController
  def index
    @logo_urls = Game.order('RAND()').limit(5).pluck(:logo_url)
  end
end
