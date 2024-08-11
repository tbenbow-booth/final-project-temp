Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"
  #get("/", { :controller => "home", :action => "index" })

  post("/text", { :controller => "home", :action => "text" })

  Rails.application.routes.draw do
  root to: 'home#index'
  post 'text', to: 'home#text'
end

end
