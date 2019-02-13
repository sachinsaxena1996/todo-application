module Api
  # the TagsController for apis
  class TagsController < ApiController
    # Find all todo items by tag
    def todos
      @tag = Tag.where(name: params[:tag_name]).first
      if @tag.present?
        @to_dos = @tag.to_dos
        render status: :ok
      else
        render status: :not_found, json: {}
      end
    end
  end
end
