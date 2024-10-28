# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render layout: "application", template: "home/index"
  end
end
