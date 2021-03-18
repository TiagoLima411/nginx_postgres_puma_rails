SimpleTokenAuthentication.configure do |config|
    config.sign_in_token = false
    config.header_names = { user: { username: 'X-User-Email' } }
    config.identifiers = { user: 'username' }
end