require 'addressable/uri'
require 'rest-client'


def create_user
  begin
    url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json',
    # path: '/users',

    ).to_s


    puts RestClient.post(
    url,
    { user: { name: "Gizmo" } }
    )
  rescue RestClient::Exception => e
    raise "Invalid parameters (#{e})!"
  end
end

def update_user
  begin
    url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1',
    # path: '/users',

    ).to_s


    puts RestClient.patch(
    url,
    { user: { name: "Bill Bob", email: "bill@bob.com" } }
    )
  rescue RestClient::Exception => e
    raise "Invalid parameters (#{e})!"
  end
end

def delete_user
  begin
    url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/2',
    # path: '/users',

    ).to_s


    puts RestClient.delete(url)
  rescue RestClient::Exception => e
    raise "Invalid parameters (#{e})!"
  end
end

delete_user
# puts RestClient.get(url)
# puts RestClient.get(url, user: 'Markov')
