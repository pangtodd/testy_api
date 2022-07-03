require "rails_helper"

describe "delete a quote route", :type => :request do
  before do
    @quote = Quote.create!(:author => "test_author", :content => "test_content")
    delete "/quotes/#{@quote.id}", params: { :author => "new_author", :content => "new_content" }
  end

  it "deletes the quote" do
    expect(response).to have_http_status(202)
    expect(JSON.parse(response.body)["message"]).to eq("This quote has been successfully deleted.")
  end
end