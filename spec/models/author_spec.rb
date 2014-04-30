require 'spec_helper'

describe Author do
  context "test fields" do
    before(:each) do
      @post = FactoryGirl.create(:author)
    end

    describe "属性检查" do
      it { should respond_to(:name) }
    end
  end
end
