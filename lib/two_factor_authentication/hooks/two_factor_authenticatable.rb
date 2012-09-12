Warden::Manager.after_authentication do |user, auth, options|
  session = auth.session(options[:scope])

  need_authentication = session[:need_two_factor_authentication] =
    user.respond_to?(:need_two_factor_authentication?) &&
      user.need_two_factor_authentication?(auth.request)

  user.two_factor_authentication! if need_authentication
end
