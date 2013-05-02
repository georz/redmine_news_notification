require_dependency 'news_controller'

module NewsNotifications
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :show, :read_check
    end
  end

  module InstanceMethods
    def show_with_read_check
      read_check = NewsNotification.where(
        :user_id => User.current.id,
        :news_id => params[:id]).first

      NewsNotification.create(
        :user_id => User.current.id,
        :news_id => params[:id],
        :read_on => Time.now.to_s(:db)) if read_check.nil?

      show_without_read_check
    end
  end
end

NewsController.send(:include, NewsNotifications)