class Authorization
  include MongoMapper::EmbeddedDocument

  key :provider, String
  key :uid, String

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
end
