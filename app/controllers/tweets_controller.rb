class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    post '/tweet' do
        if !params[:content].empty?
        current_user.tweets << tweet
        current_user.save
        redirect '/tweets'
        else
            redirect to '/tweets/new'
        end
    end

    get '/tweets/new' do
        if logged_in?
            @user = current_user
            erb :'/tweets/create_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @user = current_user
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user == current_user
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
      if !params[:content].empty?
        @tweet.update(:content => params[:content])
        tweet.save
        redirect "tweets/#{params[:id]}"
      else
        redirect "tweets/#{params[:id]}/edit"
        end
    end

    post '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        if current_user == @tweet.user
            @tweet.delete
            redirect to '/tweets'
        else
            redirect to "/tweets/#{params[:id]}"
        end
    end



end
