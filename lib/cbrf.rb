# frozen_string_literal: true

require_relative "cbrf/version"

require "stringio"
require "ox"
require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.collapse("#{__dir__}/cbrf/services")
loader.setup

module Cbrf
  class Error < StandardError; end
  # Your code goes here...
end

loader.eager_load # optionally
