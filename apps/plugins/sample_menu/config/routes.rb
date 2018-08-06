Rails.application.routes.draw do

    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        namespace :plugins do
          namespace 'sample_menu' do
            get 'index' => 'front#index'
          end
        end
      end

      #Admin Panel
      scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
        namespace 'plugins' do
          namespace 'sample_menu' do
            controller :admin do
              get :index
              get :settings
              post :save_settings
            end
            resources :job_divisions, controller: 'admin/job_divisions'
          end
        end
      end

      # main routes
      #scope 'sample_menu', module: 'plugins/sample_menu/', as: 'sample_menu' do
      #  Here my routes for main routes
      #end
    end
  end
