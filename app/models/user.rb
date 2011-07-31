class User
  include MongoMapper::Document

  key :name, String
  many :authorizations

  def self.find_from_auth_hash(hash)
    where('authorizations' => { 
      '$elemMatch' => { 
        'uid'      => hash['uid'],
        'provider' => hash['provider'] }} ).first
  end

  def self.create_from_auth_hash(hash, user = nil)
    user ||= User.new(:name => hash['user_info']['name'])
    user.authorizations << Authorization.new(:uid => hash['uid'],
                                             :provider => hash['provider'])
    user.save!
    user
  end
end
