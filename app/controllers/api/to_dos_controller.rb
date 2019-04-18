module Api
  # the ToDosController for apis
  class ToDosController < ApiController
    # Pagination of todo item list
    def index
      @to_dos = ToDo.all.page params[:page]
      render status: :ok, json: @to_dos.to_a
    end

    def create
      @to_do = ToDo.new(to_do_params)
      if @to_do.valid?
        @to_do.save!
        render status: :created
      else
        render status: :bad_request, json: {}
      end
    end

    def update_status
      @to_do = ToDo.find(params[:id].to_s)
      if @to_do.present?
        update_status_response(params[:status])
      else
        render status: :not_found, json: {}
      end
    end

    def update_status_response(status)
      @to_do.status = status
      if @to_do.valid?
        @to_do.save!
        render status: :ok
      else
        render status: :bad_request, json: {}
      end
    end

    def attach_tag
      @to_do = ToDo.find(params[:id].to_s)
      if @to_do.present?
        tag = Tag.create(name: params[:tag][:name])
        @to_do.update(tag_id: tag.id.to_s)
        render status: :ok
      else
        render status: :not_found, json: {}
      end
    end

    # Modify todo item
    def update
      @to_do = ToDo.find(params[:id].to_s)
      if @to_do.present?
        update_params(params)
      else
        render status: :not_found, json: {}
      end
    end

    def update_params(params)
      add_update_params(params)
      if @to_do.valid?
        @to_do.save!
        render status: :ok
      else
        render status: :bad_request, json: {}
      end
    end

    def add_update_params(params)
      @to_do.name = params[:name] if params[:name].present?
      desc = params[:description]
      @to_do.description = params[:description] if desc.present?
      @to_do.is_deleted = params[:is_deleted] if params[:is_deleted].present?
      @to_do.status = params[:status] if params[:status].present?
    end

    def destroy
      @to_do = ToDo.find(params[:id].to_s)
      if @to_do.present?
        @to_do.update(is_deleted: true)
        render status: :ok
      else
        render status: :not_found, json: {}
      end
    end

    def show
      @to_do = ToDo.find(params[:id].to_s)
      if @to_do.present?        
        render status: :ok
      else
        render status: :not_found, json: {}
      end
    end


    def undo_delete
      @to_do = ToDo.find(params[:id].to_s)
      if @to_do.present?
        @to_do.update(is_deleted: false)
        render status: :ok
      else
        render status: :not_found, json: {}
      end
    end

    private

    def to_do_params
      params.require(:to_do).permit(:name, :description, :status, :tag_id)
    end
  end
end
