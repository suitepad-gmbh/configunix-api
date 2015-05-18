require 'shellwords'

module V1
  class WebhooksController < BaseController
    # No authorization necessary for webhook
    skip_before_action :doorkeeper_authorize!

    # POST /v1/webhooks/github
    def github
      # We are always answering with a 202
      render json: {}, status: :accepted

      # Skip any further actions unless it is a push
      return unless request.headers['X-GitHub-Event'] == 'push' &&
                    repo_path.present?

      # Reset local changes to Puppet repository and pull changes
      repo = Git.open repo_path
      repo.reset_hard 'HEAD'
      repo.pull

      # Execute post update script, e.g.
      # "cd /etc/puppet/environments/production; librarian-puppet install"
      return unless (script = ENV['puppet_repository_post_update']).present?
      Bundler.with_clean_env do
        Rails.logger.info "Running post update script: #{script}"
        system "bash -c #{Shellwords.escape script}"
      end
    end

    private

    def repo_path
      ENV['puppet_repository_path']
    end
  end
end
