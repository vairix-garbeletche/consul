Rails.application.routes.draw do

  if Rails.env.development? || Rails.env.staging?
    get '/sandbox' => 'sandbox#index'
    get '/sandbox/*template' => 'sandbox#show'
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  draw :account
  draw :admin
  draw :annotation
  draw :budget
  draw :comment
  draw :community
  draw :debate
  draw :devise
  draw :direct_upload
  draw :document
  draw :graphql
  draw :guide
  draw :legislation
  draw :management
  draw :moderation
  draw :notification
  draw :officing
  draw :poll
  draw :proposal
  draw :related_content
  draw :tag
  draw :user
  draw :valuation
  draw :verification
  draw :legislation_proposal

  root 'welcome#index'
  get '/welcome', to: 'welcome#welcome'
  get '/consul.json', to: "installation#details"

  resources :stats, only: [:index]
  resources :images, only: [:destroy]
  resources :documents, only: [:destroy]
  resources :follows, only: [:create, :destroy]

  # More info pages
  get 'more-information',                     to: 'pages#show', id: 'more_info/index',                as: 'more_info'
  get 'more-information/how-to-use',          to: 'pages#show', id: 'more_info/how_to_use/index',     as: 'how_to_use'
  get 'more-information/faq',                 to: 'pages#show', id: 'more_info/faq/index',            as: 'faq'

  # Static pages
  get '/blog' => redirect("http://blog.consul/")
  resources :pages, path: '/', only: [:show]
end
