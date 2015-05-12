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
        list = servers
        list.each { |server| create_or_update_host server }
        delete_terminated_hosts list
        delete_host_but_these list.map(&:id)
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

      def create_or_update_host(server)
        return unless host = find_or_create_host(server)
        host.assign_attributes(
          dns_name:           server.dns_name,
          private_dns_name:   server.private_dns_name,
          private_ip_address: server.private_ip_address,
          public_ip_address:  server.public_ip_address,
          created_at:         server.created_at
        )
        host.save!
      end

      def find_or_create_host(server)
        return false if terminated?(server)
        Host.where(instance_id: server.id).first ||
          Host.new(instance_id: server.id)
      end

      def delete_terminated_hosts(servers)
        servers = servers.select { |server| terminated?(server) }
        Host.where(instance_id: servers.map(&:id)).destroy_all
      end

      def delete_host_but_these(ids)
        table = Host.arel_table
        Host.where(table[:instance_id].not_in ids).destroy_all
      end

      def terminated?(server)
        server.state == 'terminated'
      end
    end
  end
end
