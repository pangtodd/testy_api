require "rails_helper"

describe "edit a quote route", :type => :request do
  before do
    @quote = Quote.create!(:author => "test_author", :content => "test_content")
    patch "/quotes/#{@quote.id}", params: { :author => "new_author", :content => "new_content" }
  end

  it "updates the author name, and content" do
    get "/quotes/#{@quote.id}"
    expect(JSON.parse(response.body)["author"]).to eq("new_author")
    expect(JSON.parse(response.body)["content"]).to eq("new_content")
  end

  it "returns a updated status" do
    expect(response).to have_http_status(:ok)
  end
end

describe "exceptions work as expected", :type => :request do

  it "throws error if author and content field is empty" do
    @quote = Quote.create!(:author => "test_author", :content => "test_content")
    patch "/quotes/#{@quote.id}", params: { :author => "", :content => "" }
    expect(response).to have_http_status(422)
    expect(JSON.parse(response.body)["message"]).to eq("Validation failed: Content can't be blank, Author can't be blank")
  end
end