resources :legislation_proposals do
  member do
    get :share
    get :show_pdf
    get :retire_form
  end
end
