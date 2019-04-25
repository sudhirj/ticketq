Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    ENV.fetch('AUTH0_ID', 'ID'),
    ENV.fetch('AUTH0_SECRET', 'NOTASECRET'),
    ENV.fetch('AUTH0_DOMAIN', 'ticketq.eu.auth0.com'),
    callback_path: '/auth/oauth2/callback',
    authorize_params: {
      scope: 'openid'
    }
  )
end