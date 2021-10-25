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

require_dependency 'redmine_news_notification'

Redmine::Plugin.register :redmine_news_notification do
  name 'Redmine News Notification plugin'
  author 'George Harada'
  description 'This is a News Notification plugin for Redmine'
  version '1.0.1'
  # url 'http://example.com/path/to/plugin'
  # author_url 'https://twitter.com/georz'

  menu :account_menu, :nn, '#', caption: '', first: true
end
