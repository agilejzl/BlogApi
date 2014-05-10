require 'spec_helper'

describe "articles/index" do
  before(:each) do
    assign(:articles, [
      stub_model(Article,
        :title => "Title",
        :content => "MyText",
        :author_name => "MyAuthor"
      ),
      stub_model(Article,
        :title => "Title",
        :content => "MyText",
        :author_name => "MyAuthor"
      )
    ])
  end

  it "renders a list of articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyAuthor".to_s, :count => 2
  end
end
