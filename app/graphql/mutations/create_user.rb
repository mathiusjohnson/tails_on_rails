module Mutations
  class CreateUser < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :first_name, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    type Types::UserType

    def resolve(first_name: nil, auth_provider: nil)
      user = User.create!(
        first_name: first_name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )

      return unless user

      token = AuthToken.token_for_user(user)

      context[:session][:token] = token

      context[:current_user] = user[:email]

      user

    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end