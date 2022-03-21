class GamesController < ApplicationController
<<<<<<< HEAD
=======
    require 'httparty'
>>>>>>> Api update
    #these happen before anything else occurs
    before_action :find_game, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]

    def index
        if params[:category].blank?
            #display games in descending order
            @games = Game.all.order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @games = Game.where(:category_id => @category_id).order("created_at DESC")
        end
<<<<<<< HEAD
    end
=======

        #List of free to play PC games from https://github.com/public-apis/public-apis
        response = HTTParty.get("https://www.freetogame.com/api/games?platform=pc")
        responseLoopString = response[0]["title"] if response.code == 200 

        for apiloop in 1..100
            responseLoop = response[apiloop]["title"] if response.code == 200
            responseLoopString = responseLoopString + ", " + responseLoop
        end

        @httpresponse2 = responseLoopString

        #pulling news for specific game pages using steam app ID
        response = HTTParty.get("https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=594650&count=3&maxlength=300&format=json")
        @httpresponse = response.parsed_response["appnews"]["newsitems"] if response.code == 200

        
    end   
>>>>>>> Api update

    def new
        @game = current_user.games.build
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def show
    end

    def create
        @game = current_user.games.build(game_params)
        @game.category_id = params[:category_id]

        #redirect to correct pages based off actions
        if @game.save
            redirect_to root_path
        else 
            render 'new'
        end
    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def update
        #update category too
        @game.category_id = params[:category_id]
        #saving the new information
        if @game.update(game_params)
            redirect_to game_path(@game)
        else
            render 'edit'
        end
    end

    def destroy
        @game.destroy
        redirect_to root_path
    end

    private 

        #take in game parameters
        def game_params
            params.require(:game).permit(:title, :description, :releaseYear, :category_id, :game_img)
        end

        #find game params by using game id to show them when you edit
        def find_game
            @game = Game.find(params[:id])
        end
end
