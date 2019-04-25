class Auth0Controller < ApplicationController
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']

    # Redirect to the URL you want after successful auth
    redirect_to '/admin'
  end

  def logout
    reset_session
    redirect_to logout_url
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end

  private

  def logout_url
    domain = ENV.fetch('AUTH0_DOMAIN')
    client_id = ENV.fetch('AUTH0_ID')
    request_params = {
      returnTo: root_url,
      client_id: client_id
    }

    URI::HTTPS.build(host: domain, path: '/v2/logout', query: URI.encode_www_form(request_params)).to_s
  end
end
