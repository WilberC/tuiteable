require 'rails_helper'

describe Api::TuitsController do

	describe 'GET to index' do
		it 'returns http status ok' do
			user = User.create!(username:"Sebas1" ,name: "Sebas", email: "sebas@mail.com", password:"123456")
			get :index, params: { user_id: user }
			expect(response).to have_http_status(:ok)
		end
		# it 'render json with all games' do
		# 	Tuit.create(name: "Game test", category: "main_game", rating: 50)
		# 	get :index
		# 	games = JSON.parse(response.body)
		# 	expect(games.size).to eq 1
		# end
	end
	# describe 'GET to show' do
	# 	it 'returns http status ok' do
	# 		game = Game.create(name: 'New Game', category: "main_game")
	# 		get :show, params: { id: game }
	# 		expect(response).to have_http_status(:ok)
	# 	end
	# end
end