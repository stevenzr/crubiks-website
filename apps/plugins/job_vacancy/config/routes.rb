Rails.application.routes.draw do

    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        namespace :plugins do
          namespace 'job_vacancy' do
            get 'index' => 'front#index'
            #post 'create' => 'front#index'
          end
        end
      end

      #Admin Panel
      scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
        namespace 'plugins' do
          namespace 'job_vacancy' do
            controller :admin do
              post :create #working & this create a routing for create method in form.hrml => post
              get :index
              get :settings
              post :save_settings
            end
            resources :job_divisions, controller: 'admin/job_divisions'
          end
        end
      end

      # main routes
      #scope 'job_vacancy', module: 'plugins/job_vacancy/', as: 'job_vacancy' do
      #  Here my routes for main routes
      #resources :
      
    end
  end
