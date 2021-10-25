class NewsNotificationsListener < Redmine::Hook::ViewListener

  def view_layouts_base_html_head(context={})
    return stylesheet_link_tag("news_notification", :plugin => "redmine_news_notification", :media => "screen")
  end

  def view_layouts_base_body_bottom(context={})
    if User.current.logged?
      read_ids = NewsNotification.where(["user_id = ?", User.current]).pluck(:news_id)
      read_ids = [0] if read_ids.blank?

      unread_news_all = News.visible
        .includes([:author, :project])
        .where(["#{News.table_name}.id not in (?) and #{News.table_name}.author_id != ? and #{News.table_name}.created_on > ?", read_ids, User.current.id, User.current.created_on])
        .order("#{News.table_name}.created_on DESC")
        .limit(100)

      unread_news = Array.new
      unread_news_all.each do |news|
        unread_news << [news.id, news.title, news.summary, news.author.name, news.created_on.strftime("%Y/%m/%d %H:%M:%S"), news.project.name]
      end

      #Rails.logger.debug unread_news
      #Rails.logger.debug unread_news.count

      tag = [javascript_tag("var news = #{unread_news.to_json}")]
      tag << javascript_include_tag("news_notification.js", :plugin => "redmine_news_notification")
      return tag.join("\n")
    end
  end
end