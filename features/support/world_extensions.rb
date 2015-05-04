def run_remote(host, command)
  run_simple("vagrant ssh #{host} -c '#{command}'", true, 600)
end
