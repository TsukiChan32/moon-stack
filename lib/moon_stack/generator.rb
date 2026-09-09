require 'fileutils'

module MoonStack
  class Generator
    TEMPLATE_DIR = File.expand_path('../../templates', __dir__)

    def initialize(name)
      @name = name
      @destination = File.expand_path(name)
    end

    def run
      abort "Directory already exists: #{@name}" if Dir.exist?(@destination)

      puts
      puts "🌙 Creating #{@name}..."
      puts

      create_directories
      copy_templates

      puts
      puts 'Moon app ready 🌙'
      puts
      puts 'Run:'
      puts
      puts "  cd #{@name}"
      puts '  bundle install'
      puts '  bundle exec puma'
      puts
    end

    private

    def create_directories
      FileUtils.mkdir_p(@destination)
      FileUtils.mkdir_p(File.join(@destination, 'views'))
      FileUtils.mkdir_p(File.join(@destination, 'public'))
      FileUtils.mkdir_p(File.join(@destination, 'config'))
    end

    def copy_templates
      files = [
        '.gitignore',
        'Gemfile',
        'app.rb',
        'config.ru',
        'db.rb',
        'views/layout.erb',
        'views/index.erb',
        'config/puma.rb'
      ]
      files.each do |file|
        source = File.join(TEMPLATE_DIR, file)
        destination = File.join(@destination, file)

        FileUtils.cp(source, destination)

        puts "  create  #{file}"
      end
    end
  end
end
