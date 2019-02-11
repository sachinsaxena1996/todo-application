module Api
  # the TagsController for apis
  class TagsController < ApiController
    # Find all todo items by tag
    def find_to_dos
      @tag = Tag.where(name: params[:tag_name]).first
      if @tag.present?
        @to_dos = @tag.to_dos
        render status: :ok
      else
        render status: :bad_request, json: {}
      end
    end
  end
end
