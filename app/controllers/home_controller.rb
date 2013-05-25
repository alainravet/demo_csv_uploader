class HomeController < ApplicationController
  def index
    @uploaded_files = CsvFile.all
  end
  def demo
  end
end
