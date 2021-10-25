module RedmineNewsNotification
  module Patches
    module NewsControllerPatch
      def self.prepended(base)
        base.send(:prepend, InstanceMethods)
      end

      module InstanceMethods
        def show
          current_user_id = User.current.id
          read_check = NewsNotification.where(
            :user_id => current_user_id,
            :news_id => @news.id
            ).take

          NewsNotification.create(
            :user_id => current_user_id,
            :news_id => @news.id,
            :read_on => Time.now.to_s(:db)
            ) if read_check.nil?
          super
        end
      end
    end
  end
end

# Apply patch
Rails.configuration.to_prepare do
  unless NewsController.included_modules.include?(RedmineNewsNotification::Patches::NewsControllerPatch)
    NewsController.prepend(RedmineNewsNotification::Patches::NewsControllerPatch)
  end
end