class FiltersController < ApplicationController
    def filter_story_category
        if defined? params[:category][:id]
            @stories = Story.search_by_category(params[:category][:id])
        else
            @stories = Story.all
        end
        render 'filter_story_category'
    end

    def filter_story_food
        if defined? params[:food][:id]
            @stories = Story.search_by_food(params[:food][:id])
        else
            @stories = Story.all
        end
        render 'filter_story_food'
    end
    
end