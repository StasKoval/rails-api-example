require 'rails_helper'

describe "ArticlesController", type: :request do
  let(:first_user)  { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user) }
  let(:first_auth)  { ActionController::HttpAuthentication::Token.encode_credentials(first_user.token) }
  let(:second_auth) { ActionController::HttpAuthentication::Token.encode_credentials(second_user.token) }

  let!(:first_article)  { FactoryGirl.create(:article, user_id: first_user.id) }
  let!(:second_article) { FactoryGirl.create(:article, user_id: second_user.id) }

  context "#index" do
    it 'when user is authorized, show index' do
      get '/api/v1/articles', {}, authorization: first_auth

      expect(json_response['articles'].length).to eq(2)
      expect(response.status).to eq(200)
    end

    it 'when user is not authorized, as a guest, show index' do
      get '/api/v1/articles', {}, authorization: nil

      expect(json_response['articles'].length).to eq(2)
      expect(response.status).to eq(200)
    end
  end

  context "#show" do
    it 'when user is authorized, return nothing just auth message' do
      get "/api/v1/articles/#{first_article.id}", {}, authorization: first_auth

      expect(json_response['article']['title']).to eq(first_article.title)
      expect(response.status).to eq(200)
    end

    it 'when user is not authorized, guest, return nothign just error' do
      get "/api/v1/articles/#{first_article.id}", {}, authorization: nil

      expect(json_response['message']).to eq('You are not authorized to access this page.')
      expect(response.status).to eq(200)
    end
  end

  context "#create" do
    let(:params) { {title: 'Hi there', content: 'hello'} }

    it 'when user is not authorized, return nothing just auth message' do
      post '/api/v1/articles', {article: params}, authorization: nil

      expect(response.body).to include('HTTP Token: Access denied')
      expect(response.status).to eq(401)
    end

    it 'when user is authorized and an author of the article, return nothign just error' do
      post '/api/v1/articles', {article: params}, authorization: first_auth

      expect(json_response['article']['content']).to eq('hello')
      expect(response.status).to eq(200)
    end
  end

  context "#update" do
    let(:params) { {id: first_article.id, article: {content: 'ok'}} }

    it 'when user is authorized but not an author of the article, return nothign just auth message' do
      put "/api/v1/articles/#{first_article.id}", params, authorization: second_auth

      expect(json_response['message']).to eq('You are not authorized to access this page.')
      expect(response.status).to eq(200)
    end

    it 'when user is authorized and an author of the article, return nothign just error' do
      put "/api/v1/articles/#{first_article.id}", params, authorization: first_auth

      expect(json_response['article']['content']).to eq(params[:article][:content])
      expect(response.status).to eq(200)
    end

    it 'when user is not authorized, return nothign just auth message' do
      put "/api/v1/articles/#{first_article.id}", params, authorization: nil

      expect(response.body).to include('HTTP Token: Access denied')
      expect(response.status).to eq(401)
    end
  end

  context "#destroy" do
    it 'when user is authorized but not an author of the article, return nothing just auth message' do
      delete "/api/v1/articles/#{first_article.id}", {id: first_article.id}, authorization: second_auth

      expect(json_response['message']).to eq('You are not authorized to access this page.')
      expect(response.status).to eq(200)
    end

    it 'when user is authorized and an author of the article, return nothing just error' do
      delete "/api/v1/articles/#{first_article.id}", {id: first_article.id}, authorization: first_auth

      expect { Article.find(first_article.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(200)
    end

    it 'when user is not authorized, return nothing just auth message' do
      delete "/api/v1/articles/#{first_article.id}", {id: first_article.id}, authorization: nil

      expect(response.body).to include('HTTP Token: Access denied')
      expect(response.status).to eq(401)
    end
  end
end
