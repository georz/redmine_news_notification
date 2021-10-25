# frozen_string_literal: true

require_dependency 'news_notifications_news_controller_patch'
require_dependency 'news_notifications_listener'

Redmine::Plugin.register :redmine_news_notification do
  name 'Redmine News Notification plugin'
  author 'George Harada'
  description 'This is a News Notification plugin for Redmine'
  version '1.0.0'
  # url 'http://example.com/path/to/plugin'
  # author_url 'https://twitter.com/georz'

  menu :account_menu, :nn, '#', caption: '', first: true
end
