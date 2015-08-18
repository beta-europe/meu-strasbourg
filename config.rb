Time.zone = data.site.time_zone

set :css_dir,               'css'
set :js_dir,                'js'
set :images_dir,            'img'
set :fonts_dir,             'fonts'
set :snippets_dir,          'snippets'

# Slim template engine
require 'slim'

# explicit require of sass as suggested by 'tilt'
require 'sass'

###
# Page options, layouts, aliases and proxies
###

activate :directory_indexes
set :trailing_slash, true
activate :relative_assets
set :relative_links, true

ignore /.*\.kate-swp/
ignore /.*\.new/
ignore /.*\.backup/

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def resource_active?(resource)    
    # active = Regexp === resource. ? current_page.url =~ active_url : current_page.url == active_url
    current_page.url.include?(resource.url)
  end
  
  def nav_link(name, url, options={})
    options = {
      class: "",
      active_if: url,
      page: current_page.url,
    }.update options
    active_url = options.delete(:active_if)
    active = Regexp === active_url ? current_page.url =~ active_url : current_page.url == active_url
    options[:class] += " active" if active

    link_to name, url, options
  end
  
  def snippet file
    partial "#{config.snippets_dir}/#{file}"
  end
  
  def nav_title page
    page.data[:navigation_title] || page.data.title || page.url
  end
end

configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload
  
  # Slim configuration
  set :slim, {
    format: :html,
    indent: '    ',
    pretty: true,
    sort_attrs: false
  }
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

# activate :deploy do |deploy|
#   deploy.method = :rsync
#   deploy.host   = ENV['DEPLOY_HOST']
#   deploy.path   = ENV['DEPLOY_PATH']
#   deploy.clean  = true
# end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.remote   = 'git@github.com:beta-europe/meu-strasbourg.git'
end