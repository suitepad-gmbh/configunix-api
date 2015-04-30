module V1
  class HostsController < BaseController
    before_action :sync_hosts, only: :index
    before_action :find_host, only: %i(show update)

    # GET /v1/hosts
    def index
      @hosts = Host.all

      render json: @hosts
    end

    # GET /v1/hosts/:id
    def show
      render json: @host
    end

    # PATCH /v1/hosts/:id
    def update
      @host.update_attributes! host_params
      render json: @host
    end

    private

    def sync_hosts
      Ec2::Importer.run
    end

    def find_host
      @host = Host.find params[:id]
    end

    def host_params
      params.require(:host).permit :puppet_config
    end
  end
end
