# If you roll off old code from your app servers (i.e. the way chef, capistrano,
# basically anyone does it) you need to make sure Unicorn is not looking for
# the Gemfile it was originally started with. It's really important that after
# change you stop/start unicorn after first redeploy.
# After that the "before_exec" block will go in memory and
# wait for the next deploy!
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{root}/Gemfile"
end
