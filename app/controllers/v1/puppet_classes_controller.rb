module V1
  class PuppetClassesController < BaseController
    before_action :find_puppet_class, only: [:show, :update, :destroy]

    # GET /v1/puppet_classes
    def index
      @puppet_classes = PuppetClass.all
      render json: @puppet_classes
    end

    # GET /v1/puppet_classes/1
    def show
      render json: @puppet_class
    end

    # POST /v1/puppet_classes
    def create
      @puppet_class = PuppetClass.create! puppet_class_params
      render json: @puppet_class
    end

    # PATCH /v1/puppet_classes/:id
    def update
      @puppet_class.update! puppet_class_params
      render json: @puppet_class
    end

    # DELETE /v1/puppet_classes/:id
    def destroy
      @puppet_class.destroy!
      head :no_content
    end

    private

    def find_puppet_class
      @puppet_class = PuppetClass.find params[:id]
    end

    def puppet_class_params
      params.require(:puppet_class).permit :name
    end
  end
end
