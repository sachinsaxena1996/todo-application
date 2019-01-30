class Api::ToDosController < ApiController
  
  # Pagination of todo item list
  def index
    @to_dos = ToDo.all
    render status: :ok
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
      @to_do.status = params[:status]
      if @to_do.valid?
        @to_do.save!
        render status: :ok
      else
        render status: :bad_request, json: {}
      end
    else
      render status: :bad_request, json: {}
    end
  end

  # def show
    
  # end

  private

  def to_do_params
    params.require(:to_do).permit(:name, :description, :status, :tag_id)
  end
end
