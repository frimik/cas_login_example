CasLogin::Application.routes.draw do
  resource "secured", controller: "secured"
  resource "unsecured", controller: "unsecured"
  resource :sessions

  match "login", to: "sessions#new"
  match "logout", to: "sessions#destroy"
  match "logins", to: "session#create"
  match "validate_login", to: "sessions#validate"

  root to: "unsecured#show"
end
