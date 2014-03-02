shared_examples 'faye observable' do

  let(:under) { described_class.to_s.underscore }

  before do
    ENV['FAYE_TEST'] = 'TRUE'
  end

  after do
    ENV['FAYE_TEST'] = ''
  end

  def validate_faye_called(event_type)
    assert_requested :post, "http://127.0.0.1:9292/faye" do |req|
      data = JSON.parse(CGI::unescape(req.body).split('=').last)
      data['channel'] == "/#{under}s" && data['data']['type'] == event_type
    end
  end

  it 'notifies faye on create' do
    stub_request(:post, "http://127.0.0.1:9292/faye")
    create under.to_sym
    validate_faye_called 'created'
  end

  it 'notifies faye on update' do
    stub_request(:post, "http://127.0.0.1:9292/faye")
    obj = create under.to_sym
    obj.save
    validate_faye_called 'updated'
  end

  it 'notifies faye on create' do
    stub_request(:post, "http://127.0.0.1:9292/faye")
    obj = create under.to_sym
    obj.destroy
    validate_faye_called 'deleted'
  end

  it 'does not breaks when faye is not available' do
    stub_request(:post, "http://127.0.0.1:9292/faye").to_raise StandardError
    expect{ create under.to_sym }.to change{described_class.count}.from(0).to(1)
  end


end