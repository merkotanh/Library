class HistoriesController < ApplicationController
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
