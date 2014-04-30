require 'spec_helper'

describe Article do
  context "test fields" do
    before(:each) do
      @post = FactoryGirl.create(:article)
    end

    describe "属性检查" do
      it { should respond_to(:title) }
      it { should respond_to(:content) }
      it { should respond_to(:author_id) }
    end
  end
end
