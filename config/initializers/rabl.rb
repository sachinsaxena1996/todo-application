Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
  config.view_paths = [Rails.root.join("app/views")]
  config.cache_all_output = false #Rails.env.production?
  config.cache_sources = false #Rails.env.production?
end