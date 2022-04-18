# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sheets, only: :index
end
