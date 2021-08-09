class SearchesController < ApplicationController  
    def search
      if params[:search].blank?
        redirect_to users_index_path
    else
        @results = Doctor.search(params[:search])
    end
    end  
end
