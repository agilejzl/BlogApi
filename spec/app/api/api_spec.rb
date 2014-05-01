require 'spec_helper'

describe Blog::API do
  let(:author) { Author.create(:name => 'zs') }
  let(:article) { FactoryGirl.create(:article, title: 'Sample Title', content: "Sample Content", author_id: author.id) }

  describe "GET /v1/articles" do
    it "returns an empty array of articles" do
      get "/v1/articles"
      response.status.should == 200
      JSON.parse(response.body).should == []
    end
  end

  describe "GET /v1/articles/:id" do
    it "returns an article by id" do
      get "/v1/articles/#{article.id}"

      response.content_type.should == 'application/json'
      response.status.should == 200
      response_article = Article.new
      response_article.from_json(response.body)
      response_article.should eq(article)
    end

    context "with wrong article_id" do
      it "should not return article info" do
        get "/v1/articles/WRONG_ID"

        response.content_type.should == 'application/json'
        response.status.should_not == 200
      end
    end
  end

  describe "POST /v1/articles" do
    it "should create an article" do
      params = { :article => article.to_hash }
      post "/v1/articles", params
       
      created_article = author.articles.last
      created_article.should_not eq nil
      created_article.title.should eq "Sample Title"
      created_article.content.should eq "Sample Content"

      response.content_type.should == 'application/json'
      response.status.should == 201
      response_article = Article.new
      response_article.from_json(response.body)
      response_article.should eq(created_article)
    end

    it "should not allow create empty article" do
      # post "/v1/articles", { article: { title: "" } }
      # author.should have(0).articles

      # response.content_type.should == 'application/json'
      # response.status.should_not == 200
    end

    describe "PUT /v1/articles" do
      it "should update an exist article" do
        article.title = 'updated'
        params = { :article => article.to_hash }
        put "/v1/articles", params.merge!(:id => article.id)
         
        updated_article = Article.find(params[:id])
        updated_article.should_not eq nil
        # updated_article.title.should eq "updated"

        response.content_type.should == 'application/json'
      end
    end

    describe "DELETE /v1/articles" do
      it "delete an article by id" do
        delete "/v1/articles/#{article.id}"

        Article.find_by(:id => article.id).should == nil
        response.content_type.should == 'application/json'
        response.status.should == 200
      end

      context "with wrong article_id" do
        it "should not return article info" do
          delete "/v1/articles/WRONG_ID"

          response.content_type.should == 'application/json'
          response.status.should_not == 200
        end
      end
    end
  end
end