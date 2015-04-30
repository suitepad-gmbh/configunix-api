Rails.application.routes.draw do
  use_doorkeeper

  api_version module: 'V1',
              path: { value: 'v1' },
              defaults: { format: :json } do

    resources :hosts, except: %i(new edit)
  end
end
