# frozen_string_literal: true

require 'bolt/error'
require 'bolt/puppetdb/client'
require 'bolt/puppetdb/config'

module Bolt
  class PuppetDBError < Bolt::Error
    def initialize(msg)
      super(msg, "bolt/puppetdb-error")
    end
  end

  class PuppetDBFailoverError < PuppetDBError; end
end
