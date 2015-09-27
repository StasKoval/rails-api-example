require 'rails_helper'

describe "ArticlesController", type: :request do
  let(:first_user)  { FactoryGirl.create(:user, id: 1) }
  let(:second_user) { FactoryGirl.create(:user, id: 2) }

  let!(:first_article)  { FactoryGirl.create(:article, id: 1, user_id: first_user.id) }
  let!(:second_article) { FactoryGirl.create(:article, id: 2, user_id: second_user.id) }

  let(:first_auth)  { ActionController::HttpAuthentication::Token.encode_credentials(first_user.token) }
  let(:second_auth) { ActionController::HttpAuthentication::Token.encode_credentials(second_user.token) }

  context "#index" do
    context "when user is authorized" do
      it 'return nothign just auth message' do
        get '/api/v1/articles', {}, authorization: first_auth

        expect(json_response['articles'].length).to eq(2)
        expect(response.status).to eq(200)
      end
    end

    context "when user is not authorized, guest" do
      it 'return nothign just error' do
        get '/api/v1/articles', {}, authorization: nil

        expect(json_response['articles'].length).to eq(2)
        expect(response.status).to eq(200)
      end
    end
  end

  context "#show" do
    context "when user is authorized" do
      it 'return nothign just auth message' do
        get '/api/v1/articles/1', {}, authorization: first_auth

        expect(json_response['article']['title']).to eq('Hello World!')
        expect(response.status).to eq(200)
      end
    end

    context "when user is not authorized, guest" do
      it 'return nothign just error' do
        get '/api/v1/articles/1', {}, authorization: nil

        expect(json_response['article']['title']).to eq('Hello World!')
        expect(response.status).to eq(200)
      end
    end
  end

  context "#update" do
    context "when user is authorized but not an author of the article" do
      it 'return nothign just auth message' do
        put '/api/v1/articles/1', {id: first_article.id, article: {content: 'ok'}}, authorization: second_auth

        expect(json_response['message']).to eq('You are not authorized to access this page.')
        expect(response.status).to eq(200)
      end
    end

    context "when user is authorized and an author of the article" do
      let(:content) { 'updated content' }

      it 'return nothign just error' do
        put '/api/v1/articles/1', {id: first_article.id, article: {content: content}}, authorization: first_auth

        expect(json_response['article']['content']).to eq(content)
        expect(response.status).to eq(200)
      end
    end

    context "when user is not authorized" do
      it 'return nothign just auth message' do
        put '/api/v1/articles/1', {id: first_article.id, article: {content: 'ok'}}, authorization: nil

        expect(response.body).to include('HTTP Token: Access denied')
        expect(response.status).to eq(401)
      end
    end
  end

  context "#destroy" do
    context "when user is authorized but not an author of the article" do
      it 'return nothign just auth message' do
        delete '/api/v1/articles/1', {id: first_article.id}, authorization: second_auth

        expect(json_response['message']).to eq('You are not authorized to access this page.')
        expect(response.status).to eq(200)
      end
    end

    context "when user is authorized and an author of the article" do
      let(:content) { 'updated content' }

      it 'return nothign just error' do
        delete '/api/v1/articles/1', {id: first_article.id}, authorization: first_auth

        expect { Article.find(first_article.id) }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response.status).to eq(200)
      end
    end

    context "when user is not authorized" do
      it 'return nothign just auth message' do
        delete '/api/v1/articles/1', {id: first_article.id}, authorization: nil

        expect(response.body).to include('HTTP Token: Access denied')
        expect(response.status).to eq(401)
      end
    end
  end
end
