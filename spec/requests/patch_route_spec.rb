require "rails_helper"

 describe "edit a quote route", :type => :request do

  it "updates the author name" do
    @quote = Quote.create!(:author => "test_author", :content => "test_content")
    patch "/quotes/#{@quote.id}", params: {:author => "new_author", :content => "test_content"}
    get "/quotes/#{@quote.id}"
    expect(JSON.parse(response.body)["author"]).to eq("new_author")
  end
end