# The Ec2::Importer is fetching informations about EC2 instances on AWS and is
# importing them into the local model database.
#
# Example
# =======
#
# ```ruby
# Ec2::Importer.run
# ```
module Ec2
  class Importer
    class <<self
      def run
        servers.each do |server|
          host = Host.where(instance_id: server.id).first
          host ||= Host.new(instance_id: server.id)
          host.assign_attributes(
            dns_name:           server.dns_name,
            private_dns_name:   server.private_dns_name,
            private_ip_address: server.private_ip_address,
            public_ip_address:  server.public_ip_address,
            created_at:         server.created_at
          )
          host.save!
        end
      end

      private

      # returns all servers
      def servers
        connection.servers
      end

      # returns a conneciton
      def connection
        @_connection ||= Fog::Compute.new(
          provider: 'AWS',
          aws_access_key_id: ENV['aws_access_key_id'],
          aws_secret_access_key: ENV['aws_secret_access_key'],
          region: ENV['region']
        )
      end
    end
  end
end
