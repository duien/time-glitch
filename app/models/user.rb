class User
  include MongoMapper::Document

  key :user_name, String   # The name of the human
  key :player_name, String # The name of the glitch
  key :avatar_url, String
  many :authorizations

  def self.find_from_auth_hash(hash)
    where('authorizations' => { 
      '$elemMatch' => { 
        'uid'      => hash['uid'],
        'provider' => hash['provider'] }} ).first
  end

  def self.create_from_auth_hash(hash, user = nil)
    user ||= User.new(:user_name   => hash['user_info']['name'],
                      :player_name => hash['user_info']['nickname'],
                      :avatar_url  => hash['user_info']['image'])
    user.authorizations << Authorization.new(:uid      => hash['uid'],
                                             :provider => hash['provider'],
                                             :token    => hash['credentials']['token'])
    user.save!
    user
  end
end
