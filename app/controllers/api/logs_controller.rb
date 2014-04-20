class Api::LogsController < ApplicationController
  def create
    require 'net/http'
    uri = URI.parse("#{App.faye_host}/faye")
    message = { channel: '/logs', data: { type: 'created', message: params[:message] } }
    Net::HTTP.post_form(uri, :message => message.to_json)
    head :ok
  end
end