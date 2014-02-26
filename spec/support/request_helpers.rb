module RequestHelpers
  def do_post(path, opts = {})
    make_request :post, path, opts
  end

  def do_get(path, opts = {})
    make_request :get, path, opts
  end

  def do_put(path, opts = {})
    make_request :put, path, opts
  end

  def do_delete(path, opts = {})
    make_request :delete, path, opts
  end

  def json_body
    JSON.parse(response.body)
  end

  def status
    response.status
  end

  private

  def make_request(method, path, opts)
    headers = {}

    send(method, path, opts, headers)
  end
end