fun init = crystal_init : Void
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)
end

fun log = call_crystal(text: UInt8*): Void
  puts String.new(text)
end