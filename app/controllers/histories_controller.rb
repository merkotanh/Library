class HistoriesController < ApplicationController
  # before_action :find_history, only: [:show]
  def index
  	@history = History.all
  end

  def show
    @history = History.last
  end

  private
    def find_history
      @history = History.find(params[:id])
    end

end
