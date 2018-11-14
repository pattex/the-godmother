class ApplicationController < ActionController::Base
  force_ssl if: Proc.new { Rails.env.production? }
end
