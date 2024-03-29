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

class NewsNotificationsListener < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(_context = {})
    stylesheet_link_tag('news_notification', plugin: 'redmine_news_notification', media: 'screen')
  end

  def view_layouts_base_body_bottom(_context = {})
    if User.current.logged?
      read_ids = NewsNotification.where(['user_id = ?', User.current]).pluck(:news_id)
      read_ids = [0] if read_ids.blank?

      unread_news_all = News.visible
                            .includes(%i[author project])
                            .where([
                                     "#{News.table_name}.id not in (?) and #{News.table_name}.author_id != ? and #{News.table_name}.created_on > ?", read_ids, User.current.id, User.current.created_on
                                   ])
                            .order("#{News.table_name}.created_on DESC")
                            .limit(100)

      unread_news = []
      unread_news_all.each do |news|
        unread_news << [news.id, news.title, news.summary, news.author.name,
                        news.created_on.strftime('%Y/%m/%d %H:%M:%S'), news.project.name]
      end

      tag = [javascript_tag("var news = #{unread_news.to_json}")]
      tag << javascript_include_tag('news_notification.js', plugin: 'redmine_news_notification')
      tag.join("\n")
    end
  end
end
