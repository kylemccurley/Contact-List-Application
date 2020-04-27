require 'erubis'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yaml'

def load_contacts
  YAML.load_file('contacts.yaml')
end

def format_phone_number(number)
	number = number.to_s
  "(#{number[0..2]}) #{number[3..5]}-#{number[6..9]}"
end

get '/' do
	@categories = load_contacts.keys
	erb :index
end

get '/:category' do
  @category = params[:category]
  @contacts = load_contacts[@category].keys

  erb :category
end

get '/:category/:name' do
	@category = params[:category]
	@name = params[:name]

	data = load_contacts[@category][@name]
	@phone = format_phone_number(data['phone'])
	@email = data['email']

  erb :contact
end