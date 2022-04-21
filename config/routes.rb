# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sheets, only: :index do
    resources :shortcuts, only: :index
  end
end
