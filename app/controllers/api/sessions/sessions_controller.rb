class Api::Sessions::SessionsController < Devise::SessionsController
	before_action :sign_in_params, only: :create
	before_action :load_user, only: [:create, :update]
	skip_before_action :verify_authenticity_token, only: :create
	#protect_from_forgery with: :null_session, only: :update
	# sign in
	def create
		if @user.valid_password?(sign_in_params[:password])
			#sign_in "user", @user
			render json: {
				messages: "Signed In Successfully",
				is_success: true,
				data: {user: @user}
			}, status: :ok
		else
			render json: {
				messages: "Signed In Failed - Unauthorized",
				is_success: false,
				data: {}
			}, status: :unauthorized
		end
	end

	# def update
	# 	puts "Entro a update"
	# 	@user.authentication_token = nil
	# 	@user.save
	# 	render json: {
	# 		messages: "Authentication token successfully changed.",
	# 		is_success: true,
	# 		data: {user: @user}
	# 	}, status: :ok
	# end

	private
	def sign_in_params
		params.require(:user).permit :email, :password
	end

	def load_user
		@user = User.find_for_database_authentication(email: sign_in_params[:email])
		
		if @user
			return @user
		else
			render json: {
				messages: "Cannot get User",
				is_success: false,
				data: {}
			}, status: :unauthorized
		end
	end
end