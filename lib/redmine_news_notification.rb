# Plugin Libraries
lib_dir = File.join(File.dirname(__FILE__), 'redmine_news_notification')

lib_subdirs = %w[hooks patches]

lib_subdirs.each do |subdir|
  Dir.glob(File.join(lib_dir, subdir, '**', '*.rb')).each do |file|
    require file
  end
end
