require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise "Migrations are pending. Run 'rake db:migrate' to resolve this issue."
end

use Rack::MethodOverride

run ApplicationController
use RepairsController
use AccessoriesController
use InstrumentsController
use UsersController
