# frozen_string_literal: true

# This file is part of the Plugin Redmine News Notification.
#
# Copyright (C) 2021 Liane Hampe <liaham@xmera.de>, xmera.
# Copyright (C) 2013 - 2016 George Harada <http://georz.hatenablog.com/>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA

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
            user_id: current_user_id,
            news_id: @news.id
          ).take

          if read_check.nil?
            NewsNotification.create(
              user_id: current_user_id,
              news_id: @news.id,
              read_on: Time.now.to_s(:db)
            )
          end
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
