# frozen_string_literal: true

require 'swagger_helper'

describe 'Users API' do
  path '/createuser' do
    post 'Create a User' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          email: { type: :string },
          password: { type: :string }

        },
        required: %w[username email password]
      }
      response '201', 'user successfully created' do
        let(:user) { { username: 'akash', email: 'akash@gmail.com', password: 'akash' } }
        run_test!
      end
      response '422', 'list of errors' do
        let(:user) { { username: 'akash' } }
        run_test!
      end
    end
  end

  path '/allusers' do
    post 'Retrive all users details' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {

          email: { type: :string },
          password: { type: :string }

        },
        required: %w[email password]
      }
      response '201', 'list of user details' do
        let(:user) { { username: 'akash', email: 'akash@gmail.com' } }
        run_test!
      end
      response '401', 'invalid credentials' do
        let(:user) { { email: 'akashkarmakar787@gmail.com', password: 'abcde' } }
        run_test!
      end
    end
  end
end
