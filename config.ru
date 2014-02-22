require "./app"

map(App.pinion.mount_point) { run App.pinion }
map("/") { run App }
