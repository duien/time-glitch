if ENV['MONGOLAB_URI'].present?
  MongoMapper.config = {Rails.env => {'uri' => ENV['MONGOLAB_URI']}}
else
  MongoMapper.config = {Rails.env => {'uri' => "mongodb://localhost/time-glitch-#{Rails.env}" }}
end

MongoMapper.connect(Rails.env)

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
