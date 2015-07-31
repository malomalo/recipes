require "rubygems"
require "bundler/setup"
Bundler.require(:default)

module Jekyll
  module Utils
    def self.has_yaml_header?(file)
      if File.basename(file).end_with?('.mdown')
        true
      else
        !!(File.open(file, 'rb') { |f| f.read(5) } =~ /\A---\r?\n/)
      end
    end
  end
  
  class Page
    def data
      if name.end_with?('.mdown')
        @data ||= {}
        @data['title'] = basename.split('-').map(&:capitalize).join(' ')
      end
      @data
    end
  end
  
end

__END__
Jekyll::Hooks.register :page, :post_init do |page|
  if page.name.end_with?('.mdown')
   page.data['title'] = page.basename.split('-').map(&:capitalize).join(' ')
  end
end