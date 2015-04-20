set :rails_env,   'production'
set :branch,      'production'

role :app,        "exceptions-01.#{rails_env}.pmx-cloud.internal"
role :web,        "exceptions-01.#{rails_env}.pmx-cloud.internal"
role :db,         "exceptions-01.#{rails_env}.pmx-cloud.internal", primary: true
role :whenever,   "exceptions-01.#{rails_env}.pmx-cloud.internal"