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

class CreateNewsNotifications < ActiveRecord::Migration[4.2]
  def self.up
    create_table :news_notifications, { id: false } do |t|
      t.integer :user_id, null: false
      t.integer :news_id, null: false
      t.datetime :read_on, null: false
    end
    add_index :news_notifications, %i[user_id news_id], unique: true
  end

  def self.down
    drop_table :news_notifications
  end
end
