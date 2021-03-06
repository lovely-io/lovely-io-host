class Document < ActiveRecord::Base
  belongs_to :version

  validates_presence_of   :path, :text
  validates_uniqueness_of :path, :scope => :version_id
  validates_format_of     :path, :with => /^[a-z0-9\/\.\-_]+$/, :allow_blank => true
  validates_length_of     :text, :maximum => 250.kilobytes,  :allow_blank => true

  module Assoc
    def index
      find_by_path('index')
    end

    def api
      where("path LIKE 'docs/%'")
    end

    def demo
      find_by_path('demo')
    end

    def changelog
      find_by_path('changelog')
    end

    def urls
      all.map &:path
    end
  end
end
