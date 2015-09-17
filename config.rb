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
set :layout, :page

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


###
# Collections
###
activate :blog do |news|
  news.prefix = "news"
  # blog.permalink = ":year/:month/:day/:title.html"
  # blog.sources = ":year-:month-:day-:title.html"
  # blog.taglink = "tags/:tag.html"
  news.layout = "news"
  news.summary_separator = /<!--\s?more\s?-->/
  news.summary_length = BigDecimal::INFINITY
  # blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  news.default_extension = ".md"
  news.sources = ":year-:month-:day-:title.html"

  # news.tag_template = "tag.html"
  # news.calendar_template = "calendar.html"

  news.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/:num"
end

configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload
  
  # support run from local directory (favicons not supported)
  activate :relative_assets
  set :relative_links, true
  
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
  
  # temporary block most pages
  ignore /test/
  ignore /model-eu/
  ignore /news/
  ignore /city/
  ignore /partners/
  ignore /participating/
  
  
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  
  # Make favicons
  # use: https://github.com/follmann/middleman-favicon-maker
  activate :favicon_maker do |maker|
    maker.output_dir = "#{config[:build_dir]}/#{config[:images_dir]}"
    maker.icons = {
      "_favicon-base.png" => [
        { icon: "ms-touch-icon-144x144-precomposed.png", size: "144x144"},
        { icon: "apple-touch-icon-114x114-precomposed.png", size: "114x114" },
        { icon: "apple-touch-icon-72x72-precomposed.png", size: "72x72" },
        { icon: "apple-touch-icon-57x57-precomposed.png", size: "57x57" },
        { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
        { icon: "apple-touch-icon.png", size: "57x57" },
        { icon: "favicon.png", size: "16x16" },
        { icon: "favicon.ico", size: "16x16" },
      ]
    }
  end
  
  
  # Enable cache buster
  activate :asset_hash

  # set :http_prefix, '/meu-strasbourg' # if the homepage is not in the root folder but in a subdirectory
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