require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Weebly < OmniAuth::Strategies::OAuth2
      option :name, 'weebly'

      option :client_options, {
        :site => 'https://api.weebly.com/v1',
        :authorize_url => 'https://www.weebly.com/oauth/authorize',
        :token_url => 'https://www.weebly.com/oauth/access_token'
      }

      option :access_token_options, {
        :mode => :query
      }

      option :authorize_params, {
        :scope => 'read:site,write:site'
      }

      def build_access_token
        token_params = {
          :redirect_uri => callback_url.split('?').first,
          :client_id => client.id,
          :client_secret => client.secret
        }
        verifier = request.params['code']
        client.auth_code.get_token(verifier, token_params)
      end

      uid { raw_info['user_id'] }

      info do
        {
          'email' => raw_info['email'],
          'name' => raw_info['name'],
          'language' => raw_info['language']
        }
      end

      def raw_info
        access_token.options[:parse] = :json

        # This way is not working right now, do it the longer way
        # for the time being
        #
        #@raw_info ||= access_token.get('/ap/user/profile').parsed

        url = "/v1/user"
        params = {:headers => {'X-Weebly-Access-Token' => access_token.token}}
        @raw_info ||= access_token.client.request(:get, url, params).parsed
      end
    end
  end
end