vol() {
  volume=$(((65536 * $1 + 99) / 100))

  pacmd set-sink-volume 0 $volume
}
