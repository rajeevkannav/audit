Rails.application.routes.draw do

  mount Audit::Engine => "/audit"
end
