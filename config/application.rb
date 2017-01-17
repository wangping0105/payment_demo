require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PaymentDemo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += Dir[Rails.root.join("app/models/addresses")]
    # Timezone
    config.time_zone = 'Beijing'

    # Locale
    config.i18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:'zh-CN', :zh, :en]
    config.i18n.default_locale = :'zh-CN'

    # Sass
    config.sass.preferred_syntax = :sass

    config.active_job.queue_adapter = :sidekiq

    config.action_mailer.raise_delivery_errors = true     #注意，在development.rb下需修改成true
    #添加如下几行代码
    config.action_mailer.default_url_options = { :host => "localhost:3000" } #提示中有提到需要配置，即执行rails g devise:install
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address => "smtp.qq.com",  #smtp.qq.com
      :port => 25,
      :domain => "qq.com",   #qq.com
      :authentication => :login,
      :user_name => ENV["MANDRILL_USERNAME"], #修改邮箱
      :password => ENV["MANDRILL_API_KEY"] #修改正确的密码
    }
  end
end