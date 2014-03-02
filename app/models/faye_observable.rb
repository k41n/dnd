module FayeObservable
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      after_create :notify_created
      after_update :notify_updated
      after_destroy :notify_deleted
    end
  end

  module InstanceMethods
    def channel_name
      @channel_name || "/#{self.class.to_s.underscore}s"
    end

    def object_name
      @object_name || self.class.to_s.underscore.to_sym
    end

    def notify_created
      message = {:channel => channel_name, :data => { :type => 'created', object_name => as_json } }
      send_message(message)
    end

    def notify_updated
      message = {:channel => channel_name, :data => { :type => 'updated', object_name => as_json } }
      send_message(message)
    end

    def notify_deleted
      message = {:channel => channel_name, :data => { :type => 'deleted', object_name => as_json } }
      send_message(message)
    end

    def send_message(message)
      return if Rails.env.test? && ENV['FAYE_TEST']!='TRUE'
      require 'net/http'
      uri = URI.parse("#{App.faye_host}/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
    rescue
      Rails.logger.info 'Failed to notify Faye'
      Rails.logger.info $!.message
      Rails.logger.info $!.backtrace.join("\n")
    end

  end
end