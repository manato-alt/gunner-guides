# frozen_string_literal: true

# This controller handles top-level actions and views.class TopsController < ApplicationController
class TopsController < ApplicationController
  def index
    @logo_urls = Game.order('RAND()').limit(5).pluck(:logo_url)
  end
end
