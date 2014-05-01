require 'spec_helper'

describe Article do
  context "test fields" do
    before(:each) do
      @article = FactoryGirl.create(:article)
    end

    describe "属性检查" do
      it { should respond_to(:title) }
      it { should respond_to(:content) }
      it { should respond_to(:author_id) }
    end

    describe "方法检查" do
      it "to_hash" do
        article_hash = @article.to_hash
        article_hash.should include(:title)
        article_hash.should include(:content)
        article_hash.should include(:author_id)
      end
    end
  end
end
