require 'spec_helper'
require 'webmock'
require 'pry'

describe "testing git hub response" do 
  it "should return git open pr" do
    organisation_name = "organization_name"
    repo_name = "repo_name"
    access_token = "1234567890"

    stub_request(:get, "https://api.github.com/repos/#{organisation_name}/#{repo_name}/pulls?state=open").to_return(:status => 200, :body => "[{\"title\": \"Test 1\", \"user\": {\"login\": \"user\"}, \"updated_at\": \"2015-08-25T13:31:12Z\"},{\"title\": \"Test 2\", \"user\": {\"login\": \"user\"}, \"updated_at\":\"2015-08-25T13:31:12Z\"}]")
    expect(GitPr.github_pr(organisation_name, access_token, repo_name)).to eq([{"title"=>"Test 1", "creator"=>"user", "updated at"=>"2015-08-25T13:31:12Z"}, {"title"=>"Test 2", "creator"=>"user", "updated at"=>"2015-08-25T13:31:12Z"}])
  end
end