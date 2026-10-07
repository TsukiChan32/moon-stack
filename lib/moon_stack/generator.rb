require 'fileutils'

module MoonStack
  class Generator
    TEMPLATE_DIR = File.expand_path('../../templates', __dir__)
    VALID_DATABASES = %w[sqlite postgresql mysql].freeze

    def initialize(name, database: 'sqlite')
      @name = name
      @database = database.to_s.downcase
      @destination = File.expand_path(name)

      unless VALID_DATABASES.include?(@database)
        abort "Invalid database: #{@database}. Supported: #{VALID_DATABASES.join(', ')}"
      end
    end

    def run
      abort "Directory already exists: #{@name}" if Dir.exist?(@destination)

      puts
      puts "🌙 Creating #{@name} with #{@database} database..."
      puts

      create_directories
      copy_templates
      configure_database

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

    def configure_database
      return if @database == 'sqlite'

      # Modyfikacja Gemfile
      gemfile_path = File.join(@destination, 'Gemfile')
      gemfile_content = File.read(gemfile_path)

      case @database
      when 'postgresql'
        gemfile_content.gsub!(/gem ['"]sqlite3['"]/, "gem 'pg'")
      when 'mysql'
        gemfile_content.gsub!(/gem ['"]sqlite3['"]/, "gem 'mysql2'")
      end

      File.write(gemfile_path, gemfile_content)
      puts "  update  Gemfile (database: #{@database})"

      # Modyfikacja db.rb
      db_path = File.join(@destination, 'db.rb')
      db_content = File.read(db_path)

      case @database
      when 'postgresql'
        db_content.gsub!(
          /Sequel\.sqlite\(['"]app\.db['"]\)/,
          "Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/#{@name}_db')"
        )
      when 'mysql'
        db_content.gsub!(
          /Sequel\.sqlite\(['"]app\.db['"]\)/,
          "Sequel.connect(ENV['DATABASE_URL'] || 'mysql2://localhost/#{@name}_db')"
        )
      end

      File.write(db_path, db_content)
      puts "  update  db.rb (database: #{@database})"
    end
  end
end
