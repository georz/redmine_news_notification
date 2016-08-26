# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'news_notifications/:action', :to => 'news_notifications'
end
