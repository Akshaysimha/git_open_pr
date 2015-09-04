require 'uri'
require 'net/http'
require 'json'
require 'pry'

class GitPr
  def self.github_pr(organisation_name, access_token, repo_name)
    uri = URI.parse("https://api.github.com/repos/#{organisation_name}/#{repo_name}/pulls?state=open")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Authorization'] = "token #{access_token}"
    @response = http.request(request)
    pull = JSON.parse(@response.body)
    pulls = []
      pull.each do |p|
        @title = p["title"]
        @creator = p["user"]["login"]
        @updated = p["updated_at"]
        
        pulls << {"title" => @title, "creator" => @creator, "updated at" => @updated}
      end
    pulls
  end
end