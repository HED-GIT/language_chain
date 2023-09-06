module julia_call

export call_julia

Base.@ccallable function call_julia(text::Ptr{UInt8})::Cvoid
        println(unsafe_string(text))
end
end