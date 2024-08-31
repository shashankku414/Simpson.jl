module Simpson

export simpson

@inline function simpson(y::AbstractArray, x::AbstractArray)
    n = length(x)

    if n % 2 == 1
        h = (x[end] - x[1]) / (n - 1)
        simp_sum = y[1] + y[end]

        @inbounds for i in 2:n-1
            i%2==0 ? simp_sum += 4*y[i] : simp_sum += 2*y[i]
        end
        
        return h / 3 * simp_sum
    else
        h = (x[end-1] - x[1]) / (n - 2)
        simp_sum = y[1] + y[end-1]

        @inbounds for i in 2:n-2
            i%2==0 ? simp_sum += 4*y[i] : simp_sum += 2*y[i]
        end
        trap_last = (x[end] - x[end-1]) * (y[end] + y[end-1]) / 2
        
        return h / 3 * simp_sum + trap_last
    end
end

end # module Simpson
