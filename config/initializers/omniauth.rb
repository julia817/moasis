Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'],
  	{ :image_size => 'original', :authorize_params => { :lang => 'ja' } }
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'],
  	{ display: 'page', image_size: 'normal' }
  provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET'],
  	{ image_aspect_ratio: 'square', prompt: 'select_account' }
end