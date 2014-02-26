require "bundler/setup"
require "pathological"
require "sinatra/base"
require "sinatra/reloader"
require "bourbon"
require "coffee-script"
require "pinion"
require "pinion/sinatra_helpers"
require "uglifier"

require "lib/script_environment"

class App < Sinatra::Base

  set :pinion, Pinion::Server.new("/assets")
  configure do
    pinion.convert scss: :css
    pinion.convert coffee: :js
    pinion.watch "public"
    pinion.watch "#{Gem.loaded_specs["bourbon"].full_gem_path}/app/assets/stylesheets"


    pinion.create_bundle :vendor_js, :concatenate_and_uglify_js, [
      "/vendor/jquery-1.11.0.js"
    ]
    pinion.create_bundle :app_js, :concatenate_and_uglify_js, [
      "/javascripts/app.js"
    ]
  end

  configure :development do
    STDOUT.sync = true
    enable :logging
    set :show_exceptions, false
    set :dump_errors, false

    error do
      content_type "text/plain"
      error = request.env["sinatra.error"]
      message = ([error.class, error.message] + error.backtrace).join("\n")
      puts message
      message
    end

    register Sinatra::Reloader
    also_reload "lib/*.rb"
    also_reload "models/*.rb"
    also_reload "environment.rb"
  end

  configure :test do
    set :show_exceptions, false
    set :dump_errors, false
  end

  helpers Pinion::SinatraHelpers

  disable :static # Pinion will handle static routes
  set :views, "views"
  enable "sessions"

  get "/" do
    erb :index, layout: :layout
  end

  get "/hello.json" do
    content_type "application/json"
    { hello: "world" }.to_json
  end
end
